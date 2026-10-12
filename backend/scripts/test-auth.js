// Using built-in fetch
const testAuth = async () => {
  try {
    // Check root
    const rootRes = await fetch('http://localhost:5000/');
    console.log('Root Status:', rootRes.status);
    console.log('Root Body:', await rootRes.text());

    // 1. Register
    const registerRes = await fetch('http://localhost:5000/api/auth/register', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        name: 'Test User',
        email: 'test@example.com',
        phone: '+919999999999',
        password: 'password123'
      })
    });
    
    console.log('Register Status:', registerRes.status);
    const registerText = await registerRes.text();
    console.log('Register Body:', registerText);
    
    let registerData;
    try {
        registerData = JSON.parse(registerText);
    } catch (e) {
        // console.log('Not JSON');
    }

    // 2. Login
    const loginRes = await fetch('http://localhost:5000/api/auth/login', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        identifier: 'test@example.com',
        password: 'password123'
      })
    });
    
    console.log('Login Status:', loginRes.status);
    const loginText = await loginRes.text();
    console.log('Login Body:', loginText);

  } catch (err) {
    console.error('Test failed:', err);
  }
};

testAuth();