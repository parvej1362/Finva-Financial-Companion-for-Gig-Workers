const User = require('../models/User');
const Otp = require('../models/Otp');
const Consent = require('../models/Consent');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const { OAuth2Client } = require('google-auth-library');
const twilio = require('twilio');

const twilioClient = new twilio(process.env.TWILIO_SID, process.env.TWILIO_AUTH_TOKEN);
const googleClient = new OAuth2Client(process.env.GOOGLE_CLIENT_ID);

const sendSMS = async (to, body) => {
    try {
        await twilioClient.messages.create({
            body: body,
            to: to.startsWith('+') ? to : `+91${to}`,
            from: process.env.TWILIO_PHONE
        });
        console.log(`SMS sent to ${to}`);
    } catch (error) {
        console.error('Twilio Error:', error);
    }
};

const generateToken = (user) => {
    return jwt.sign(
        { id: user._id, email: user.email },
        process.env.JWT_SECRET,
        { expiresIn: '30d' }
    );
};

const generateOTP = () => Math.floor(100000 + Math.random() * 900000).toString();

exports.googleLogin = async (req, res) => {
    const { token } = req.body;
    try {
        const ticket = await googleClient.verifyIdToken({
            idToken: token,
            audience: process.env.GOOGLE_CLIENT_ID,
        });
        const payload = ticket.getPayload();
        const { sub, email, name, picture } = payload;

        let user = await User.findOne({
            $or: [{ email: email }, { google_id: sub }]
        });

        if (user) {
            if (!user.google_id) {
                user.google_id = sub;
                user.picture = picture;
                user.is_verified = true;
                await user.save();
            }
        } else {
            user = await User.create({
                name,
                email,
                google_id: sub,
                picture,
                is_verified: true,
            });
        }

        const jwtToken = generateToken(user);

        res.cookie('token', jwtToken, {
            httpOnly: true,
            secure: process.env.NODE_ENV === 'production',
            sameSite: process.env.NODE_ENV === 'production' ? 'none' : 'lax',
            maxAge: 30 * 24 * 60 * 60 * 1000
        });

        res.json({
            message: 'Google login successful',
            user: {
                id: user._id,
                name: user.name,
                email: user.email,
                phone: user.phone,
                picture: user.picture
            }
        });
    } catch (err) {
        console.error('Google Auth Error:', err);
        res.status(401).json({ error: 'Invalid Google Token' });
    }
};

exports.register = async (req, res) => {
    const { name, email, phone, password, dob } = req.body;
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const phoneRegex = /^[6-9]\d{9}$/;

    if (!emailRegex.test(email)) return res.status(400).json({ error: 'Invalid email address' });
    if (!phoneRegex.test(phone)) return res.status(400).json({ error: 'Invalid 10-digit Indian mobile number' });
    if (!password || password.length < 6) return res.status(400).json({ error: 'Password must be at least 6 characters long' });

    try {
        const existingUser = await User.findOne({ $or: [{ email }, { phone }] });
        if (existingUser) {
            return res.status(400).json({ error: existingUser.is_verified ? 'User already exists' : 'User already exists. Please login.' });
        }

        const hashedPassword = await bcrypt.hash(password, 10);

        // Parse DOB robustly
        let parsedDob = null;
        if (dob) {
            // Handle dd-mm-yyyy format
            if (dob.includes('-')) {
                const [d, m, y] = dob.split('-');
                if (d && m && y && y.length === 4) {
                    parsedDob = new Date(`${y}-${m}-${d}`);
                } else {
                    parsedDob = new Date(dob);
                }
            } else {
                parsedDob = new Date(dob);
            }
        }

        const user = await User.create({
            name,
            email,
            phone,
            password_hash: hashedPassword,
            dob: parsedDob || dob,
            is_verified: false
        });

        const otp = generateOTP();
        await Otp.create({
            phone,
            otp_code: otp,
            expires_at: new Date(Date.now() + 10 * 60 * 1000)
        });

        console.log(`[DEV LOG] OTP Generated for ${phone}: ${otp}`);

        res.json({
            message: 'Initial registration successful. Verification SMS sent.',
            userId: user._id,
            phone: user.phone,
            demoOtp: otp
        });
    } catch (err) {
        console.error('Registration Error:', err);
        res.status(500).json({
            error: 'Server error',
            details: err.message,
            stack: process.env.NODE_ENV === 'development' ? err.stack : undefined
        });
    }
};


exports.verifyOtp = async (req, res) => {
    const { phone, otp } = req.body;
    if (!phone || !otp) return res.status(400).json({ error: 'Phone and OTP are required' });

    try {
        const validOtp = await Otp.findOne({
            phone,
            otp_code: otp,
            expires_at: { $gt: new Date() }
        }).sort({ created_at: -1 });

        if (!validOtp) return res.status(400).json({ error: 'Invalid or expired OTP' });

        const user = await User.findOneAndUpdate({ phone }, { is_verified: true }, { returnDocument: 'after' });
        if (!user) return res.status(400).json({ error: 'User not found' });

        await Otp.deleteMany({ phone });

        res.json({
            message: 'Verification successful. Please login to continue.',
            user: {
                id: user._id,
                name: user.name,
                email: user.email,
                phone: user.phone
            }
        });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error' });
    }
};

exports.login = async (req, res) => {
    const { identifier, password } = req.body;
    try {
        if (!process.env.JWT_SECRET) {
            console.error('CRITICAL: JWT_SECRET is not defined in environment variables');
            return res.status(500).json({ error: 'Server configuration error: Missing JWT_SECRET' });
        }

        const user = await User.findOne({ $or: [{ email: identifier }, { phone: identifier }] }).select('+password_hash');
        if (!user) return res.status(400).json({ error: 'User not found' });
        if (!user.is_verified) return res.status(401).json({ error: 'Account not verified. Please complete registration.' });

        if (!user.password_hash) {
            return res.status(400).json({ error: 'Invalid credentials' });
        }

        const isMatch = await bcrypt.compare(password, user.password_hash);
        if (!isMatch) return res.status(400).json({ error: 'Invalid credentials' });

        const otp = generateOTP();
        await Otp.create({
            phone: user.phone,
            otp_code: otp,
            expires_at: new Date(Date.now() + 10 * 60 * 1000)
        });

        console.log(`[DEV LOG] Login OTP for ${user.phone}: ${otp}`);

        res.json({
            message: 'Credentials valid. OTP sent.',
            phone: user.phone,
            demoOtp: otp,
            step: 'otp'
        });
    } catch (err) {
        console.error('Login Error:', err);
        res.status(500).json({ error: 'Server error during login', details: err.message });
    }
};


exports.loginVerifyOtp = async (req, res) => {
    const { phone, otp } = req.body;
    if (!phone || !otp) return res.status(400).json({ error: 'Phone and OTP are required' });

    try {
        const validOtp = await Otp.findOne({
            phone,
            otp_code: otp,
            expires_at: { $gt: new Date() }
        }).sort({ created_at: -1 });

        if (!validOtp) return res.status(400).json({ error: 'Invalid or expired OTP' });

        const user = await User.findOne({ phone });
        if (!user) return res.status(404).json({ error: 'User not found' });

        await Otp.deleteMany({ phone });

        const consent = await Consent.findOne({ user_id: user._id });
        const jwtToken = generateToken(user);

        res.cookie('token', jwtToken, {
            httpOnly: true,
            secure: process.env.NODE_ENV === 'production',
            sameSite: process.env.NODE_ENV === 'production' ? 'none' : 'lax',
            maxAge: 30 * 24 * 60 * 60 * 1000
        });

        res.json({
            message: 'Login successful',
            requiresConsent: !consent,
            user: {
                id: user._id,
                name: user.name,
                email: user.email,
                phone: user.phone
            }
        });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error' });
    }
};

exports.logout = (req, res) => {
    res.clearCookie('token', {
        httpOnly: true,
        secure: process.env.NODE_ENV === 'production',
        sameSite: process.env.NODE_ENV === 'production' ? 'none' : 'lax'
    });
    res.json({ message: 'Logged out successfully' });
};

exports.forgotPassword = async (req, res) => {
    const { identifier } = req.body;
    try {
        const user = await User.findOne({ $or: [{ email: identifier }, { phone: identifier }] });
        if (!user) return res.status(404).json({ error: 'User not found' });

        const otp = generateOTP();
        await Otp.create({
            phone: user.phone,
            otp_code: otp,
            expires_at: new Date(Date.now() + 10 * 60 * 1000)
        });

        // For demo/development, log the OTP
        console.log(`[DEV LOG] Forgot Password OTP for ${user.phone}: ${otp}`);

        res.json({ message: 'OTP sent successfully', phone: user.phone });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error' });
    }
};

exports.resetPassword = async (req, res) => {
    const { phone, otp, newPassword } = req.body;
    try {
        const otpRecord = await Otp.findOne({ phone, otp_code: otp });
        if (!otpRecord) return res.status(400).json({ error: 'Invalid or expired OTP' });

        if (otpRecord.expires_at < new Date()) {
            await Otp.deleteOne({ _id: otpRecord._id });
            return res.status(400).json({ error: 'OTP expired' });
        }

        const salt = await bcrypt.genSalt(10);
        const password_hash = await bcrypt.hash(newPassword, salt);

        await User.findOneAndUpdate({ phone }, { password_hash });
        await Otp.deleteMany({ phone });

        res.json({ message: 'Password reset successful. Please login with your new password.' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error' });
    }
};
