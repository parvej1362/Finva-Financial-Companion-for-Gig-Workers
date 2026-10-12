const StabilityScore = require('../models/StabilityScore');
const Earning = require('../models/Earning');
const SafetyPot = require('../models/SafetyPot');
const mongoose = require('mongoose');

// Helper to calculate the 4 components of Stability Score
const calculateStability = async (userId) => {
    const fourteenDaysAgo = new Date();
    fourteenDaysAgo.setDate(fourteenDaysAgo.getDate() - 14);

    const [earnings, safetyPot] = await Promise.all([
        Earning.find({ user_id: userId, date: { $gte: fourteenDaysAgo } }).sort({ date: 1 }).lean(),
        SafetyPot.findOne({ user_id: userId })
    ]);

    // Group by date to get daily totals (for consistency and active days)
    const dailyMap = {};
    const platformSet = new Set();

    earnings.forEach(e => {
        const d = e.date.toISOString().split('T')[0];
        dailyMap[d] = (dailyMap[d] || 0) + e.amount;
        platformSet.add(e.platform);
    });

    const dailyValues = Object.values(dailyMap);
    const activeDaysCount = dailyValues.length;
    const platformsCount = platformSet.size;

    // --- 1. DAILY EARNING CONSISTENCY (40%) ---
    let consistencyScore = 0;
    if (activeDaysCount >= 3) {
        const mean = dailyValues.reduce((s, v) => s + v, 0) / activeDaysCount;
        const variance = dailyValues.reduce((s, v) => s + Math.pow(v - mean, 2), 0) / activeDaysCount;
        const stdDev = Math.sqrt(variance);
        const variationRatio = stdDev / (mean || 1);
        const consistencyFactor = 1 - Math.min(variationRatio, 1);
        consistencyScore = consistencyFactor * 40;
    }

    // --- 2. ACTIVE WORKING DAYS (25%) ---
    let activeDaysScore = 0;
    if (activeDaysCount >= 13) activeDaysScore = 25;
    else if (activeDaysCount >= 10) activeDaysScore = 20;
    else if (activeDaysCount >= 7) activeDaysScore = 15;
    else if (activeDaysCount >= 4) activeDaysScore = 10;
    else if (activeDaysCount >= 1) activeDaysScore = 5;

    // --- 3. INCOME RESILIENCE (20%) ---
    let resilienceScore = 0;
    if (platformsCount >= 3) resilienceScore = 20;
    else if (platformsCount === 2) resilienceScore = 12;
    else if (platformsCount === 1) resilienceScore = 5;

    // --- 4. SAFETY POT DISCIPLINE (15%) ---
    let disciplineScore = 0;
    if (safetyPot && safetyPot.rule_type !== 'none') {
        const successDays = safetyPot.consecutive_success_days || 0;
        if (successDays >= 7) disciplineScore = 15;
        else if (successDays >= 4) disciplineScore = 10;
        else disciplineScore = 5;
    }

    const totalScore = Math.round(consistencyScore + activeDaysScore + resilienceScore + disciplineScore);

    // Determine Band
    let band = 'Unstable';
    if (totalScore > 80) band = 'Highly Stable';
    else if (totalScore > 60) band = 'Stable';
    else if (totalScore > 30) band = 'Improving';

    return {
        score: totalScore,
        band,
        breakdown: {
            consistency: Math.round(consistencyScore),
            active_days: activeDaysScore,
            resilience: resilienceScore,
            discipline: disciplineScore
        }
    };
};

exports.getStabilityScore = async (req, res) => {
    try {
        const userId = req.user.id;
        let stability = await StabilityScore.findOne({ user_id: userId });

        // If not recalculated today, update it
        const todayStr = new Date().toISOString().split('T')[0];
        const lastUpdateStr = stability?.last_recalculated?.toISOString().split('T')[0];

        if (!stability || todayStr !== lastUpdateStr) {
            const result = await calculateStability(userId);

            if (!stability) {
                stability = new StabilityScore({
                    user_id: userId,
                    ...result,
                    history: [{ score: result.score, date: new Date() }]
                });
            } else {
                // Growth & Decay Logic 
                const oldScore = stability.score;
                let newScore = result.score;

                // --- INACTIVITY DECAY ---
                const lastEarningRes = await Earning.findOne({ user_id: userId }).sort({ date: -1 });
                if (lastEarningRes) {
                    const daysSinceEarning = (new Date() - lastEarningRes.date) / (1000 * 60 * 60 * 24);
                    if (daysSinceEarning >= 3) {
                        // reduce score by 10-15%
                        newScore = Math.floor(oldScore * 0.88);
                    }
                }

                // --- SLOW GROWTH ---
                // If it's a significant jump, clamp it (Slow Growth Rule)
                if (newScore > oldScore + 10) {
                    newScore = oldScore + 5 + Math.floor(Math.random() * 5);
                }

                stability.score = Math.max(0, Math.min(100, newScore));
                stability.band = result.band;
                stability.breakdown = result.breakdown;
                stability.last_recalculated = new Date();
                stability.history.push({ score: newScore, date: new Date() });

                // Keep history small
                if (stability.history.length > 30) stability.history.shift();
            }
            await stability.save();
        }

        res.json(stability);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error' });
    }
};

exports.triggerRecalculation = async (userId) => {
    try {
        const result = await calculateStability(userId);
        await StabilityScore.findOneAndUpdate(
            { user_id: userId },
            {
                ...result,
                last_recalculated: new Date(),
                $push: { history: { score: result.score, date: new Date() } }
            },
            { upsert: true }
        );
    } catch (err) {
        console.error("Manual stability recalc failed:", err);
    }
};
