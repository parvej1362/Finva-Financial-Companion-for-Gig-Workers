const express = require('express');
const router = express.Router();
const authenticateToken = require('../middleware/authMiddleware');
const onboardingController = require('../controllers/onboardingController');

router.post('/professional', authenticateToken, onboardingController.updateProfessionalDetails);
router.post('/banking', authenticateToken, onboardingController.updateBankingDetails);
router.post('/kyc', authenticateToken, onboardingController.updateKycDetails);

module.exports = router;
