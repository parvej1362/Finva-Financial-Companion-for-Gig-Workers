const mongoose = require('mongoose');
const Earning = require('../models/Earning');
const Platform = require('../models/Platform');
const InsightCalibration = require('../models/InsightCalibration'); 

exports.getInsights = async (req, res) => {
    try {
        const userId = new mongoose.Types.ObjectId(req.user.id);
        const today = new Date();
        today.setHours(0, 0, 0, 0);

        console.log(`[INSIGHTS] Executing Adaptive Elite Engine v2.9 (Observant Advisor) for user ${userId}`);

        // 1. DATA ACQUISITION
        const sixtyDaysAgo = new Date();
        sixtyDaysAgo.setDate(today.getDate() - 60);
        const fourteenDaysAgo = new Date();
        fourteenDaysAgo.setDate(today.getDate() - 14);

        const [earningsHistory, platformStatsRaw, hourStatsRaw, dailyStats, activeGoal, userPlatforms, globalTrends, calibrationRecord] = await Promise.all([
            Earning.find({ user_id: userId, date: { $gte: sixtyDaysAgo } }).sort({ date: 1 }).lean(),
            Earning.aggregate([
                { $match: { user_id: userId, date: { $gte: sixtyDaysAgo } } },
                { $group: { _id: "$platform", avgAmount: { $avg: "$amount" }, totalEarnings: { $sum: "$amount" }, count: { $sum: 1 } } },
                { $sort: { avgAmount: -1 } }
            ]),
            Earning.aggregate([
                { $match: { user_id: userId, date: { $gte: sixtyDaysAgo } } },
                { $group: { _id: { $hour: "$date" }, avgAmount: { $avg: "$amount" }, totalAmount: { $sum: "$amount" }, count: { $sum: 1 } } },
                { $sort: { _id: 1 } }
            ]),
            Earning.aggregate([
                { $match: { user_id: userId, date: { $gte: sixtyDaysAgo } } },
                { $group: { _id: { $dateToString: { format: "%Y-%m-%d", date: "$date" } }, dailyTotal: { $sum: "$amount" }, count: { $sum: 1 } } },
                { $sort: { _id: 1 } }
            ]),
            require('../models/SafetyPotGoal').findOne({ user_id: userId }).sort({ created_at: -1 }),
            Platform.find({ user_id: userId, status: 'active' }).lean(),
            Earning.aggregate([
                { $match: { date: { $gte: fourteenDaysAgo } } },
                { $group: { _id: "$platform", globalAvg: { $avg: "$amount" }, userCount: { $addToSet: "$user_id" } } },
                { $project: { _id: 1, globalAvg: 1, userCount: { $size: "$userCount" } } },
                { $sort: { globalAvg: -1 } },
                { $limit: 3 }
            ]),
            InsightCalibration.findOne({ user_id: userId })
        ]);

        const platformStats = [...platformStatsRaw];
        const hourStats = [...hourStatsRaw];

        if (earningsHistory.length === 0 && userPlatforms.length === 0) {
            return res.json({ primaryRecommendation: null, insightCards: [], platformPerformance: [], prediction: null });
        }

        // --- STATISTICAL CALIBRATION ---
        const totalTasks = earningsHistory.length;
        const recentTasks = earningsHistory.filter(e => e.date >= fourteenDaysAgo).length;
        const totalEarnings = earningsHistory.reduce((s, e) => s + e.amount, 0);
        
        const recencyRatio = recentTasks / (totalTasks || 1);
        const recencyFactor = 0.8 + (recencyRatio * 0.4);
        const dataStrength = Math.min(totalTasks / 40, 1);

        // --- ADAPTIVE REALIZATION TRACKING (v2.9 Fixes) ---
        let adaptiveMultiplier = calibrationRecord ? calibrationRecord.realizationMultiplier : 0.85;
        
        const getDailyList = (list) => {
            const m = {};
            list.forEach(e => { const d = new Date(e.date).toISOString().split('T')[0]; m[d] = (m[d] || 0) + e.amount; });
            return Object.values(m);
        };

        if (calibrationRecord && (calibrationRecord.lastProjectedAt || true) && earningsHistory.length > 5) {
            const lastCheck = calibrationRecord.lastProjectedAt || calibrationRecord.updatedAt;
            const daysSince = (today - lastCheck) / (1000 * 60 * 60 * 24);
            
            // Learning Cycle: Minimum 5 days, or 10 days if just tracking baseline
            if (daysSince >= 5) {
                const sinceLast = earningsHistory.filter(e => e.date >= lastCheck);
                const actualMeanSince = getMean(getDailyList(sinceLast));
                
                // If we had a projection, check if they hit it (with Volatility Cap)
                if (calibrationRecord.lastProjectedAt) {
                    const target = calibrationRecord.lastProjectedGain;
                    // Elite Fix: Filter out lucky spikes (1.5x cap) and reward consistent growth (>0.9x)
                    if (actualMeanSince > target * 0.9 && actualMeanSince < target * 1.5) {
                        adaptiveMultiplier = Math.min(adaptiveMultiplier + 0.02, 1.15);
                        calibrationRecord.positiveRealizations += 1;
                    } else if (actualMeanSince < target * 0.5 && daysSince > 10) {
                        adaptiveMultiplier = Math.max(adaptiveMultiplier - 0.03, 0.7);
                    }
                } else {
                    // Constant Observation: If user beat their own historical baseline significantly without a "Hero Hint"
                    const historicalMean = getMean(getDailyList(earningsHistory.filter(e => e.date < lastCheck)));
                    if (actualMeanSince > historicalMean * 1.05 && actualMeanSince < historicalMean * 1.25) {
                        adaptiveMultiplier = Math.min(adaptiveMultiplier + 0.01, 1.15);
                    }
                }
                
                calibrationRecord.realizationMultiplier = adaptiveMultiplier;
                if (calibrationRecord.lastProjectedAt) {
                    calibrationRecord.history.push({
                        projected: calibrationRecord.lastProjectedGain,
                        actual: Math.round(actualMeanSince),
                        date: today,
                        multiplierAtTime: adaptiveMultiplier
                    });
                }
                calibrationRecord.lastProjectedAt = null; 
                await calibrationRecord.save();
            }
        }

        const stats = { totalEarnings, totalTasks, platformStats, hourStats, dailyStats, activeGoal, earningsHistory, globalTrends, recencyFactor, dataStrength, adaptiveMultiplier };

        // --- HIERARCHICAL SCORING ---
        const calculateScore = (impact, count, baseTier = 0) => {
            const confidence = Math.min(count / 15, 1);
            const normalizedImpact = Math.min(Math.abs(impact), 100);
            let effectiveTier = baseTier;
            if (confidence < 0.4) effectiveTier = Math.min(baseTier, 300);
            const score = effectiveTier + (normalizedImpact * confidence * recencyFactor * dataStrength);
            return { score, confidence: Math.round(confidence * 100) / 100, effectiveTier };
        };

        // --- MODULAR INSIGHT ENGINE ---
        const insightModules = [
            (ctx) => { // 1. PERFORMANCE DECLINE
                const recentWindow = ctx.earningsHistory.filter(e => e.date >= fourteenDaysAgo);
                if (recentWindow.length < 5 || ctx.totalTasks < 15) return null;
                const rAvg = recentWindow.reduce((s,e)=>s+e.amount, 0) / recentWindow.length;
                const hAvg = ctx.totalEarnings / ctx.totalTasks;
                if (rAvg < hAvg * 0.82) {
                    const loss = Math.round((1 - (rAvg/hAvg)) * 100);
                    const recoveryVal = Math.round(hAvg - rAvg);
                    const { score, confidence, effectiveTier } = calculateScore(loss * 2.5, recentWindow.length, 900);
                    return { id: 'perf_decline', title: "Earning Slowdown", insight: `Your avg payout is down ${loss}% vs your baseline.`, action: "Check if base rates have changed on your primary app.", type: "risk", tier: effectiveTier, score, confidence, context: { recoveryVal } };
                }
                return null;
            },
            (ctx) => { // 2. FATIGUE CURVE
                const dailySequences = {};
                ctx.earningsHistory.forEach(e => {
                    const day = new Date(e.date).toISOString().split('T')[0];
                    if (!dailySequences[day]) dailySequences[day] = [];
                    dailySequences[day].push(e.amount);
                });
                let sessions = 0, f5 = 0, f5c = 0, a5 = 0, a5c = 0;
                Object.values(dailySequences).forEach(seq => {
                    if (seq.length > 7) {
                        sessions++;
                        seq.slice(0, 5).forEach(v => { f5 += v; f5c++; });
                        seq.slice(5).forEach(v => { a5 += v; a5c++; });
                    }
                });
                if (sessions >= 2) {
                    const drop = Math.round((( (f5/f5c) - (a5/a5c) ) / (f5/f5c)) * 100);
                    if (drop > 15) {
                        const { score, confidence, effectiveTier } = calculateScore(drop, sessions * 5, 800);
                        return { id: 'fatigue_curve', title: "Efficiency Alert", insight: `Your rate drops ${drop}% after 5 tasks.`, action: "A 10-min reset after 5 deliveries improves focus.", type: "battery", tier: effectiveTier, score, confidence };
                    }
                }
                return null;
            },
            (ctx) => { // 3. OPPORTUNITY GAP
                const sigPlat = [...ctx.platformStats].filter(p => p.count >= 3);
                if (sigPlat.length < 2) return null;
                const topP = sigPlat[0];
                const gaps = [];
                ctx.platformStats.forEach(plat => {
                    if (plat._id === topP._id) return;
                    const diff = topP.avgAmount - plat.avgAmount;
                    if (diff > 50) {
                        const missed = diff * plat.count;
                        const impact = (missed / (ctx.totalEarnings || 1)) * 100;
                        if (missed > 200) {
                            const { score, confidence, effectiveTier } = calculateScore(impact * 5, topP.count, 800);
                            gaps.push({ id: `opp_gap_${plat._id}`, title: "Earnings Gap", insight: `Using ${topP._id} over ${plat._id} could have earned you ₹${Math.round(missed).toLocaleString()} more.`, action: `Prioritize ${topP._id} (₹${Math.round(topP.avgAmount)}/task).`, type: "platform", tier: effectiveTier, score, confidence, context: { plat: topP._id, diff: Math.round(diff) } });
                        }
                    }
                });
                return gaps.sort((a,b)=>b.score-a.score)[0];
            },
            (ctx) => { // 4. PEAK HOUR
                const sorted = [...ctx.hourStats].sort((a,b)=>b.avgAmount - a.avgAmount);
                if (sorted.length === 0) return null;
                const topH = sorted[0];
                const avg = ctx.totalEarnings / (ctx.totalTasks || 1);
                const impr = Math.round(((topH.avgAmount - avg) / (avg || 1)) * 100);
                if (impr > 15 && topH.count >= 3) {
                    const startH = topH._id;
                    const fmt = (h) => `${h % 12 || 12}${h >= 12 ? 'PM' : 'AM'}`;
                    const { score, confidence, effectiveTier } = calculateScore(impr, topH.count, 600);
                    return { id: 'peak_hour', title: "Prime Time", insight: `Your velocity zooms up ${impr}% at ${fmt(startH)}.`, action: "Go online 30 mins early to hit this peak.", type: "time", tier: effectiveTier, score, confidence, context: { rawHour: startH, impr } };
                }
                return null;
            },
            (ctx) => { // 5. PLATFORM DIVERSITY
                if (ctx.totalTasks < 6) return null;
                const topP = [...ctx.platformStats].sort((a,b)=>b.count-a.count)[0];
                const rel = topP.count / ctx.totalTasks;
                if (rel > 0.85) {
                    const pct = Math.round(rel * 100);
                    const { score, confidence, effectiveTier } = calculateScore(pct, topP.count, 500);
                    return { id: 'diversity_alert', title: "Stability Risk", insight: `You rely on ${topP._id} for ${pct}% of your tasks.`, action: "Link a secondary app to protect your income flow.", type: "platform", tier: effectiveTier, score, confidence, context: { plat: topP._id, dependency: pct } };
                }
                return null;
            }
        ];

        // --- EXECUTE & TACTICAL MERGE ---
        let rawResults = insightModules.map(m => m(stats)).filter(Boolean);
        const divIdx = rawResults.findIndex(r => r.id === 'diversity_alert');
        const gapIdx = rawResults.findIndex(r => r.id.startsWith('opp_gap_'));
        if (divIdx !== -1 && gapIdx !== -1 && rawResults[divIdx].context?.plat !== rawResults[gapIdx].context?.plat) {
            const div = rawResults[divIdx];
            const gap = rawResults[gapIdx];
            const activeDaysCount = getDailyList(earningsHistory).length || 1;
            const tasksPerActiveDay = totalTasks / activeDaysCount;
            const monthlyTasks = tasksPerActiveDay * 30;
            const shiftTasks = monthlyTasks * 0.2; 
            const monthlyImpact = (shiftTasks * gap.context.diff) * adaptiveMultiplier;
            div.id = 'strategic_shift';
            div.title = "Strategic Shift";
            div.insight = `Over-relying on ${div.context.plat} (${div.context.dependency}%) misses ${gap.context.plat}'s higher rates.`;
            div.action = `Shifting 20% of work could add ₹${Math.floor(monthlyImpact / 100) * 100}/mo based on your realization rate.`;
            div.score = gap.score + 150; 
            div.context.preferredPlat = gap.context.plat;
            div.context.potentialGain = Math.floor(monthlyImpact / 50) * 50;
            div.context.isMonthly = true;
            rawResults.splice(gapIdx, 1);
        }

        const sorted = rawResults.sort((a,b)=>b.score - a.score);
        const finalCards = sorted.slice(0, 2); 
        const categoryCount = {};
        finalCards.forEach(c => { categoryCount[c.type] = (categoryCount[c.type] || 0) + 1; });
        for (let i = 2; i < sorted.length; i++) {
            if (finalCards.length >= 4) break;
            const inc = sorted[i];
            if ((categoryCount[inc.type] || 0) < 2) {
                finalCards.push(inc);
                categoryCount[inc.type] = (categoryCount[inc.type] || 0) + 1;
            }
        }
        if (finalCards.length < 3) finalCards.push({ id: 'base_tip', title: "Pro Tip", insight: "Switching platforms during lunch hours (12-2 PM) often maximizes payouts.", action: "Try tomorrow", type: "general", tier: 0, score: 50, confidence: 1.0 });

        // --- PREDICTION ---
        const monthlyDaysArr = getDailyList(earningsHistory.filter(e => e.date >= sixtyDaysAgo));
        const recentDaysArr = getDailyList(earningsHistory.filter(e => e.date >= fourteenDaysAgo));
        const meanR = getMean(recentDaysArr);
        const meanM = getMean(monthlyDaysArr);
        const centerPoint = (meanR * 0.75) + (meanM * 0.25) || 500;
        const overallMean = getMean(monthlyDaysArr.length ? monthlyDaysArr : [centerPoint]);
        const varianceVal = (monthlyDaysArr.length ? monthlyDaysArr : [overallMean]).reduce((s,v)=> s + Math.pow(v - overallMean, 2), 0) / (monthlyDaysArr.length || 1);
        const standardDev = Math.sqrt(varianceVal);
        const volRatio = standardDev / (centerPoint || 1);
        const incomeStability = volRatio < 0.2 ? "Stable" : (volRatio < 0.45 ? "Moderate" : "High Volatility");
        let confidenceBand = dataStrength > 0.8 ? (volRatio < 0.35 ? "High" : (volRatio < 0.8 ? "Moderate" : "Low")) : (dataStrength < 0.4 || volRatio > 1.2 ? "Low" : "Moderate");
        const cappedVol = Math.min(volRatio, 0.65);
        const spreadRatio = cappedVol * (1.0 - (dataStrength * 0.5));
        const lowVal = centerPoint * (1 - spreadRatio);
        const highVal = centerPoint * (1 + spreadRatio);

        // --- HERO GENERATOR (v2.9 Fixes) ---
        const topInsight = finalCards[0];
        const primaryPlat = [...platformStats].sort((a,b)=>b.count-a.count)[0];
        let heroPlatName = primaryPlat?._id || "Gig Apps";
        let heroTimeWindow = "6–9 PM";
        let heroGainAmount = 0;
        let dailyPotentialGain = 0;

        if (topInsight) {
            heroPlatName = topInsight.context?.preferredPlat || topInsight.context?.plat || heroPlatName;
            const reliabilityMultiplier = confidenceBand === "High" ? 1.0 : (confidenceBand === "Moderate" ? 0.8 : 0.6);

            if (topInsight.id === 'strategic_shift') {
                heroGainAmount = topInsight.context.potentialGain * reliabilityMultiplier;
                dailyPotentialGain = heroGainAmount / 30; // Monthly Normalized
            } else if (topInsight.id === 'peak_hour') {
                heroGainAmount = (centerPoint * (topInsight.context.impr / 100) * 5) * reliabilityMultiplier;
                dailyPotentialGain = (centerPoint * (topInsight.context.impr / 100)) * reliabilityMultiplier; // Marginal Daily
            } else if (topInsight.id === 'perf_decline') {
                heroGainAmount = (topInsight.context.recoveryVal * 10) * reliabilityMultiplier;
                dailyPotentialGain = topInsight.context.recoveryVal * reliabilityMultiplier; // Marginal Daily
            } else {
                heroGainAmount = (centerPoint * 0.15 * 5) * reliabilityMultiplier;
                dailyPotentialGain = (centerPoint * 0.05) * reliabilityMultiplier;
            }

            if (topInsight.context?.rawHour !== undefined) {
                const hour = topInsight.context.rawHour;
                const fmt = (h) => `${h % 12 || 12}${h >= 12 ? 'PM' : 'AM'}`;
                heroTimeWindow = `${fmt(hour)} – ${fmt((hour + 2) % 24)}`;
            }
        }

        // --- LOG PROJECTED GAIN ---
        if (dailyPotentialGain > 0) {
            const projDailyTotal = Math.round(centerPoint + dailyPotentialGain);
            if (calibrationRecord) {
                calibrationRecord.lastProjectedGain = projDailyTotal;
                calibrationRecord.lastProjectedAt = today;
                calibrationRecord.totalInsightsShown += 1;
                await calibrationRecord.save();
            } else {
                await InsightCalibration.create({ user_id: userId, lastProjectedGain: projDailyTotal, lastProjectedAt: today, totalInsightsShown: 1 });
            }
        }

        res.json({
            primaryRecommendation: { platform: heroPlatName, hourRange: heroTimeWindow, potentialIncrease: Math.floor(heroGainAmount / 10) * 10, surgeFactor: 1.4, reason: topInsight.insight },
            insightCards: finalCards,
            platformPerformance: userPlatforms.map(up => {
                const s = platformStats.find(ps => ps._id.toLowerCase() === up.platform_name.toLowerCase());
                return { name: up.platform_name, earnings: s?.totalEarnings || 0, avgRate: Math.round(s?.avgAmount || 0), maxRate: Math.round((platformStats[0]?.avgAmount || 500) * 1.25) };
            }).sort((a,b)=>b.earnings - a.earnings),
            prediction: { low: Math.floor(lowVal/50)*50, high: Math.ceil(highVal/50)*50, basis: meanR > meanM ? "Recent momentum building" : "Stable historical pattern", confidenceBand },
            metadata: { dataStrength: Math.round(dataStrength*100)/100, advisorLevel: dataStrength > 0.8 ? "Advanced" : "Rising", incomeStability, volatilityScore: Math.round(volRatio * 100) / 100, calibrationFactor: Math.round(adaptiveMultiplier * 100) / 100 }
        });

    } catch (err) {
        console.error(`[ADAPTIVE ENGINE v2.9 ERROR]:`, err);
        res.status(500).json({ error: 'Server error' });
    }
};

const getMean = a => a.length ? a.reduce((s,v)=>s+v, 0) / a.length : 0;
