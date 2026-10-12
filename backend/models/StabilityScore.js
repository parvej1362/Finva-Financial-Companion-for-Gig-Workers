const mongoose = require('mongoose');

const StabilityScoreSchema = new mongoose.Schema({
    user_id: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true,
        unique: true
    },
    score: {
        type: Number,
        default: 0,
        min: 0,
        max: 100
    },
    band: {
        type: String,
        enum: ['Unstable', 'Improving', 'Stable', 'Highly Stable'],
        default: 'Unstable'
    },
    breakdown: {
        consistency: { type: Number, default: 0 },
        active_days: { type: Number, default: 0 },
        resilience: { type: Number, default: 0 },
        discipline: { type: Number, default: 0 }
    },
    history: [{
        date: { type: Date, default: Date.now },
        score: Number
    }],
    last_recalculated: {
        type: Date,
        default: Date.now
    }
}, { timestamps: { createdAt: 'created_at', updatedAt: 'updated_at' } });

module.exports = mongoose.model('StabilityScore', StabilityScoreSchema);
