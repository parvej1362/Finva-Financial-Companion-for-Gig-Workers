const User = require('../models/User');
const Earning = require('../models/Earning');
const Notification = require('../models/Notification');
const Platform = require('../models/Platform');

// Platforms and their typical payout ranges (in INR)
const PLATFORMS = [
    { name: 'Swiggy', min: 250, max: 800 },
    { name: 'Zomato', min: 200, max: 900 },
    { name: 'Uber', min: 400, max: 1500 },
    { name: 'Ola', min: 350, max: 1200 },
    { name: 'Rapido', min: 100, max: 500 },
    { name: 'Porter', min: 500, max: 2000 },
    { name: 'Shadowfax', min: 300, max: 1000 },
    { name: 'Zepto', min: 200, max: 800 },
    { name: 'Blinkit', min: 200, max: 900 },
    { name: 'Amazon Flex', min: 500, max: 2500 }
];

const generateRandomEarning = async () => {
    try {
        console.log('[SIMULATOR] Attempting to generate random earning...');

        // 1. Pick a random user
        const users = await User.find().limit(50);

        if (users.length === 0) {
            console.log('[SIMULATOR] No users found.');
            return;
        }

        const randomUser = users[Math.floor(Math.random() * users.length)];

        // 2. Check for linked platforms
        const linkedPlatforms = await Platform.find({
            user_id: randomUser._id,
            status: 'active'
        });

        console.log(`[SIMULATOR] User ${randomUser.email} has ${linkedPlatforms.length} active platforms.`);
        if (linkedPlatforms.length > 0) {
            console.log(`[SIMULATOR] Platforms:`, linkedPlatforms.map(i => i.platform_name));
        }

        // Filter linked platforms that match our supported platforms
        const userPlatforms = linkedPlatforms
            .map(i => i.platform_name)
            .filter(name => PLATFORMS.some(p => p.name.toLowerCase() === name.toLowerCase()));

        console.log(`[SIMULATOR] User ${randomUser.email} matched platforms:`, userPlatforms);

        // If user has NO linked platforms, we skip generating to match requirement
        // "dont generate random platform for that user"
        if (userPlatforms.length === 0) {
            console.log(`[SIMULATOR] User ${randomUser.email} has no linked platforms. Skipping.`);
            return;
        }

        // 3. Pick one of the USER'S linked platforms
        const platformName = userPlatforms[Math.floor(Math.random() * userPlatforms.length)];
        const platformData = PLATFORMS.find(p => p.name.toLowerCase() === platformName.toLowerCase());

        if (!platformData) {
            console.log(`[SIMULATOR] platformData not found for ${platformName}`);
            return;
        }

        // 4. Generate random amount
        const amount = Math.floor(Math.random() * (platformData.max - platformData.min + 1)) + platformData.min;

        // 5. Construct SMS
        const date = new Date();
        const formattedDate = date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
        const smsContent = `Credit: Rs.${amount} credited to your account linked to ${platformData.name} on ${formattedDate}. Ref: FINVA_AUTO_${Date.now()}`;

        // 6. Create Notification (SMS)
        await Notification.create({
            user_id: randomUser._id,
            type: 'earning_sms',
            title: `New Payout from ${platformData.name}`,
            message: smsContent,
            data: {
                platform: platformData.name,
                amount: amount
            },
            received_at: date
        });

        // 7. Create Earning Record
        await Earning.create({
            user_id: randomUser._id,
            platform: platformData.name,
            amount,
            date: date,
            source_message: smsContent,
            status: 'verified'
        });

        // 8. Update Safety Pot (Behavioral Ledger)
        const safetyPotController = require('../controllers/safetyPotController');
        await safetyPotController.processDailyCalculations(randomUser._id);

        console.log(`[SIMULATOR] Generated Earning: Rs.${amount} for ${randomUser.name} (${randomUser.email}) from ${platformData.name}`);

    } catch (err) {
        console.error('[SIMULATOR] Error generating earning:', err.message);
    }
};

const startEarningSimulator = () => {
    // Run immediately on start
    generateRandomEarning();

    // Then run every 4-5 minutes (randomized)
    // 4 minutes = 240000 ms
    // 5 minutes = 300000 ms

    const scheduleNext = () => {
        // 40 minutes = 240,0000
        const delay = Math.floor(Math.random() * 60000) + 2400000;

        setTimeout(() => {
            generateRandomEarning();
            scheduleNext();
        }, delay);
    };

    scheduleNext();
};

module.exports = startEarningSimulator;
