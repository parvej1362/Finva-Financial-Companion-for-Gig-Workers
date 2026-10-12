const express = require('express');
const router = express.Router();
const authMiddleware = require('../middleware/authMiddleware');
const notificationController = require('../controllers/notificationController');

router.get('/', authMiddleware, notificationController.getNotifications);
router.put('/mark-read', authMiddleware, notificationController.markAsRead);
router.put('/:id/mark-read', authMiddleware, notificationController.markOneAsRead);

module.exports = router;
