USE nCubedDB;
ALTER TABLE patients ADD expo_push_token VARCHAR(60);
ALTER TABLE gps ADD expo_push_token VARCHAR(60);
ALTER TABLE consultants ADD expo_push_token VARCHAR(60);

-- ----------- DOWN ------------
-- ALTER TABLE patients DROP expo_push_token;
-- ALTER TABLE gps DROP expo_push_token;
-- ALTER TABLE consultants DROP expo_push_token;