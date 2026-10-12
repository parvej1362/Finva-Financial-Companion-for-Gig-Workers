const express = require('express');
const router = express.Router();
const authenticateToken = require('../middleware/authMiddleware');
const instantSupportController = require('../controllers/instantSupportController');

router.get('/eligibility', authenticateToken, instantSupportController.getEligibility);
router.post('/request', authenticateToken, instantSupportController.requestSupport);
router.get('/status', authenticateToken, instantSupportController.getRepaymentStatus);

module.exports = router;
