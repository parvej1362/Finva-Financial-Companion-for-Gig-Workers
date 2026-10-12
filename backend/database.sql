CREATE DATABASE finva;

-- Connect to finva database
-- \c finva

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100) UNIQUE,
  phone VARCHAR(20) UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Example User
-- INSERT INTO users (name, email, phone, password_hash) VALUES ('Rajesh Kumar', 'rajesh.k@email.com', '+919876543210', 'hashed_password_here');