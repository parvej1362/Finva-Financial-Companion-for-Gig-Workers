const express = require('express');
const router = express.Router();
const authenticateToken = require('../middleware/authMiddleware');
const supportController = require('../controllers/supportController');

router.post('/ticket', authenticateToken, supportController.createTicket);
router.get('/tickets', authenticateToken, supportController.getTickets);
router.get('/tickets/:id', authenticateToken, supportController.getTicketDetails);

module.exports = router;
