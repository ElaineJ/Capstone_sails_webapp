USE CapstoneDB;
ALTER TABLE patients ADD expo_push_token VARCHAR(60);
ALTER TABLE gps ADD expo_push_token VARCHAR(60);
ALTER TABLE consultants ADD expo_push_token VARCHAR(60);
