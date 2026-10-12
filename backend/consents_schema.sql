-- consents_schema.sql
CREATE TABLE IF NOT EXISTS consents (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    earnings_consent BOOLEAN DEFAULT FALSE,
    bank_consent BOOLEAN DEFAULT FALSE,
    consent_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
