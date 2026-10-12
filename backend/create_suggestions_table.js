const { Pool } = require('pg');
require('dotenv').config();

const pool = new Pool({
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  database: process.env.DB_NAME,
});

const createTableQuery = `
  CREATE TABLE IF NOT EXISTS platform_suggestions (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    app_name VARCHAR(100) NOT NULL,
    suggested_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  );
`;

const run = async () => {
  try {
    await pool.query(createTableQuery);
    console.log('Platform suggestions table created successfully');
    process.exit(0);
  } catch (err) {
    console.error(err);
    process.exit(1);
  }
};

run();