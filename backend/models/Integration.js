const mongoose = require('mongoose');

const IntegrationSchema = new mongoose.Schema({
    user_id: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    type: {
        type: String,
        required: true
    },
    provider_name: {
        type: String,
        required: true
    },
    meta_data: {
        type: Object // JSON storage
    },
    created_at: {
        type: Date,
        default: Date.now
    }
});

module.exports = mongoose.model('Integration', IntegrationSchema);
