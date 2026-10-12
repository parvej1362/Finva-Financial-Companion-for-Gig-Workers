const mongoose = require('mongoose');

const SafetyPotGoalSchema = new mongoose.Schema({
    user_id: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    goal_name: { type: String },
    target_amount: { type: Number },
    current_amount: { type: Number, default: 0 },
    deadline: { type: Date },
    created_at: { type: Date, default: Date.now }
});

module.exports = mongoose.model('SafetyPotGoal', SafetyPotGoalSchema);
