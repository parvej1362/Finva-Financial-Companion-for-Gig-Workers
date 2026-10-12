const express = require('express');
const router = express.Router();
const authMiddleware = require('../middleware/authMiddleware');
const insightController = require('../controllers/insightController');

router.get('/', authMiddleware, insightController.getInsights);

module.exports = router;
