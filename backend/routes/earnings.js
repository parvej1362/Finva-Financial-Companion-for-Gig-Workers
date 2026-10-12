const express = require('express');
const router = express.Router();
const authenticateToken = require('../middleware/authMiddleware');
const earningsController = require('../controllers/earningsController');

router.get('/', authenticateToken, earningsController.getEarningsSummary);
router.post('/', authenticateToken, earningsController.addEarning);
router.get('/platforms', authenticateToken, earningsController.getPlatforms);
router.post('/platforms', authenticateToken, earningsController.addPlatform);

module.exports = router;
