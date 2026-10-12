const mongoose = require('mongoose');

const BankAccountSchema = new mongoose.Schema({
    user_id: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    upi_id: { type: String },
    account_number: { type: String },
    ifsc_code: { type: String },
    bank_name: { type: String },
    account_holder_name: { type: String },
    account_type: { type: String, default: 'Savings' },
    is_primary: { type: Boolean, default: false },
    created_at: { type: Date, default: Date.now }
});

// Index for fast lookups
BankAccountSchema.index({ user_id: 1 });

module.exports = mongoose.model('BankAccount', BankAccountSchema);
