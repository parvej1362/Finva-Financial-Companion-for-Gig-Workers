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
        const sqlPath = path.join(__dirname, 'add_picture_column.sql');
        const sql = fs.readFileSync(sqlPath, 'utf8');

        console.log('Running add_picture_column.sql...');
        await pool.query(sql);
        console.log('Successfully added picture column.');
        process.exit(0);
    } catch (err) {
        console.error('Error adding column:', err);
        process.exit(1);
    }
};

run();
