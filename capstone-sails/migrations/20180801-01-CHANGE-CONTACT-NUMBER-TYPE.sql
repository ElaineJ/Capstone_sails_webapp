USE CapstoneDB;
ALTER TABLE schedulers MODIFY contact_number VARCHAR(40) DEFAULT NULL;
ALTER TABLE gps MODIFY contact_number VARCHAR(40) DEFAULT NULL;
ALTER TABLE consultants MODIFY contact_number VARCHAR(40) DEFAULT NULL;

-- DOWN --

-- ALTER TABLE schedulers MODIFY contact_number INT DEFAULT NULL;
-- ALTER TABLE gps MODIFY contact_number INT DEFAULT NULL;
-- ALTER TABLE consultants MODIFY contact_number INT DEFAULT NULL;
