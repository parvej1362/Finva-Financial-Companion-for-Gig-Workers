const express = require('express');
const cors = require('cors');
const cookieParser = require('cookie-parser');
const authRoutes = require('./routes/auth');
const userRoutes = require('./routes/user');
require('dotenv').config();
const connectDB = require('./db/index');

// Connect to MongoDB
connectDB();

const app = express();
const PORT = process.env.PORT || 5000;

app.use(cors({
  origin: process.env.FRONTEND_URL || 'http://localhost:5173' || 'http://localhost:64337', // Adjust based on your frontend URL
  credentials: true,
}));
app.use(express.json());
app.use(cookieParser());

app.use('/api/auth', authRoutes);
app.use('/api/user', userRoutes);
app.use('/api/user/onboarding', require('./routes/onboarding'));
app.use('/api/earnings', require('./routes/earnings'));
app.use('/api/safety-pot', require('./routes/safety_pot'));
app.use('/api/insurance', require('./routes/insurance'));
app.use('/api/support', require('./routes/support'));
app.use('/api/kyc', require('./routes/kyc'));
app.use('/api/notifications', require('./routes/notification'));
app.use('/api/insights', require('./routes/insights'));
app.use('/api/instant-support', require('./routes/instant_support'));
app.use('/api/stability', require('./routes/stability'));


app.use('/api/simulation', require('./routes/simulation'));

app.get('/', (req, res) => {
  res.send('Finva Backend Running');
});

const startEarningSimulator = require('./services/earningSimulator');

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
  // Start the background simulator
  startEarningSimulator();
});