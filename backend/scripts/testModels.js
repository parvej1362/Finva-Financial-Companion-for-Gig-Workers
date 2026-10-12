const User = require('../models/User');
const Earnings = require('../models/Earnings');
const SafetyPot = require('../models/SafetyPot');
// Add more models as needed

async function testModels() {
    console.log('--- Testing Models ---');

    try {
        // 1. Test User Model (Find dummy)
        console.log('Testing User.findByEmail...');
        const user = await User.findByEmail('rajesh.k@email.com');
        if (user) {
            console.log('Successfully found user:', user.name);
        } else {
            console.log('No dummy user found, skipping specific user tests.');
        }

        // 2. Test Earnings
        if (user) {
            console.log('Testing Earnings.getSummaryByUserId...');
            const summary = await Earnings.getSummaryByUserId(user.id);
            console.log('Summary:', summary);
        }

        console.log('--- Tests Completed (Partial) ---');
        process.exit(0);
    } catch (error) {
        console.error('Test Failed:', error);
        process.exit(1);
    }
}

testModels();
