const mongoose = require('mongoose');

const EarningSchema = new mongoose.Schema({
    user_id: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    platform: {
        type: String,
        required: true
    },
    amount: {
        type: Number,
        required: true,
        min: [0, 'Amount cannot be negative']
    },
    date: {
        type: Date,
        default: Date.now,
        index: true
    },
    source_message: {
        type: String, // The "SMS" content that triggered this
        default: ''
    },
    status: {
        type: String,
        enum: ['verified', 'pending', 'processed'],
        default: 'verified'
    }
}, { timestamps: { createdAt: 'created_at', updatedAt: 'updated_at' } });

// Composite index for fast listing/filtering by user and date
EarningSchema.index({ user_id: 1, date: -1 });
EarningSchema.index({ user_id: 1, platform: 1, date: -1 });

module.exports = mongoose.model('Earning', EarningSchema);
