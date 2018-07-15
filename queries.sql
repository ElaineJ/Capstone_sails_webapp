

USE CapstoneDB;

-- -----------------------------------Referral App ------------------------------

-- Query to check if patient record exists
SELECT * FROM patients WHERE patients.nric = 'S9811714J' AND patients.DOB = '1998-05-05';

-- Query to check if consultant or gps
SELECT * FROM gps WHERE gps.email = 'alantan@nuh.sg' AND gps.password = 'alantan';
SELECT * FROM consultants WHERE consultants.email = 'matttan@nuh.sg' AND consultants.password = 'matttan';

-- 
-- DOB DATETIME,
--     allergies VARCHAR(150),
--     medicalHistory VARCHAR(150),
-- 	gender CHAR(1) CHECK (gender="F" or gender="M"),
--     status
-- 
-- Query for case
SELECT cases.caseId, GROUP_CONCAT(DISTINCT patients.firstName, ' ', patients.lastName)patientName, cases.nric, GROUP_CONCAT(DISTINCT patients.DOB)DOB, GROUP_CONCAT(DISTINCT patients.allergies)allergies,
GROUP_CONCAT(DISTINCT patients.medicalHistory)medicalHistory, GROUP_CONCAT(DISTINCT patients.gender)gender, GROUP_CONCAT(DISTINCT gps.firstName, ' ', gps.lastName)GP, GROUP_CONCAT(DISTINCT gps.organisation)organisation, GROUP_CONCAT(DISTINCT gps.email)email, GROUP_CONCAT(DISTINCT gps.number)phonenumber, 
cases.temperature, cases.systole, cases.diastole, cases.bp, cases.fullBloodCount, cases.ptt, cases.UECr, cases.liverFunctionTest, GROUP_CONCAT(DISTINCT symptoms.system)system,
GROUP_CONCAT(distinct symptom SEPARATOR ', ')symptoms, GROUP_CONCAT(distinct signs.sign SEPARATOR ', ')signs,
cases.additionalInfo, GROUP_CONCAT(DISTINCT consultants.firstName, ' ',consultants.lastName)Consultant, cases.assigned, cases.appointmentTime,
(SUM(symptoms.symptomScore)*COUNT(DISTINCT symptoms.symptomId)/COUNT(*)+SUM(signs.signScore)*COUNT(DISTINCT signs.signId)/COUNT(*))Score
FROM cases
LEFT JOIN caseSymptom csyp
ON cases.caseId=csyp.caseId
LEFT JOIN symptoms 
ON csyp.symptomId=symptoms.symptomId
LEFT JOIN caseSign csig
ON cases.caseId=csig.caseId
LEFT JOIN signs 
ON csig.signId=signs.signId
LEFT JOIN casePatient pat
ON cases.caseId=pat.caseId
LEFT JOIN patients
ON pat.nric=patients.nric
LEFT JOIN caseGP cgp
ON cases.caseId=cgp.caseId
LEFT JOIN gps 
ON cgp.licenceIdGP=gps.licenceIdGP
LEFT JOIN caseConsultant cc
ON cases.caseId=cc.caseId
LEFT JOIN consultants 
ON cc.licenceIdConsultant=consultants.licenceIdConsultant
GROUP BY cases.caseId ORDER BY Score DESC, appointmentTime ASC;


-- saving case query into table

delimiter $$

CREATE PROCEDURE query_case()
BEGIN 
DROP TABLE IF EXISTS querycasetbl;
CREATE TEMPORARY TABLE querycasetbl 
SELECT cases.caseId, GROUP_CONCAT(DISTINCT patients.firstName, ' ', patients.lastName)patientName, cases.nric, GROUP_CONCAT(DISTINCT patients.DOB)DOB, GROUP_CONCAT(DISTINCT patients.allergies)allergies,
GROUP_CONCAT(DISTINCT patients.medicalHistory)medicalHistory, GROUP_CONCAT(DISTINCT patients.gender)gender, GROUP_CONCAT(DISTINCT gps.firstName, ' ', gps.lastName)GPName, GROUP_CONCAT(DISTINCT gps.organisation)GPClinic,cases.licenceIdGP, GROUP_CONCAT(DISTINCT gps.email)GPEmail, GROUP_CONCAT(DISTINCT gps.number)GPPhoneNumber, 
cases.temperature, cases.systole, cases.diastole, cases.bp, cases.fullBloodCount, cases.ptt, cases.UECr, cases.liverFunctionTest, GROUP_CONCAT(DISTINCT symptoms.system)system,
GROUP_CONCAT(distinct symptom SEPARATOR ', ')symptoms, GROUP_CONCAT(distinct signs.sign SEPARATOR ', ')signs,
cases.additionalInfo, GROUP_CONCAT(DISTINCT consultants.firstName, ' ',consultants.lastName)consultantName, cases.licenceIdConsultant, GROUP_CONCAT(DISTINCT consultants.email)consultantEmail,GROUP_CONCAT(DISTINCT consultants.number)consultantPhoneNumber, cases.assigned, cases.appointmentTime,
(SUM(symptoms.symptomScore)*COUNT(DISTINCT symptoms.symptomId)/COUNT(*)+SUM(signs.signScore)*COUNT(DISTINCT signs.signId)/COUNT(*))totalSeverityScore
FROM cases
LEFT JOIN caseSymptom csyp
ON cases.caseId=csyp.caseId
LEFT JOIN symptoms 
ON csyp.symptomId=symptoms.symptomId
LEFT JOIN caseSign csig
ON cases.caseId=csig.caseId
LEFT JOIN signs 
ON csig.signId=signs.signId
LEFT JOIN casePatient pat
ON cases.caseId=pat.caseId
LEFT JOIN patients
ON pat.nric=patients.nric
LEFT JOIN caseGP cgp
ON cases.caseId=cgp.caseId
LEFT JOIN gps 
ON cgp.licenceIdGP=gps.licenceIdGP
LEFT JOIN caseConsultant cc
ON cases.caseId=cc.caseId
LEFT JOIN consultants 
ON cc.licenceIdConsultant=consultants.licenceIdConsultant
GROUP BY cases.caseId ORDER BY totalSeverityScore DESC, appointmentTime ASC;

END $$

delimiter ;

-- Query for referral history for patients

call query_case();
select * from querycasetbl WHERE nric='S9811714J';


-- Query for referral history for consultants
call query_case();
select * from querycasetbl WHERE licenceIdConsultant='123456789' AND consultantEmail;


-- Query for referral history for gps

call query_case();
select * from querycasetbl WHERE licenceIdGP='0897564312'AND gpEmail = 'alantan@nuhs.sg';



DROP TABLE IF EXISTS querycasetbl;
DROP procedure query_case;
DROP table querycasetbl;



--   ---------INSERTING RECORDS --------

-- INSERT NEW PATIENT RECORD

INSERT INTO patients VALUES ('S9811714J', 'John', 'Tan','1998-05-05 13:09:11','Penicillin','patient had been hospitalise for asthma attack','M',  'local');

-- INSERT NEW GP RECORD

INSERT INTO gps VALUES ('0987654321', 'Matt', 'Tan','NUH','matttan@nuh.sg','matttan',  '90909090');


-- INSERT NEW CONSULTANT RECORD

INSERT INTO consultants VALUES ('123456789', 'Matt', 'Tan','NUH','matttan@nuh.sg','matttan',  '90909090',TRUE);

-- ----------------INSERT NEW CASE --------------
INSERT INTO cases VALUES(NULL,'S9911821P','0897564312','2018-04-20','37.8', '110','70','90','Normal','Abnormal','Normal','Normal','Patient complains of chest pain',TRUE,'2018-04-28 10:30:59','123456789','2018-06-18 11:30:59');

INSERT INTO caseSymptom VALUES('10002','24'); -- Match the symptoms entries to the case
INSERT INTO caseSymptom VALUES('10002','25');
INSERT INTO caseSymptom VALUES('10002','26');
INSERT INTO caseSymptom VALUES('10002','27');

INSERT INTO caseSign VALUES('10002','12');   -- Match the signs entries to the case

INSERT INTO caseGP VALUES('10002','0897564312');   -- Match the GplicenceID with case
INSERT INTO caseConsultant VALUES('10002','123456789');  -- Match the assigned consultantID with case
INSERT INTO casePatient VALUES('10001','S9811714J');



