const mongoose = require('mongoose');

const KycDocumentSchema = new mongoose.Schema({
    user_id: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    document_type: {
        type: String,
        required: true,
        enum: ['Aadhaar', 'PAN', 'Driving License', 'Bank Statement', 'Voter ID', 'Passport']
    },
    category: {
        type: String,
        enum: ['Identity', 'Address', 'Financial', 'Other'],
        default: 'Identity'
    },
    document_number: { type: String },
    file_url: { type: String },
    status: {
        type: String,
        enum: ['pending', 'approved', 'rejected', 'not_uploaded'],
        default: 'not_uploaded'
    },
    verified_at: { type: Date },
    rejection_reason: { type: String },
    created_at: { type: Date, default: Date.now },
    updated_at: { type: Date, default: Date.now }
});

// Indexing
KycDocumentSchema.index({ user_id: 1, document_type: 1 }, { unique: true });

KycDocumentSchema.pre('save', function (next) {
    this.updated_at = Date.now();
    next();
});

module.exports = mongoose.model('KycDocument', KycDocumentSchema);
