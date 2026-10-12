const mongoose = require('mongoose');

const VehicleDetailSchema = new mongoose.Schema({
    user_id: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    registration_number: { type: String },
    driving_license: { type: String },
    vehicle_type: { type: String, default: 'Bike' },
    created_at: { type: Date, default: Date.now }
});

// Indexing user
VehicleDetailSchema.index({ user_id: 1 });

module.exports = mongoose.model('VehicleDetail', VehicleDetailSchema);
