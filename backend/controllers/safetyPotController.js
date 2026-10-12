const SafetyPot = require('../models/SafetyPot');
const Earning = require('../models/Earning');
const mongoose = require('mongoose');

// GET /api/safety-pot
exports.getSafetyPot = async (req, res) => {
    try {
        const userId = req.user.id;
        let safetyPot = await SafetyPot.findOne({ user_id: userId });

        if (!safetyPot) {
            safetyPot = await SafetyPot.create({ user_id: userId });
        }

        res.json(safetyPot);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error' });
    }
};

// POST /api/safety-pot/rule
exports.updateRule = async (req, res) => {
    const { rule_type, rule_value } = req.body;
    const userId = req.user.id;

    try {
        let safetyPot = await SafetyPot.findOne({ user_id: userId });
        if (!safetyPot) {
            safetyPot = new SafetyPot({ user_id: userId });
        }

        safetyPot.rule_type = rule_type;
        safetyPot.rule_value = rule_value;
        safetyPot.last_updated_date = new Date();

        await safetyPot.save();
        res.json(safetyPot);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error' });
    }
};

// GET /api/safety-pot/status
exports.getSafetyPotStatus = async (req, res) => {
    try {
        const userId = req.user.id;
        const safetyPot = await SafetyPot.findOne({ user_id: userId });

        if (!safetyPot) {
            return res.json({
                today_earnings: 0,
                protected_amount: 0,
                available_to_spend: 0,
                discipline_score: 0,
                streak: 0
            });
        }

        // Calculate Today's Earnings
        const startOfDay = new Date();
        startOfDay.setHours(0, 0, 0, 0);

        const earningsToday = await Earning.aggregate([
            { $match: { user_id: new mongoose.Types.ObjectId(userId), date: { $gte: startOfDay } } },
            { $group: { _id: null, total: { $sum: "$amount" } } }
        ]);

        const totalEarningsToday = earningsToday.length > 0 ? earningsToday[0].total : 0;

        // Calculate Total Earnings (for "Available to Spend" estimation)
        const totalEarningsAllTime = await Earning.aggregate([
            { $match: { user_id: new mongoose.Types.ObjectId(userId) } },
            { $group: { _id: null, total: { $sum: "$amount" } } }
        ]);

        const allTimeEarnings = totalEarningsAllTime.length > 0 ? totalEarningsAllTime[0].total : 0;
        const available = Math.max(0, allTimeEarnings - safetyPot.protected_target);

        res.json({
            today_earnings: totalEarningsToday,
            protected_amount: safetyPot.protected_target,
            available_to_spend: available,
            discipline_score: safetyPot.discipline_score,
            streak: safetyPot.consecutive_success_days
        });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error' });
    }
};

// Internal function or route to trigger daily check
exports.processDailyCalculations = async (userId) => {
    try {
        const safetyPot = await SafetyPot.findOne({ user_id: userId });
        if (!safetyPot || safetyPot.rule_type === 'none') return;

        const startOfDay = new Date();
        startOfDay.setHours(0, 0, 0, 0);

        // Check if there was earning today
        const earningsToday = await Earning.findOne({
            user_id: userId,
            date: { $gte: startOfDay }
        });

        if (earningsToday) {
            // Rule A: Fixed
            if (safetyPot.rule_type === 'fixed') {
                safetyPot.protected_target += safetyPot.rule_value;
            }
            // Rule C: Percentage
            else if (safetyPot.rule_type === 'percentage') {
                const totalToday = await Earning.aggregate([
                    { $match: { user_id: userId, date: { $gte: startOfDay } } },
                    { $group: { _id: null, total: { $sum: "$amount" } } }
                ]);
                const amount = totalToday[0]?.total || 0;
                if (amount > 800) { // Threshold
                    safetyPot.protected_target += amount * (safetyPot.rule_value / 100);
                }
            }

            // --- INSTANT SUPPORT RECOVERY LOGIC ---
            if (safetyPot.recovery_goal && safetyPot.recovery_goal.is_active) {
                const InstantSupport = require('../models/InstantSupport');
                const instantSupport = await InstantSupport.findOne({ user_id: userId });

                if (instantSupport && instantSupport.remaining_to_repay > 0) {
                    // Repayment is behavior-based: Following the rules for one day counts as one step of recovery
                    // We split the debt over the recovery period (normally 5 days)
                    const recoveryStep = instantSupport.current_loan_amount / 5;
                    const amountRecovered = Math.min(recoveryStep, instantSupport.remaining_to_repay);

                    instantSupport.remaining_to_repay -= amountRecovered;
                    instantSupport.repayment_history.push({
                        amount: amountRecovered,
                        date: new Date(),
                        method: 'behavioral_recovery'
                    });

                    safetyPot.recovery_goal.remaining = instantSupport.remaining_to_repay;
                    safetyPot.recovery_goal.days_left = Math.max(0, safetyPot.recovery_goal.days_left - 1);

                    if (instantSupport.remaining_to_repay <= 0) {
                        instantSupport.status = 'eligible';
                        safetyPot.recovery_goal.is_active = false;
                        safetyPot.is_breached = false;
                    }

                    await instantSupport.save();
                }
            }

            // Increment streak if no breach detected
            if (!safetyPot.is_breached) {
                safetyPot.consecutive_success_days += 1;
                safetyPot.discipline_score = Math.min(safetyPot.consecutive_success_days * (safetyPot.recovery_goal?.is_active ? 3 : 2), 15);
            } else {
                // If they breached during recovery, freeze eligibility
                if (safetyPot.recovery_goal && safetyPot.recovery_goal.is_active) {
                    const InstantSupport = require('../models/InstantSupport');
                    await InstantSupport.findOneAndUpdate({ user_id: userId }, { status: 'frozen' });
                }
                safetyPot.is_breached = false; // Reset for next day
                safetyPot.consecutive_success_days = 0; // Reset streak on breach
            }
        }

        safetyPot.last_updated_date = new Date();
        await safetyPot.save();
    } catch (err) {
        console.error("Daily calc error:", err);
    }
};

exports.recordEvent = async (req, res) => {
    // This is for real-time signals
    const { type, amount } = req.body;
    const userId = req.user.id;

    try {
        const safetyPot = await SafetyPot.findOne({ user_id: userId });
        if (!safetyPot) return res.status(404).json({ error: 'Not found' });

        if (type === 'income') {
            // Trigger daily logic if first income of the day
            // For now just return status
        } else if (type === 'spend') {
            // Check if breach
            // If total_balance - amount < protected_target => breach
            // This needs total_balance which we estimate from earnings
        }

        await safetyPot.save();
        res.json(safetyPot);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error' });
    }
};
