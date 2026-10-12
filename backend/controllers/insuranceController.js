const Insurance = require('../models/Insurance');

exports.getPlans = async (req, res) => {
    try {
        const { category } = req.query;
        let plans;
        if (category) {
            plans = await Insurance.getPlansByCategory(category);
        } else {
            plans = await Insurance.getAvailablePlans();
        }
        res.json(plans);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error' });
    }
};

exports.getPolicies = async (req, res) => {
    try {
        const userId = req.user.id;
        const policies = await Insurance.getUserPolicies(userId);
        res.json(policies);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error' });
    }
};

exports.subscribe = async (req, res) => {
    const { planId, startDate, endDate, policyNumber } = req.body;
    const userId = req.user.id;

    if (!planId || !startDate || !endDate) {
        return res.status(400).json({ error: 'Plan ID, start date, and end date are required' });
    }

    try {
        const policy = await Insurance.subscribeToPlan({
            userId,
            planId,
            startDate,
            endDate,
            policyNumber: policyNumber || `POL-${Date.now()}`
        });
        res.status(201).json(policy);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error' });
    }
};
