USE CapstoneDB;
ALTER TABLE patients ADD expo_push_token VARCHAR(60);
ALTER TABLE gps ADD expo_push_token VARCHAR(60);
ALTER TABLE consultants ADD expo_push_token VARCHAR(60);

SELECT * from patients;

UPDATE patients 
  SET expo_push_token="ExponentPushToken[ZvrT4RBaL6uc7c9Y4sOJTj]" 
  WHERE nric= "S9512721E";