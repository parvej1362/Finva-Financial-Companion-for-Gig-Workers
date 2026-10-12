const { Pool } = require('pg');
const fs = require('fs');
const path = require('path');
require('dotenv').config();

const pool = new Pool({
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    database: process.env.DB_NAME,
});

const run = async () => {
    try {
        const sqlPath = path.join(__dirname, 'clear_data.sql');
        const sql = fs.readFileSync(sqlPath, 'utf8');

        console.log('Running clear_data.sql...');
        await pool.query(sql);
        console.log('Successfully cleared all data.');
        process.exit(0);
    } catch (err) {
        console.error('Error clearing data:', err);
        process.exit(1);
    }
};

run();
