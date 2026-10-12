const Support = require('../models/Support');

exports.createTicket = async (req, res) => {
    const { subject, message } = req.body;
    const userId = req.user.id;

    if (!subject || !message) {
        return res.status(400).json({ error: 'Subject and message are required' });
    }

    try {
        const ticket = await Support.createTicket({ userId, subject, message });
        res.status(201).json(ticket);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error' });
    }
};

exports.getTickets = async (req, res) => {
    try {
        const userId = req.user.id;
        const tickets = await Support.getTicketsByUserId(userId);
        res.json(tickets);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error' });
    }
};

exports.getTicketDetails = async (req, res) => {
    try {
        const { id } = req.params;
        const ticket = await Support.getTicketById(id);
        if (!ticket) return res.status(404).json({ error: 'Ticket not found' });

        if (ticket.user_id !== req.user.id) {
            return res.status(403).json({ error: 'Unauthorized' });
        }

        res.json(ticket);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error' });
    }
};
