TRUNCATE TABLE 
    users, 
    platforms, 
    earnings, 
    safety_pot_goals, 
    safety_pot_transactions, 
    insurance_plans, 
    user_policies, 
    kyc_documents, 
    support_tickets, 
    bank_accounts, 
    vehicle_details, 
    otps, 
    consents
    -- platform_suggestions,
    -- integrations
RESTART IDENTITY CASCADE;
