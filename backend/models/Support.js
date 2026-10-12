const db = require('../db');

class Support {
    static async createTicket({ userId, subject, message }) {
        const { rows } = await db.query(
            'INSERT INTO support_tickets (user_id, subject, message) VALUES ($1, $2, $3) RETURNING *',
            [userId, subject, message]
        );
        return rows[0];
    }

    static async getTicketsByUserId(userId) {
        const { rows } = await db.query(
            'SELECT * FROM support_tickets WHERE user_id = $1 ORDER BY created_at DESC',
            [userId]
        );
        return rows;
    }

    static async getTicketById(id) {
        const { rows } = await db.query('SELECT * FROM support_tickets WHERE id = $1', [id]);
        return rows[0];
    }

    static async updateTicketStatus(id, status) {
        const { rows } = await db.query(
            'UPDATE support_tickets SET status = $1 WHERE id = $2 RETURNING *',
            [status, id]
        );
        return rows[0];
    }
}

module.exports = Support;
