const mongoose = require('mongoose');
const User = require('../models/User');
const Consent = require('../models/Consent');
const Integration = require('../models/Integration');
const PlatformSuggestion = require('../models/PlatformSuggestion');
const SafetyPotGoal = require('../models/SafetyPotGoal');
const BankAccount = require('../models/BankAccount');
const KycDocument = require('../models/Kyc');
const Otp = require('../models/Otp');

const generateOTP = () => Math.floor(100000 + Math.random() * 900000).toString();

exports.saveConsent = async (req, res) => {
    const { earningsConsent, bankConsent } = req.body;
    const userId = req.user.id;

    try {
        await Consent.findOneAndUpdate(
            { user_id: userId },
            {
                earnings_consent: earningsConsent || false,
                bank_consent: bankConsent || false
            },
            { upsert: true, returnDocument: 'after', setDefaultsOnInsert: true }
        );
        console.log(`[USER_ROUTE] Consent updated for user ${userId}`);
        res.json({ message: 'Consent preferences saved successfully' });
    } catch (err) {
        console.error('Error saving consent:', err);
        res.status(500).json({ error: 'Server error' });
    }
};

exports.connectEarnings = async (req, res) => {
    const { method, platforms } = req.body;
    const userId = req.user.id;

    try {
        await Integration.create({
            user_id: userId,
            type: 'earnings_connection_method',
            provider_name: 'system',
            meta_data: { method, platforms }
        });
        console.log(`[USER_ROUTE] Earnings connection method set to ${method} for user ${userId}`);
        res.json({ message: 'Earnings connection method saved' });
    } catch (err) {
        console.error('Error connecting earnings:', err);
        res.status(500).json({ error: 'Server error' });
    }
};

exports.linkBank = async (req, res) => {
    const { bankName, accountNumber, ifscCode, accountHolderName, isPrimary } = req.body;
    const userId = req.user.id;

    try {
        await BankAccount.create({
            user_id: userId,
            bank_name: bankName,
            account_number: accountNumber,
            ifsc_code: ifscCode,
            account_holder_name: accountHolderName,
            is_primary: isPrimary || false
        });
        console.log(`[USER_ROUTE] Bank linked: ${bankName} for user ${userId}`);
        res.json({ message: 'Bank linked successfully' });
    } catch (err) {
        console.error('Error linking bank:', err);
        res.status(500).json({ error: 'Server error' });
    }
};

exports.getBanks = async (req, res) => {
    try {
        const banks = await BankAccount.find({ user_id: req.user.id });
        console.log(`[USER_ROUTE] Fetched ${banks.length} banks for user ${req.user.id}`);
        res.json(banks);
    } catch (err) {
        console.error('Error fetching banks:', err);
        res.status(500).json({ error: 'Server error' });
    }
};

exports.unlinkBank = async (req, res) => {
    try {
        await BankAccount.findOneAndDelete({ _id: req.params.id, user_id: req.user.id });
        console.log(`[USER_ROUTE] Bank unlinked: ${req.params.id} for user ${req.user.id}`);
        res.json({ message: 'Bank unlinked successfully' });
    } catch (err) {
        console.error('Error unlinking bank:', err);
        res.status(500).json({ error: 'Server error' });
    }
};

exports.suggestPlatform = async (req, res) => {
    const { appName } = req.body;
    const userId = req.user.id;

    if (!appName) {
        return res.status(400).json({ error: 'App name is required' });
    }

    try {
        await PlatformSuggestion.create({
            user_id: userId,
            app_name: appName
        });
        console.log(`[USER_ROUTE] Platform suggestion: ${appName} from user ${userId}`);
        res.json({ message: 'Suggestion received' });
    } catch (err) {
        console.error('Error saving suggestion:', err);
        res.status(500).json({ error: 'Server error' });
    }
};

exports.updateProfile = async (req, res) => {
    const { name, email, phone, address } = req.body;
    const userId = req.user.id;

    try {
        const updatedUser = await User.findByIdAndUpdate(
            userId,
            {
                name,
                email,
                phone,
                address,
                updated_at: Date.now()
            },
            { returnDocument: 'after', runValidators: true }
        );
        console.log(`[USER_ROUTE] Profile updated for user ${userId}`);
        res.json({ message: 'Profile updated successfully', user: updatedUser });
    } catch (err) {
        console.error('Update Profile Error:', err);
        if (err.code === 11000) {
            return res.status(400).json({ error: 'Email or phone already in use' });
        }
        res.status(500).json({ error: 'Server error' });
    }
};

exports.getProfile = async (req, res) => {
    try {
        const userId = req.user.id;
        const userPromise = User.findById(userId).select('id name email phone picture is_verified created_at work_type status address');
        const savingsPromise = SafetyPotGoal.aggregate([
            { $match: { user_id: new mongoose.Types.ObjectId(userId) } },
            { $group: { _id: null, total: { $sum: "$current_amount" } } }
        ]);
        const banksPromise = BankAccount.find({ user_id: userId }).select('bank_name is_primary');
        const kycPromise = KycDocument.find({ user_id: userId }).select('document_type status');
        const [user, savingsRes, banks, kycs] = await Promise.all([
            userPromise,
            savingsPromise,
            banksPromise,
            kycPromise
        ]);

        if (!user) return res.status(404).json({ error: 'User not found' });

        console.log(`[USER_ROUTE] Profile data fetched for user ${userId}`);
        const totalSavings = savingsRes.length > 0 ? savingsRes[0].total : 0;
        const kycList = kycs.map(k => {
            let label = k.document_type;
            if (k.status === 'approved' || user.is_verified) {
                return `${label} (Verified)`;
            }
            return `${label} (${k.status})`;
        });
        res.json({
            id: user._id,
            name: user.name,
            email: user.email,
            phone: user.phone,
            address: user.address || '',
            picture: user.picture,
            is_verified: user.is_verified,
            joined_at: user.created_at,
            status: user.status,
            work_type: user.work_type,
            total_savings: parseFloat(totalSavings),
            linked_accounts: banks.map(b => b.bank_name).filter(Boolean),
            kyc_documents: kycList
        });

    } catch (err) {
        console.error('Profile Fetch Error:', err);
        res.status(500).json({ error: 'Server error' });
    }
};

exports.requestUpdateOtp = async (req, res) => {
    const { type, value } = req.body;
    const userId = req.user.id;

    if (type === 'email') {
        const existing = await User.findOne({ email: value });
        if (existing && existing._id.toString() !== userId) {
            return res.status(400).json({ error: 'Email already in use' });
        }
    } else if (type === 'phone') {
        const existing = await User.findOne({ phone: value });
        if (existing && existing._id.toString() !== userId) {
            return res.status(400).json({ error: 'Phone number already in use' });
        }
    } else {
        return res.status(400).json({ error: 'Invalid type' });
    }

    const otp = generateOTP();
    const otpData = {
        otp_code: otp,
        expires_at: new Date(Date.now() + 10 * 60 * 1000)
    };
    if (type === 'email') otpData.email = value;
    if (type === 'phone') otpData.phone = value;

    await Otp.create(otpData);
    console.log(`[DEV] OTP for Update ${type} (${value}): ${otp}`);
    res.json({ message: 'OTP sent successfully', demoOtp: otp });
};

exports.verifyUpdateOtp = async (req, res) => {
    const { type, value, otp } = req.body;
    const userId = req.user.id;

    const query = { otp_code: otp, expires_at: { $gt: new Date() } };
    if (type === 'email') query.email = value;
    if (type === 'phone') query.phone = value;

    const validOtp = await Otp.findOne(query).sort({ created_at: -1 });
    if (!validOtp) return res.status(400).json({ error: 'Invalid or expired OTP' });

    const update = {};
    if (type === 'email') update.email = value;
    if (type === 'phone') update.phone = value;

    const updatedUser = await User.findByIdAndUpdate(userId, update, { returnDocument: 'after' });
    await Otp.deleteMany(query);
    console.log(`[USER_ROUTE] Verified update ${type} to ${value} for user ${userId}`);
    res.json({ message: 'Updated successfully', user: updatedUser });
};
