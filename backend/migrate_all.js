const { Pool } = require('pg');
const fs = require('fs');
const path = require('path');
require('dotenv').config();

const pool = process.env.DATABASE_URL
    ? new Pool({
        connectionString: process.env.DATABASE_URL,
        ssl: {
            rejectUnauthorized: false
        }
    })
    : new Pool({
        user: process.env.DB_USER,
        password: process.env.DB_PASSWORD,
        host: process.env.DB_HOST,
        port: process.env.DB_PORT,
        database: process.env.DB_NAME,
    });

const run = async () => {
    try {
        console.log('Using database:', process.env.DATABASE_URL ? 'Neon Cloud' : 'Localhost');

        // Order matters due to foreign keys
        const files = [
            'init_tables.sql', // Creates users
            'comprehensive_schema.sql', // Creates core tables linked to users
            'update_schema_onboarding.sql', // Adds columns to users, creates bank_accounts
            'otp_schema.sql', // Adds columns to users, creates otps
            'consents_schema.sql', // Creates consents
            'add_picture_column.sql' // Adds picture column
        ];

        for (const file of files) {
            const sqlPath = path.join(__dirname, file);
            console.log(`Executing ${file}...`);
            const sql = fs.readFileSync(sqlPath, 'utf8');
            await pool.query(sql);
        }

        // Inline table creations that were in JS files
        console.log('Executing platform_suggestions creation...');
        await pool.query(`
          CREATE TABLE IF NOT EXISTS platform_suggestions (
            id SERIAL PRIMARY KEY,
            user_id INTEGER REFERENCES users(id),
            app_name VARCHAR(100) NOT NULL,
            suggested_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
          );
        `);

        console.log('Executing integrations creation...');
        await pool.query(`
          CREATE TABLE IF NOT EXISTS integrations (
            id SERIAL PRIMARY KEY,
            user_id INTEGER REFERENCES users(id),
            type VARCHAR(50) NOT NULL,
            provider_name VARCHAR(100),
            status VARCHAR(50) DEFAULT 'active',
            connected_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            meta_data JSONB 
          );
        `);

        console.log('Adding google_id if missing...');
        // We can just run this speculatively
        try {
            await pool.query(`ALTER TABLE users ADD COLUMN IF NOT EXISTS google_id VARCHAR(255) UNIQUE;`);
        } catch (e) { console.log('google_id column might already exist or error:', e.message); }


        console.log('Seed/Migration Completed Successfully!');
        process.exit(0);
    } catch (err) {
        console.error('Migration Error:', err);
        process.exit(1);
    }
};

run();
