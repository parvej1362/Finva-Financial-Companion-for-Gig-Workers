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

async function runResetData() {
    try {
        const schemaPath = path.join(__dirname, 'reset_data.sql');
        const schemaSql = fs.readFileSync(schemaPath, 'utf8');

        console.log('Running reset_data.sql to clear data...');
        await pool.query(schemaSql);
        console.log('Data cleared successfully (tables kept intact)!');
    } catch (err) {
        console.error('Error running reset_data.sql:', err);
    } finally {
        await pool.end();
    }
}

runResetData();
