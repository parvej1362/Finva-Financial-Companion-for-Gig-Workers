const express = require('express');
const router = express.Router();
const authenticateToken = require('../middleware/authMiddleware');
const insuranceController = require('../controllers/insuranceController');

router.get('/plans', authenticateToken, insuranceController.getPlans);
router.get('/policies', authenticateToken, insuranceController.getPolicies);
router.post('/subscribe', authenticateToken, insuranceController.subscribe);

module.exports = router;
