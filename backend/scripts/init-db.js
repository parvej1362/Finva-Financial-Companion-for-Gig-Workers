const { Client } = require('pg');
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '../.env') });

const createDatabase = async () => {
  const client = new Client({
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    database: 'postgres', // Connect to default database first
  });

  try {
    await client.connect();
    
    // Check if database exists
    const res = await client.query("SELECT 1 FROM pg_database WHERE datname = 'finva'");
    if (res.rows.length === 0) {
      console.log('Creating database finva...');
      await client.query('CREATE DATABASE finva');
      console.log('Database finva created successfully.');
    } else {
      console.log('Database finva already exists.');
    }
  } catch (err) {
    console.error('Error creating database:', err);
  } finally {
    await client.end();
  }
};

const createTables = async () => {
  const client = new Client({
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    database: 'finva', // Connect to new database
  });

  try {
    await client.connect();
    
    console.log('Creating tables...');
    
    const createUsersTable = `
      CREATE TABLE IF NOT EXISTS users (
        id SERIAL PRIMARY KEY,
        name VARCHAR(100),
        email VARCHAR(100) UNIQUE,
        phone VARCHAR(20) UNIQUE,
        password_hash VARCHAR(255) NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      );
    `;
    
    await client.query(createUsersTable);
    console.log('Table users created successfully.');
    
  } catch (err) {
    console.error('Error creating tables:', err);
  } finally {
    await client.end();
  }
};

const init = async () => {
  await createDatabase();
  await createTables();
};

init();