const mongoose = require('mongoose');

const SafetyPotSchema = new mongoose.Schema({
    user_id: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true,
        unique: true
    },
    rule_type: {
        type: String,
        enum: ['fixed', 'min_balance', 'percentage', 'none'],
        default: 'none'
    },
    rule_value: {
        type: Number,
        default: 0
    },
    protected_target: {
        type: Number,
        default: 0
    },
    current_protected_estimate: {
        type: Number,
        default: 0
    },
    last_updated_date: {
        type: Date,
        default: Date.now
    },
    discipline_score: {
        type: Number,
        default: 0,
        max: 15
    },
    consecutive_success_days: {
        type: Number,
        default: 0
    },
    is_breached: {
        type: Boolean,
        default: false
    },
    recovery_goal: {
        target: { type: Number, default: 0 },
        remaining: { type: Number, default: 0 },
        days_left: { type: Number, default: 0 },
        is_active: { type: Boolean, default: false }
    },
    history: [{
        date: { type: Date, default: Date.now },
        earnings: Number,
        spent: Number,
        protected_added: Number,
        was_breached: { type: Boolean, default: false }
    }]
}, { timestamps: { createdAt: 'created_at', updatedAt: 'updated_at' } });

module.exports = mongoose.model('SafetyPot', SafetyPotSchema);
