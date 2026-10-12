const db = require('../db');

class Insurance {
    static async getAvailablePlans() {
        const { rows } = await db.query('SELECT * FROM insurance_plans');
        return rows;
    }

    static async getPlansByCategory(category) {
        const { rows } = await db.query(
            'SELECT * FROM insurance_plans WHERE category = $1',
            [category]
        );
        return rows;
    }

    static async getUserPolicies(userId) {
        const { rows } = await db.query(
            `SELECT up.*, ip.plan_name, ip.provider, ip.category 
       FROM user_policies up
       JOIN insurance_plans ip ON up.plan_id = ip.id
       WHERE up.user_id = $1`,
            [userId]
        );
        return rows;
    }

    static async subscribeToPlan({ userId, planId, startDate, endDate, policyNumber }) {
        const { rows } = await db.query(
            `INSERT INTO user_policies (user_id, plan_id, start_date, end_date, policy_number, status) 
       VALUES ($1, $2, $3, $4, $5, 'active') 
       RETURNING *`,
            [userId, planId, startDate, endDate, policyNumber]
        );
        return rows[0];
    }

    static async getPolicyById(id) {
        const { rows } = await db.query('SELECT * FROM user_policies WHERE id = $1', [id]);
        return rows[0];
    }
}

module.exports = Insurance;
