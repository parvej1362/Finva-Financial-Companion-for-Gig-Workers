-- comprehensive_schema.sql

-- 1. Platforms (Linked Accounts)
CREATE TABLE platforms (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    platform_name VARCHAR(50) NOT NULL, -- 'Swiggy', 'Zomato', 'Upwork', 'Fiverr'
    status VARCHAR(20) DEFAULT 'active', -- 'active', 'pending', 'inactive'
    linked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Earnings (Daily Records)
CREATE TABLE earnings (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    platform_id INTEGER REFERENCES platforms(id),
    amount DECIMAL(10, 2) NOT NULL,
    date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Safety Pot (Savings Goals)
CREATE TABLE safety_pot_goals (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    goal_name VARCHAR(100) NOT NULL, -- 'Emergency Fund', 'New Bike', 'Laptop'
    target_amount DECIMAL(10, 2) NOT NULL,
    current_amount DECIMAL(10, 2) DEFAULT 0,
    status VARCHAR(20) DEFAULT 'active', -- 'active', 'completed', 'paused'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Safety Pot Transactions (In/Out)
CREATE TABLE safety_pot_transactions (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    goal_id INTEGER REFERENCES safety_pot_goals(id),
    amount DECIMAL(10, 2) NOT NULL,
    type VARCHAR(10) NOT NULL, -- 'credit', 'debit' (saved vs withdrawn)
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 5. Insurance Plans (Available Products)
CREATE TABLE insurance_plans (
    id SERIAL PRIMARY KEY,
    plan_name VARCHAR(100) NOT NULL,
    provider VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL, -- 'Health', 'Bike', 'Income Protection'
    premium_amount DECIMAL(10, 2) NOT NULL,
    coverage_amount DECIMAL(10, 2) NOT NULL,
    description TEXT
);

-- 6. User Insurance (Active Policies)
CREATE TABLE user_policies (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    plan_id INTEGER REFERENCES insurance_plans(id),
    status VARCHAR(20) DEFAULT 'active', -- 'active', 'expired', 'claimed'
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    policy_number VARCHAR(50) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 7. KYC Documents
CREATE TABLE kyc_documents (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    document_type VARCHAR(50) NOT NULL, -- 'Aadhaar', 'PAN', 'Driving License'
    document_number VARCHAR(50),
    file_url TEXT,
    status VARCHAR(20) DEFAULT 'pending', -- 'pending', 'verified', 'rejected'
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 8. Help/Support Tickets
CREATE TABLE support_tickets (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    subject VARCHAR(200) NOT NULL,
    message TEXT NOT NULL,
    status VARCHAR(20) DEFAULT 'open', -- 'open', 'in_progress', 'resolved'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
