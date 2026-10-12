const { Pool } = require('pg');
const fs = require('fs');
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '../.env') });

const pool = new Pool({
    user: process.env.DB_USER || 'postgres',
    host: process.env.DB_HOST || 'localhost',
    database: process.env.DB_NAME || 'finva',
    password: process.env.DB_PASSWORD,
    port: process.env.DB_PORT || 5432,
});

async function resetDb() {
    try {
        console.log('--- RESETTING DATABASE (EXPLICIT DROP) ---');

        const tableDropQuery = `
      DROP TABLE IF EXISTS safety_pot_transactions CASCADE;
      DROP TABLE IF EXISTS safety_pot_goals CASCADE;
      DROP TABLE IF EXISTS earnings CASCADE;
      DROP TABLE IF EXISTS platforms CASCADE;
      DROP TABLE IF EXISTS user_policies CASCADE;
      DROP TABLE IF EXISTS insurance_plans CASCADE;
      DROP TABLE IF EXISTS kyc_documents CASCADE;
      DROP TABLE IF EXISTS vehicle_details CASCADE;
      DROP TABLE IF EXISTS bank_accounts CASCADE;
      DROP TABLE IF EXISTS support_tickets CASCADE;
      DROP TABLE IF EXISTS otps CASCADE;
      DROP TABLE IF EXISTS users CASCADE;
    `;

        console.log('1. Dropping Tables...');
        await pool.query(tableDropQuery);
        console.log('Tables Dropped.');

        // 2. Run functionality schemas IN ORDER
        const schemas = [
            '../init_tables.sql', // Creates USERS table (Correct file)
            '../comprehensive_schema.sql', // Creates base tables
            '../update_schema_onboarding.sql', // Adds onboarding tables
            '../otp_schema.sql', // Adds OTP tables
            '../consents_schema.sql' // Adds Consents table
        ];

        for (const schemaFile of schemas) {
            const schemaPath = path.join(__dirname, schemaFile);
            if (fs.existsSync(schemaPath)) {
                console.log(`2. Executing: ${schemaFile}`);
                const sql = fs.readFileSync(schemaPath, 'utf8');
                await pool.query(sql);
            } else {
                console.error(`File not found: ${schemaFile}`);
            }
        }

        console.log('--- DATABASE RESET & REBUILT SUCCESSFULLY ---');
    } catch (err) {
        console.error('FATAL ERROR resetting database:', err);
    } finally {
        await pool.end();
    }
}

resetDb();
