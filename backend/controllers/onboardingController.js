const User = require('../models/User');
const Platform = require('../models/Platform');
const BankAccount = require('../models/BankAccount');
const KycDocument = require('../models/Kyc.js');
const VehicleDetail = require('../models/VehicleDetail');

exports.updateProfessionalDetails = async (req, res) => {
    const { primaryPlatform, workType } = req.body;
    const userId = req.user.id;

    if (!primaryPlatform || !workType) {
        return res.status(400).json({ error: 'Please provide platform and work type' });
    }

    try {
        await User.findByIdAndUpdate(userId, { $addToSet: { work_type: workType } });
        await Platform.findOneAndUpdate(
            { user_id: userId, platform_name: primaryPlatform },
            { status: 'active', updated_at: new Date() },
            { upsert: true, returnDocument: 'after', setDefaultsOnInsert: true }
        );
        res.json({ message: 'Professional details updated' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error' });
    }
};

exports.updateBankingDetails = async (req, res) => {
    const { upiId, accountNumber, ifsc, bankName } = req.body;
    const userId = req.user.id;

    if (!upiId) {
        return res.status(400).json({ error: 'UPI ID is required' });
    }

    try {
        await BankAccount.findOneAndUpdate(
            { user_id: userId, is_primary: true },
            {
                upi_id: upiId,
                account_number: accountNumber,
                ifsc_code: ifsc,
                bank_name: bankName,
                is_primary: true
            },
            { upsert: true, returnDocument: 'after', setDefaultsOnInsert: true }
        );
        res.json({ message: 'Banking details saved' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error' });
    }
};

exports.updateKycDetails = async (req, res) => {
    const { panNumber, aadhaarNumber, vehicleReg, drivingLicense } = req.body;
    const userId = req.user.id;

    try {
        const ops = [];

        if (panNumber) {
            ops.push(
                KycDocument.findOneAndUpdate(
                    { user_id: userId, document_type: 'PAN' },
                    { document_number: panNumber, status: 'pending' },
                    { upsert: true, returnDocument: 'after' }
                )
            );
        }

        if (aadhaarNumber) {
            ops.push(
                KycDocument.findOneAndUpdate(
                    { user_id: userId, document_type: 'Aadhaar' },
                    { document_number: aadhaarNumber, status: 'pending' },
                    { upsert: true, returnDocument: 'after' }
                )
            );
        }

        if (vehicleReg || drivingLicense) {
            ops.push(
                VehicleDetail.findOneAndUpdate(
                    { user_id: userId },
                    { registration_number: vehicleReg, driving_license: drivingLicense, vehicle_type: 'Bike' },
                    { upsert: true, returnDocument: 'after' }
                )
            );
        }

        await Promise.all(ops);
        res.json({ message: 'KYC details submitted' });
    } catch (err) {
        console.error(err);
        if (err.code === 11000) return res.status(400).json({ error: 'Document already exists.' });
        res.status(500).json({ error: 'Server error' });
    }
};
