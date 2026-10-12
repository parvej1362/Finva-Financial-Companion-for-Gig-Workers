const KycDocument = require('../models/Kyc');

exports.getKycDocuments = async (req, res) => {
    try {
        const userId = req.user.id;
        const docs = await KycDocument.find({ user_id: userId });

        // Define all required documents even if not uploaded
        const requiredDocs = [
            { type: 'Aadhaar', category: 'Identity', label: 'Aadhaar Card' },
            { type: 'PAN', category: 'Identity', label: 'PAN Card' },
            { type: 'Driving License', category: 'Address', label: 'Driving License' },
            { type: 'Bank Statement', category: 'Financial', label: 'Bank Statement' }
        ];

        const response = requiredDocs.map(reqDoc => {
            const userDoc = docs.find(d => d.document_type === reqDoc.type);
            return {
                ...reqDoc,
                status: userDoc ? userDoc.status : 'not_uploaded',
                document_number: userDoc ? userDoc.document_number : '',
                file_url: userDoc ? userDoc.file_url : '',
                verified_at: userDoc ? userDoc.verified_at : null,
                updated_at: userDoc ? userDoc.updated_at : null,
                id: userDoc ? userDoc._id : null
            };
        });

        res.json(response);
    } catch (err) {
        console.error('Error fetching KYC:', err);
        res.status(500).json({ error: 'Server error' });
    }
};

exports.updateKycDocument = async (req, res) => {
    const { documentType, documentNumber, fileUrl, category } = req.body;
    const userId = req.user.id;

    if (!documentType) {
        return res.status(400).json({ error: 'Document type is required' });
    }

    try {
        const doc = await KycDocument.findOneAndUpdate(
            { user_id: userId, document_type: documentType },
            {
                document_number: documentNumber,
                file_url: fileUrl,
                category: category || 'Identity',
                status: 'pending', // Re-uploading sets it back to pending
                updated_at: Date.now()
            },
            { upsert: true, returnDocument: 'after', setDefaultsOnInsert: true }
        );

        console.log(`[KYC_ROUTE] Document ${documentType} updated for user ${userId}`);
        res.json({ message: 'Document submitted for verification', document: doc });
    } catch (err) {
        console.error('Error updating KYC:', err);
        res.status(500).json({ error: 'Server error' });
    }
};

// DEV ONLY: Simulated verification
exports.verifyKycDocument = async (req, res) => {
    const { id } = req.params;
    const { status, reason } = req.body; // status: 'approved' or 'rejected'

    try {
        const update = {
            status,
            updated_at: Date.now()
        };
        if (status === 'approved') update.verified_at = Date.now();
        if (status === 'rejected') update.rejection_reason = reason;

        const doc = await KycDocument.findByIdAndUpdate(id, update, { returnDocument: 'after' });
        res.json({ message: `Document ${status}`, document: doc });
    } catch (err) {
        console.error('Error verifying KYC:', err);
        res.status(500).json({ error: 'Server error' });
    }
};
