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

async function runUpdate() {
    try {
        const schemaPath = path.join(__dirname, '../update_schema_onboarding.sql');
        const schemaSql = fs.readFileSync(schemaPath, 'utf8');

        console.log('Running schema update for onboarding...');
        await pool.query(schemaSql);
        console.log('Schema updated successfully!');
    } catch (err) {
        console.error('Error running schema update:', err);
    } finally {
        await pool.end();
    }
}

runUpdate();
