const express = require('express');
const router = express.Router();
const authenticateToken = require('../middleware/authMiddleware');
const safetyPotController = require('../controllers/safetyPotController');

router.get('/', authenticateToken, safetyPotController.getSafetyPot);
router.get('/status', authenticateToken, safetyPotController.getSafetyPotStatus);
router.post('/rule', authenticateToken, safetyPotController.updateRule);
router.post('/event', authenticateToken, safetyPotController.recordEvent);

module.exports = router;
