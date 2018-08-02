USE nCubedDB;
CREATE TABLE persistence (
  loggedTime DATETIME DEFAULT CURRENT_TIMESTAMP,
  consultant_on_duty boolean,
  licence_id_consultant VARCHAR(25),
  expo_push_token VARCHAR(60),
  PRIMARY KEY(loggedTime)
);


CREATE TABLE patient_consultants(
  nric VARCHAR(15),
  licence_id_consultant VARCHAR(60),
  FOREIGN KEY(nric) REFERENCES patients(nric),
  FOREIGN KEY(licence_id_consultant) REFERENCES consultants(licence_id_consultant)
);

INSERT into patient_consultants values('S9512721E', '987654321');

ALTER TABLE consultants
ADD is_online_messenger boolean DEFAULT 0;

-- SELECT * FROM consultants;

-- --------------------- DOWN------------------------------
-- 
-- SET foreign_key_checks=0;
-- DROP TABLE persistence;
-- DROP TABLE patient_consultants;
-- SET foreign_key_checks=1;