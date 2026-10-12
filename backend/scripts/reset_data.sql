-- Clean up all tables (maintain relationships order)
DELETE FROM otps;
DELETE FROM safety_pot_transactions;
DELETE FROM safety_pot_goals;
DELETE FROM earnings;
DELETE FROM platforms;
DELETE FROM kyc_documents;
DELETE FROM vehicle_details;
DELETE FROM bank_accounts;
DELETE FROM support_tickets;
DELETE FROM user_policies;
DELETE FROM users;

-- Reset sequences (ids start from 1 again)
ALTER SEQUENCE users_id_seq RESTART WITH 1;
ALTER SEQUENCE otps_id_seq RESTART WITH 1;
