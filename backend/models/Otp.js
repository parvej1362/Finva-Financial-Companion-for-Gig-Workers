const mongoose = require('mongoose');

const OtpSchema = new mongoose.Schema({
    phone: {
        type: String,
        required: false // Changed to support email-only OTPs
    },
    email: {
        type: String,
        required: false
    },
    otp_code: {
        type: String,
        required: true
    },
    expires_at: {
        type: Date,
        required: true,
        index: { expires: 0 } // Create TTL index that expires immediately when expires_at reached
    },
    created_at: {
        type: Date,
        default: Date.now
    }
});

module.exports = mongoose.model('Otp', OtpSchema);
