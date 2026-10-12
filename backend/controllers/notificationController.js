const Notification = require('../models/Notification');

exports.getNotifications = async (req, res) => {
    try {
        const notifications = await Notification.find({ user_id: req.user.id })
            .sort({ received_at: -1 })
            .limit(20);
        res.json(notifications);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error' });
    }
};

exports.markAsRead = async (req, res) => {
    try {
        await Notification.updateMany(
            { user_id: req.user.id, is_read: false },
            { $set: { is_read: true } }
        );
        res.json({ message: 'All notifications marked as read' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error' });
    }
};

exports.markOneAsRead = async (req, res) => {
    try {
        const notification = await Notification.findOneAndUpdate(
            { _id: req.params.id, user_id: req.user.id },
            { $set: { is_read: true } },
            { returnDocument: 'after' }
        );
        if (!notification) return res.status(404).json({ error: 'Notification not found' });
        res.json(notification);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error' });
    }
};
