const express = require('express');
const router = express.Router();
const simulationController = require('../controllers/simulationController');

router.post('/incoming-sms', simulationController.simulateIncomingSms);
router.get('/notifications/:userId', simulationController.getNotifications);

module.exports = router;
