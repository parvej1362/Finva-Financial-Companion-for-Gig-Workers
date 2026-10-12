const mongoose = require('mongoose');
const Earning = require('../models/Earning');
const Platform = require('../models/Platform');

exports.getEarningsSummary = async (req, res) => {
    try {
        const userId = new mongoose.Types.ObjectId(req.user.id);

        const today = new Date();
        today.setHours(0, 0, 0, 0);
        const yesterday = new Date(today);
        yesterday.setDate(yesterday.getDate() - 1);

        // Optimized aggregation for summaries
        const summaryStats = await Earning.aggregate([
            { $match: { user_id: userId } },
            {
                $group: {
                    _id: null,
                    totalEarnings: { $sum: "$amount" },
                    totalEntries: { $sum: 1 },
                    todayEarnings: {
                        $sum: {
                            $cond: [{ $gte: ["$date", today] }, "$amount", 0]
                        }
                    },
                    yesterdayEarnings: {
                        $sum: {
                            $cond: [
                                {
                                    $and: [
                                        { $gte: ["$date", yesterday] },
                                        { $lt: ["$date", today] }
                                    ]
                                },
                                "$amount",
                                0
                            ]
                        }
                    }
                }
            }
        ]);

        const stats = summaryStats[0] || {
            totalEarnings: 0,
            totalEntries: 0,
            todayEarnings: 0,
            yesterdayEarnings: 0
        };

        const averagePerEntry = stats.totalEntries > 0 ? (stats.totalEarnings / stats.totalEntries).toFixed(2) : 0;

        let percentageChange = 0;
        if (stats.yesterdayEarnings > 0) {
            percentageChange = ((stats.todayEarnings - stats.yesterdayEarnings) / stats.yesterdayEarnings) * 100;
        } else if (stats.todayEarnings > 0) {
            percentageChange = 100;
        }

        const activePlatformsCount = await Platform.countDocuments({ user_id: userId, status: 'active' });

        // Get hourly data efficiently
        const hourlyData = await Earning.aggregate([
            {
                $match: {
                    user_id: userId,
                    date: { $gte: yesterday }
                }
            },
            {
                $project: {
                    amount: 1,
                    hour: { $hour: "$date" },
                    isToday: { $gte: ["$date", today] }
                }
            },
            {
                $group: {
                    _id: { hour: "$hour", isToday: "$isToday" },
                    amount: { $sum: "$amount" }
                }
            }
        ]);

        const hourlyToday = new Array(24).fill(0);
        const hourlyYesterday = new Array(24).fill(0);

        hourlyData.forEach(item => {
            if (item._id.isToday) {
                hourlyToday[item._id.hour] = item.amount;
            } else {
                hourlyYesterday[item._id.hour] = item.amount;
            }
        });

        // Limit history to last 50 entries for performance
        const history = await Earning.find({ user_id: userId })
            .sort({ date: -1 })
            .limit(50)
            .lean();

        res.json({
            summary: {
                totalEarnings: stats.totalEarnings,
                totalEntries: stats.totalEntries,
                averagePerEntry,
                activePlatformsCount,
                todayEarnings: stats.todayEarnings,
                yesterdayEarnings: stats.yesterdayEarnings,
                percentageChange: percentageChange.toFixed(1)
            },
            hourly: {
                today: hourlyToday,
                yesterday: hourlyYesterday
            },
            history
        });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error' });
    }
};

exports.addEarning = async (req, res) => {
    const { platform, amount, date } = req.body;
    const userId = req.user.id;

    // Strict validation
    if (!platform || typeof platform !== 'string' || platform.trim() === '') {
        return res.status(400).json({ error: 'Valid platform name is required' });
    }

    if (amount === undefined || isNaN(amount) || amount < 0) {
        return res.status(400).json({ error: 'Amount must be a positive number' });
    }

    const earningDate = date ? new Date(date) : new Date();
    if (isNaN(earningDate.getTime())) {
        return res.status(400).json({ error: 'Invalid date format' });
    }

    try {
        const entry = await Earning.create({
            user_id: userId,
            platform: platform.trim(),
            amount: Number(amount),
            date: earningDate
        });
        res.status(201).json(entry);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error' });
    }
};

exports.getPlatforms = async (req, res) => {
    try {
        const userId = req.user.id;
        const platforms = await Platform.find({ user_id: userId }).lean();
        res.json(platforms);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error' });
    }
};

exports.addPlatform = async (req, res) => {
    const { platformName } = req.body;
    const userId = req.user.id;

    if (!platformName || typeof platformName !== 'string' || platformName.trim() === '') {
        return res.status(400).json({ error: 'Valid platform name is required' });
    }

    const trimmedName = platformName.trim();

    try {
        const existingPlatform = await Platform.findOne({
            user_id: userId,
            platform_name: { $regex: new RegExp(`^${trimmedName}$`, 'i') }
        });

        if (existingPlatform) {
            return res.status(200).json(existingPlatform);
        }

        const platform = await Platform.create({
            user_id: userId,
            platform_name: trimmedName,
            status: 'active'
        });
        res.status(201).json(platform);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error' });
    }
};
