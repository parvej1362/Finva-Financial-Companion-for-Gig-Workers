const axios = require('axios'); // Note: User might need to install axios or use fetch

const API_URL = 'http://localhost:5000/api';

async function testApi() {
    console.log('--- Testing Finva API ---');

    try {
        // 1. Register a test user
        console.log('\n1. Registering test user...');
        const registerRes = await axios.post(`${API_URL}/auth/register`, {
            name: 'Test User',
            email: `test_${Date.now()}@example.com`,
            phone: `98${Math.floor(10000000 + Math.random() * 90000000)}`,
            password: 'password123',
            dob: '1995-01-01'
        });

        const { phone, demoOtp } = registerRes.data;
        console.log('Register Success. Received Demo OTP:', demoOtp);

        // 2. Verify OTP
        console.log('\n2. Verifying OTP...');
        const verifyRes = await axios.post(`${API_URL}/auth/verify-otp`, {
            phone: phone,
            otp: demoOtp
        });

        const token = verifyRes.data.token;
        console.log('Verification Success. Token received.');

        // 3. Test Protected Route (Earnings)
        console.log('\n3. Testing Protected Route: GET /api/earnings');
        const earningsRes = await axios.get(`${API_URL}/earnings`, {
            headers: { Authorization: `Bearer ${token}` }
        });

        console.log('Earnings Data:', JSON.stringify(earningsRes.data, null, 2));

        // 4. Test Adding a Platform
        console.log('\n4. Testing Protected Route: POST /api/earnings/platforms');
        const platformRes = await axios.post(`${API_URL}/earnings/platforms`,
            { platformName: 'Swiggy' },
            { headers: { Authorization: `Bearer ${token}` } }
        );
        console.log('Platform Added:', platformRes.data);

        console.log('\n--- API Test Completed Successfully ---');
    } catch (error) {
        console.error('\nAPI Test Failed:');
        if (error.response) {
            console.error('Status:', error.response.status);
            console.error('Data:', error.response.data);
        } else {
            console.error('Error:', error.message);
        }
    }
}

testApi();