const mongoose = require('mongoose');

const InstantSupportSchema = new mongoose.Schema({
    user_id: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true,
        unique: true
    },
    status: {
        type: String,
        enum: ['not_eligible', 'eligible', 'active_loan', 'repay_mode', 'frozen'],
        default: 'not_eligible'
    },
    max_eligible_amount: {
        type: Number,
        default: 0
    },
    current_loan_amount: {
        type: Number,
        default: 0
    },
    remaining_to_repay: {
        type: Number,
        default: 0
    },
    tier: {
        type: Number, // 0, 1, 2, 3 based on amount
        default: 0
    },
    last_check_date: {
        type: Date,
        default: Date.now
    },
    disbursement_history: [{
        amount: Number,
        date: { type: Date, default: Date.now },
        external_reference: String
    }],
    repayment_history: [{
        amount: Number,
        date: { type: Date, default: Date.now },
        method: { type: String, default: 'safety_pot_recovery' }
    }]
}, { timestamps: { createdAt: 'created_at', updatedAt: 'updated_at' } });

module.exports = mongoose.model('InstantSupport', InstantSupportSchema);
