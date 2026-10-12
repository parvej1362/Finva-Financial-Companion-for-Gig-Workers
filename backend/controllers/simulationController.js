const User = require('../models/User');
const Earning = require('../models/Earning');
const Notification = require('../models/Notification');

exports.simulateIncomingSms = async (req, res) => {
    const { userId, platform, amount, timestamp } = req.body;

    if (!userId || !platform || !amount) {
        return res.status(400).json({ error: 'Missing required fields: userId, platform, amount' });
    }

    try {
        const user = await User.findById(userId);
        if (!user) return res.status(404).json({ error: 'User not found' });

        const date = timestamp ? new Date(timestamp) : new Date();
        const formattedDate = date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
        const smsContent = `Credit: Rs.${amount} credited to your account linked to ${platform} on ${formattedDate}. Ref: FINVA_SIM_${Date.now()}`;

        const notification = await Notification.create({
            user_id: user._id,
            type: 'earning_sms',
            title: `New Payout from ${platform}`,
            message: smsContent,
            data: { platform, amount },
            received_at: date
        });

        const earning = await Earning.create({
            user_id: user._id,
            platform,
            amount,
            date: date,
            source_message: smsContent,
            status: 'verified'
        });

        res.json({
            success: true,
            message: 'SMS Simulation Successful',
            notification,
            earning
        });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Simulation failed', details: err.message });
    }
};

exports.getNotifications = async (req, res) => {
    try {
        const notifications = await Notification.find({ user_id: req.params.userId })
            .sort({ received_at: -1 })
            .limit(20);
        res.json(notifications);
    } catch (err) {
        res.status(500).json({ error: 'Failed to fetch notifications' });
    }
};
