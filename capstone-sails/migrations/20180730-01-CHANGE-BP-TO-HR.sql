Use nCubedDB;
ALTER TABLE cases CHANGE blood_pressure heart_rate VARCHAR(20);
UPDATE signs SET sign='Mcburneys' WHERE sign="McBurneys" AND sign_id=2;

-- ----------- DOWN ------------

-- ALTER TABLE cases CHANGE heart_rate blood_pressure VARCHAR(30);