const mongoose = require('mongoose');

const UserSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
        trim: true,
        index: true
    },
    email: {
        type: String,
        required: true,
        unique: true,
        trim: true,
        lowercase: true,
        index: true
    },
    phone: {
        type: String,
        required: false, // Changed to false to support initial Google Auth without phone
        unique: true,
        sparse: true, // Allow multiple nulls
        trim: true,
        index: true
    },
    password_hash: {
        type: String,
        required: false,
        select: false // Do not return password by default
    },
    dob: {
        type: Date,
        required: false
    },
    address: {
        type: String,
        trim: true
    },
    work_type: [{
        type: String,
        enum: ['delivery', 'ride-sharing', 'freelance', 'logistics']
    }],
    status: {
        type: String,
        enum: ['active', 'suspended', 'deleted'],
        default: 'active'
    },
    is_verified: {
        type: Boolean,
        default: false
    },
    google_id: {
        type: String,
        unique: true,
        sparse: true
    },
    picture: {
        type: String
    },
    created_at: {
        type: Date,
        default: Date.now
    }
}, { timestamps: { createdAt: 'created_at', updatedAt: 'updated_at' } });

module.exports = mongoose.model('User', UserSchema);
