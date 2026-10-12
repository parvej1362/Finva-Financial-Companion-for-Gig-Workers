const mongoose = require('mongoose');

const insightCalibrationSchema = new mongoose.Schema({
    user_id: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        unique: true,
        required: true
    },
    realizationMultiplier: {
        type: Number,
        default: 0.85,
        min: 0.7,
        max: 1.2
    },
    totalInsightsShown: {
        type: Number,
        default: 0
    },
    positiveRealizations: {
        type: Number,
        default: 0
    },
    lastProjectedGain: {
        type: Number,
        default: 0
    },
    lastProjectedAt: {
        type: Date
    },
    history: [{
        projected: Number,
        actual: Number,
        date: Date,
        multiplierAtTime: Number
    }]
}, { timestamps: true });

module.exports = mongoose.model('InsightCalibration', insightCalibrationSchema);
