const mongoose = require('mongoose');

const PlatformSchema = new mongoose.Schema({
    user_id: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    platform_name: { type: String, required: true, trim: true },
    status: {
        type: String,
        enum: ['active', 'inactive', 'archived'],
        default: 'active'
    },
    created_at: { type: Date, default: Date.now }
});

// Prevent duplicate platforms for same user
PlatformSchema.index({ user_id: 1, platform_name: 1 }, { unique: true });

module.exports = mongoose.model('Platform', PlatformSchema);
