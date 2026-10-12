const express = require('express');
const router = express.Router();
const authMiddleware = require('../middleware/authMiddleware');
const kycController = require('../controllers/kycController');

router.get('/', authMiddleware, kycController.getKycDocuments);
router.post('/update', authMiddleware, kycController.updateKycDocument);
router.post('/verify/:id', authMiddleware, kycController.verifyKycDocument); // In real app, this would be admin-only

module.exports = router;
