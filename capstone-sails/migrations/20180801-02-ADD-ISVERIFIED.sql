USE CapstoneDB;
ALTER TABLE gps 
ADD COLUMN is_verified boolean NOT NULL DEFAULT 0,
ADD COLUMN registration_id VARCHAR(30) NOT NULL;
ALTER TABLE consultants 
ADD COLUMN is_verified boolean NOT NULL DEFAULT 0,
ADD COLUMN registration_id VARCHAR(30) NOT NULL;

-- DOWN

-- ALTER TABLE gps 
-- DROP COLUMN is_verified,
-- DROP COLUMN registration_id;
-- ALTER TABLE consultants 
-- DROP COLUMN is_verified,
-- DROP COLUMN registration_id;
