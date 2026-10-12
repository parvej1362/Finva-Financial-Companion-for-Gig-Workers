const express = require('express');
const router = express.Router();
const authenticateToken = require('../middleware/authMiddleware');
const stabilityController = require('../controllers/stabilityController');

router.get('/', authenticateToken, stabilityController.getStabilityScore);

module.exports = router;
