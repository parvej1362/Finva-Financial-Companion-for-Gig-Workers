const mongoose = require('mongoose');

const NotificationSchema = new mongoose.Schema({
    user_id: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    type: {
        type: String,
        enum: ['earning_sms', 'alert', 'promo', 'system'],
        default: 'earning_sms'
    },
    title: {
        type: String,
        required: true
    },
    message: {
        type: String,
        required: true
    },
    data: {
        platform: String,
        amount: Number,
        currency: { type: String, default: 'INR' }
    },
    is_read: {
        type: Boolean,
        default: false
    },
    received_at: {
        type: Date,
        default: Date.now
    }
}, { timestamps: true });

module.exports = mongoose.model('Notification', NotificationSchema);
