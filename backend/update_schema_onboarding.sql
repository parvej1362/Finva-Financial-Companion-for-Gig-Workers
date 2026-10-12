-- update_schema_onboarding.sql

-- 1. Add DOB to users table
ALTER TABLE users ADD COLUMN IF NOT EXISTS dob DATE;

-- 2. Add Work Type to users table (or create a profile table, strictly adding to users for simplicity as per request)
ALTER TABLE users ADD COLUMN IF NOT EXISTS work_type VARCHAR(50); -- 'Delivery', 'Ride-sharing', 'Freelance'

-- 3. Create Bank Accounts table
CREATE TABLE IF NOT EXISTS bank_accounts (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    upi_id VARCHAR(100),
    account_number VARCHAR(50),
    ifsc_code VARCHAR(20),
    bank_name VARCHAR(100),
    is_primary BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Vehicle Details (For Step 3)
CREATE TABLE IF NOT EXISTS vehicle_details (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    registration_number VARCHAR(20),
    driving_license VARCHAR(50),
    vehicle_type VARCHAR(50), -- 'Bike', 'Car', 'Scooter'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
