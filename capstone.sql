USE CapstoneDB;

CREATE TABLE user (
	createdAt INT,
    updatedAt INT,
    id INT,
	emailAddress VARCHAR(100),
    password VARCHAR(50),
    fullName VARCHAR(150),
    isSuperAdmin BOOLEAN,
    passwordResetToken VARCHAR(100),
    passwordResetTokenExpiresAt VARCHAR(100),
    stripeCustomerId VARCHAR (100),
    hasBillingCard BOOLEAN,
    billingCardBrand VARCHAR (100),
    billingCardLast4 VARCHAR (100),
    billingCardExpMonth VARCHAR (100),
    billingCardExpYear VARCHAR (100),
    emailProofToken VARCHAR(100),
    emailProofTokenExpiresAt VARCHAR(100),
    emailStatus VARCHAR(150),
    emailChangeCandidate VARCHAR(100),
    tosAcceptedByIp VARCHAR(100),
    lastSeenAt INT,
    PRIMARY KEY (id)
);
SELECT * FROM user;
INSERT INTO user VALUES (15028440, 15028440, '101010', 'nuhsadmin@nuhs.com',MD5('nuhs123'), 'Dr Dale Loh',
TRUE,'','','',FALSE,'','','','','','','confirmed','','',15028440);
DROP TABLE user;

CREATE TABLE patients (
	nric VARCHAR(15),
    firstName VARCHAR(100),
    lastName VARCHAR(100),
    DOB DATE,
    allergies VARCHAR(150),
    medicalHistory VARCHAR(150),
	gender CHAR(1) CHECK (gender="F" or gender="M"),
    isOverseas CHAR(5) CHECK (status="Yes" OR status="No"),
    PRIMARY KEY (nric)
);
SELECT * FROM patients WHERE patients.nric = 'S9811714J' AND patients.DOB = '1998-05-05 13:09:11';

INSERT INTO patients VALUES ('S9811714J', 'John', 'Tan','1998-05-05','Penicillin','patient had been hospitalise for asthma attack','M',  'No');
INSERT INTO patients VALUES ('S9911821P', 'James', 'Tan','1999-08-05','Penicillin',NULL,'M',  'No');
INSERT INTO patients VALUES ('S9512721E', 'Jacob', 'Tan','1995-09-05','Penicillin','patient had history of asthma','M',  'No');
INSERT INTO patients VALUES('Aaa', 'Test', 'User', '2018-07-23', 'Penicillin', 'patient is FAKE NEWS', 'M', 'No');
INSERT INTO patients VALUES('A', 'Test', 'User', '2018-07-24', 'Penicillin', 'patient is FAKE NEWS', 'M', 'No');
INSERT INTO patients VALUES('a', 'Test', 'User', '2018-07-24', 'Penicillin', 'patient is FAKE NEWS', 'M', 'No');
INSERT INTO patients VALUES('B', 'Test', 'User', '2015-07-18', 'Penicillin', 'patient is FAKE NEWS', 'M', 'No');

-- DELIMITER $$
-- CREATE DEFINER = 'root'@'localhost' PROCEDURE `sp_pat_get`(v_nric VARCHAR(15))
-- 
-- BEGIN
-- 
-- select * from patients where nric= v_nric;
-- 
-- -- select count(1) into @count from patients where nric=v_nric;
-- -- select *,@count as Count from patients where nric=v_nric;
-- -- 
-- END$$
-- DELIMITER ;

-- CALL sp_pat_get;
-- DROP PROCEDURE sp_pat_get;  

-- delimiter $$
-- 
-- CREATE PROCEDURE sp_pat_get (OUT nric VARCHAR(15),OUT firstName VARCHAR(100),
--     OUT lastName VARCHAR(100),
--     OUT DOB DATE,
--     OUT allergies VARCHAR(150),
--     OUT medicalHistory VARCHAR(150),
-- 	OUT gender CHAR(1),
--     OUT status CHAR(50) )
-- BEGIN SELECT * INTO nric FROM patients;
-- END $$
-- 
-- delimiter ;
-- 
-- delimiter $$
-- 
-- CREATE PROCEDURE sp_pat_get (OUT nric VARCHAR(15))
-- BEGIN SELECT * INTO nric FROM patients;
-- END $$
-- 
-- delimiter ;
-- 
-- call sp_pat_get(@a,@b,@c,@d,@e,@f,@g,@h);
-- 
-- select @a,@b,@c,@d,@e,@f,@g,@h;
-- 
DROP procedure sp_pat_get;

delimiter $$

CREATE PROCEDURE sp_pat_get ()
BEGIN 
CREATE TEMPORARY TABLE patientstbl SELECT * FROM patients;
END $$

delimiter ;

call sp_pat_get();
select * from patientstbl;

-- CREATE TABLE patientMedical(
-- 	nric VARCHAR(15),
--     temperature decimal(3,1),
--     systole int,
--     diastole int,
--     bp int,
--     fbz CHAR(50) CHECK (fbz ="Normal" OR fbz ="Abnormal" OR fbz ="NA"),
-- 	ptt CHAR(50) CHECK (ptt ="Normal" OR ptt ="Abnormal" OR ptt ="NA"),
--     uCER CHAR(50) CHECK (uCER ="Normal" OR uCER ="Abnormal" OR uCER ="NA"),
--     lft CHAR(50) CHECK (lft ="Normal" OR lft ="Abnormal" OR lft ="NA"),
--     FOREIGN KEY (nric) REFERENCES patients(nric)
-- );
-- INSERT INTO patientMedical VALUES ('S9811714J', '36.8', '100','50','100','Normal','Normal','Normal','Normal');
-- INSERT INTO patientMedical VALUES ('S9911821P', '37.8', '110','70','90','Normal','Abnormal','Normal','Normal');


-- SELECT * FROM patientMedical;

CREATE TABLE gps (
	licenceIdGP VARCHAR(25),
    firstName VARCHAR(100),
    lastName VARCHAR(100),
    organisation VARCHAR(50),
	email VARCHAR(30),
	password VARCHAR(30),
    number INT,
	PRIMARY KEY(licenceIdGP)
);

INSERT INTO gps VALUES ('0987654321', 'Matt', 'Tan','NUH','matttan@nuh.sg','matttan',  '90909090');
INSERT INTO gps VALUES ('0897564312', 'Alan', 'Tan','NUH','alantan@nuh.sg','alantan',  '90909091');
INSERT INTO gps values('123', 'Test', 'GP', 'NUH', 'test', 'testGP', '1234567');
INSERT INTO gps VALUES ('0897564382', 'Ala', 'Tan','NUH','123','123',  '90909091');


SELECT * FROM gps;
SELECT * FROM gps WHERE email = 'alantan@nuh.sg' AND password = 'alantan';


CREATE TABLE consultants (
	licenceIdConsultant VARCHAR(25),
    firstName VARCHAR(100),
    lastName VARCHAR(100),
    organisation VARCHAR(50),
	email VARCHAR(30),
	password VARCHAR(30),
    number INT,
    scheduler BOOLEAN,
	PRIMARY KEY(licenceIdConsultant)
);

INSERT INTO consultants VALUES ('123456789', 'Kevin', 'Tan','NUH','kevintan@nuh.sg','kevintan',  '90900088',TRUE);
INSERT INTO consultants VALUES ('987654321', 'Test', 'Consultant', 'NUH', 'test@cons', 'testCons', '9876543', TRUE);

INSERT INTO consultants VALUES ('123456780', 'Kevin', 'Lee','NUH','123','123',  '90900088',TRUE);


SELECT * FROM consultants;
SELECT * FROM consultants WHERE consultants.email = 'matttan@nuh.sg' AND consultants.password = 'matttan';



CREATE TABLE register (
	licenceId VARCHAR(25),
    firstName VARCHAR(100),
    lastName VARCHAR(100),
    organisation VARCHAR(50),
	email VARCHAR(30),
	password VARCHAR(30),
    number INT,
    confirmation CHAR(1) CHECK (gender="Y" or gender="N"),
	PRIMARY KEY(licenceId)
);

INSERT INTO register VALUES('0987654321', 'Matt', 'Tan','NUH','matttan@nuh.sg','matttan',  '90909090','Y');

SELECT * FROM register;


CREATE TABLE symptoms(
	symptomId INT AUTO_INCREMENT,
    symptom VARCHAR(100),
    system VARCHAR(50),
    symptomScore INT,
    PRIMARY KEY(symptomId)
);



INSERT INTO symptoms VALUES ('1','Site------Epigastrium','Gastrointestinal','1');
INSERT INTO symptoms VALUES (NULL,'Site------RightIliacFossa','Gastrointestinal','1');
INSERT INTO symptoms VALUES (NULL,'Site------LeftIliacFossa','Gastrointestinal','1');
INSERT INTO symptoms VALUES (NULL,'Site------RightHypochondrium','Gastrointestinal','1');
INSERT INTO symptoms VALUES (NULL,'Site------LeftHypochondrium','Gastrointestinal','1');
INSERT INTO symptoms VALUES (NULL,'Onset------Sudden','Gastrointestinal','2');
INSERT INTO symptoms VALUES (NULL,'Onset------Gradual','Gastrointestinal','1');
INSERT INTO symptoms VALUES (NULL,'Character------Sharp','Gastrointestinal','2');
INSERT INTO symptoms VALUES (NULL,'Character------Colicky','Gastrointestinal','1');
INSERT INTO symptoms VALUES (NULL,'Radiation------Back','Gastrointestinal','1');
INSERT INTO symptoms VALUES (NULL,'Radiation------DownToGroin','Gastrointestinal','1');
INSERT INTO symptoms VALUES (NULL,'Radiation------UmbilicalToRightIliacFossa','Gastrointestinal','2');
INSERT INTO symptoms VALUES (NULL,'AlleviatingFactors------CurlingUp','Gastrointestinal','2');
INSERT INTO symptoms VALUES (NULL,'AlleviatingFactors------StayingStill','Gastrointestinal','1');
INSERT INTO symptoms VALUES (NULL,'Timing------Constant','Gastrointestinal','1');
INSERT INTO symptoms VALUES (NULL,'Timing------WorseWithFood','Gastrointestinal','2');
INSERT INTO symptoms VALUES (NULL,'Timing------WorseAfterFood','Gastrointestinal','1');
INSERT INTO symptoms VALUES (NULL,'Timing------BetterAfterVomiting','Gastrointestinal','2');
INSERT INTO symptoms VALUES (NULL,'ExcerbatingFactors------Moving','Gastrointestinal','2');
INSERT INTO symptoms VALUES (NULL,'Anorexia','Gastrointestinal','1');
INSERT INTO symptoms VALUES (NULL,'Dirrhea------Bloody','Gastrointestinal','1');
INSERT INTO symptoms VALUES (NULL,'Dirrhea------Watery','Gastrointestinal','1');
INSERT INTO symptoms VALUES (NULL,'Vomiting','Gastrointestinal','2');
INSERT INTO symptoms VALUES (NULL,'Projectile------>3Times','Gastrointestinal','2');
INSERT INTO symptoms VALUES (NULL,'Projectile------>1Time','Gastrointestinal','1');
INSERT INTO symptoms VALUES (NULL,'Projectile------Yellow','Gastrointestinal','2');
INSERT INTO symptoms VALUES (NULL,'Wheezing','Respiratory','2');
INSERT INTO symptoms VALUES (NULL,'Stridor','Respiratory','2');
INSERT INTO symptoms VALUES (NULL,'Barking Cough','Respiratory','3');
INSERT INTO symptoms VALUES (NULL,'Phelgm','Respiratory','1');
INSERT INTO symptoms VALUES (NULL,'Drooling','Respiratory','3');
INSERT INTO symptoms VALUES (NULL,'DifficultyBreathing------AbleToSpeakInFullSentences','Respiratory','3');
INSERT INTO symptoms VALUES (NULL,'DifficultyBreathing------Gasping','Respiratory','3');
INSERT INTO symptoms VALUES (NULL,'DifficultyBreathing------TripodPosition','Respiratory','3');
INSERT INTO symptoms VALUES (NULL,'Fever','Respiratory','1');
INSERT INTO symptoms VALUES (NULL,'Difficulty Breathing','Circulatory','3');
INSERT INTO symptoms VALUES (NULL,'Palpitations','Circulatory','2');
INSERT INTO symptoms VALUES (NULL,'Dizziness','Circulatory','3');
INSERT INTO symptoms VALUES (NULL,'Lethargy','Circulatory','2');
INSERT INTO symptoms VALUES (NULL,'JointPain------UpperLimb','Musculoskeletal','1');
INSERT INTO symptoms VALUES (NULL,'JointPain------LowerLimb','Musculoskeletal','1');
INSERT INTO symptoms VALUES (NULL,'JointPain------WorseAfterActivity','Musculoskeletal','1');
INSERT INTO symptoms VALUES (NULL,'JointPain------PainAtRest','Musculoskeletal','3');
INSERT INTO symptoms VALUES (NULL,'Trauma','Musculoskeletal','3');
INSERT INTO symptoms VALUES (NULL,'Rash------>12Hrs','Musculoskeletal','2');
INSERT INTO symptoms VALUES (NULL,'Rash------>3Gays','Musculoskeletal','1');
INSERT INTO symptoms VALUES (NULL,'Rash------Sudden','Musculoskeletal','3');
INSERT INTO symptoms VALUES (NULL,'Rash------Bites','Musculoskeletal','2');
INSERT INTO symptoms VALUES (NULL,'Rash------ExposeToNatural','Musculoskeletal','2');
INSERT INTO symptoms VALUES (NULL,'Rash------OverseasTravel','Musculoskeletal','2');
INSERT INTO symptoms VALUES (NULL,'Rash------Itchy','Musculoskeletal','1');
INSERT INTO symptoms VALUES (NULL,'Rash------Discharge','Musculoskeletal','1');

INSERT INTO symptoms VALUES (NULL,'Hematuria','Urinary','2'); -- menses
INSERT INTO symptoms VALUES (NULL,'FrequencyOfUrine------<5','Urinary','2'); 
INSERT INTO symptoms VALUES (NULL,'FrequencyOfUrine------>5','Urinary','1'); 
INSERT INTO symptoms VALUES (NULL,'FrequencyOfUrine------>10','Urinary','2'); 
INSERT INTO symptoms VALUES (NULL,'Dysuria','Urinary','1');
INSERT INTO symptoms VALUES (NULL,'Fever','Urinary','1');
INSERT INTO symptoms VALUES (NULL,'UrineFlow------Normal','Urinary','1');
INSERT INTO symptoms VALUES (NULL,'UrineFlow------Abnormal','Urinary','2'); 
INSERT INTO symptoms VALUES (NULL,'TesticularPain','Urinary','3'); 

INSERT INTO symptoms VALUES (NULL,'Fits','Neurology','2');
INSERT INTO symptoms VALUES (NULL,'Fever','Neurology','1');
INSERT INTO symptoms VALUES (NULL,'Duration------<1min','Neurology','1');
INSERT INTO symptoms VALUES (NULL,'Duration------1-3mins','Neurology','2');
INSERT INTO symptoms VALUES (NULL,'Duration------>3mins','Neurology','3');
INSERT INTO symptoms VALUES (NULL,'SelfAborted','Neurology','2');
INSERT INTO symptoms VALUES (NULL,'TypeOfMovement------Atonic','Neurology','3');
INSERT INTO symptoms VALUES (NULL,'TypeOfMovement------Clonic','Neurology','2');
INSERT INTO symptoms VALUES (NULL,'TypeOfMovement------Tonic-Clonic','Neurology','3');
INSERT INTO symptoms VALUES (NULL,'EyeRolling','Neurology','2');
INSERT INTO symptoms VALUES (NULL,'Vomitting','Neurology','1');
INSERT INTO symptoms VALUES (NULL,'LossOfContinence','Neurology','1');


SELECT * FROM symptoms;




CREATE TABLE signs(
	signId INT AUTO_INCREMENT,
    sign VARCHAR(100),
    system VARCHAR(50),
    signScore INT,
    PRIMARY KEY(signId)
);

INSERT INTO signs VALUES ('1','Rousing','Gastrointestinal','2');
INSERT INTO signs VALUES (NULL,'McBurnerys','Gastrointestinal','2');
INSERT INTO signs VALUES (NULL,'BallotableKidneys','Gastrointestinal','1');
INSERT INTO signs VALUES (NULL,'0','Gastrointestinal','1');
INSERT INTO signs VALUES (NULL,'1','Gastrointestinal','1');
INSERT INTO signs VALUES (NULL,'2','Gastrointestinal','1');
INSERT INTO signs VALUES (NULL,'3','Gastrointestinal','1');
INSERT INTO signs VALUES (NULL,'4','Gastrointestinal','1');
INSERT INTO signs VALUES (NULL,'5','Gastrointestinal','1');
INSERT INTO signs VALUES (NULL,'6','Gastrointestinal','1');
INSERT INTO signs VALUES (NULL,'7','Gastrointestinal','1');
INSERT INTO signs VALUES (NULL,'8','Gastrointestinal','1');

INSERT INTO signs VALUES (NULL,'Wheeze','Respiratory','2');
INSERT INTO signs VALUES (NULL,'Creps','Respiratory','1');
INSERT INTO signs VALUES (NULL,'StonyDullness','Respiratory','3');
INSERT INTO signs VALUES (NULL,'0','Respiratory','1');
INSERT INTO signs VALUES (NULL,'1','Respiratory','1');
INSERT INTO signs VALUES (NULL,'2','Respiratory','1');
INSERT INTO signs VALUES (NULL,'3','Respiratory','1');

INSERT INTO signs VALUES (NULL,'HeartSounds','Circulatory','1');
INSERT INTO signs VALUES (NULL,'Rash','Musculoskeletal','0');


INSERT INTO signs VALUES (NULL,'Hypospadia','Urinary','3');
INSERT INTO signs VALUES (NULL,'UndescendedTestes','Urinary','3');
INSERT INTO signs VALUES (NULL,'Clitoromegaly','Urinary','2');
INSERT INTO signs VALUES (NULL,'Trauma','Urinary','3');
INSERT INTO signs VALUES (NULL,'UF1','Urinary','1');
INSERT INTO signs VALUES (NULL,'UF2','Urinary','1');
INSERT INTO signs VALUES (NULL,'UF3','Urinary','1');
INSERT INTO signs VALUES (NULL,'UF4','Urinary','1');
INSERT INTO signs VALUES (NULL,'UM1','Urinary','1');
INSERT INTO signs VALUES (NULL,'UM2','Urinary','1');
INSERT INTO signs VALUES (NULL,'UM3','Urinary','1');
INSERT INTO signs VALUES (NULL,'UM4','Urinary','1');

INSERT INTO signs VALUES (NULL,'Tone------Abnormal','Neurology','3');
INSERT INTO signs VALUES (NULL,'Power-----Abnormal','Neurology','3');
INSERT INTO signs VALUES (NULL,'Reflex------Abnormal','Neurology','1');
INSERT INTO signs VALUES (NULL,'Tone------Normal','Neurology','0');
INSERT INTO signs VALUES (NULL,'Power-----Normal','Neurology','0');
INSERT INTO signs VALUES (NULL,'Reflex------Normal','Neurology','0');
INSERT INTO signs VALUES (NULL,'0','Neurology','1');
INSERT INTO signs VALUES (NULL,'1','Neurology','1');
INSERT INTO signs VALUES (NULL,'2','Neurology','1');
INSERT INTO signs VALUES (NULL,'3','Neurology','1');
INSERT INTO signs VALUES (NULL,'4','Neurology','1');
INSERT INTO signs VALUES (NULL,'5','Neurology','1');
INSERT INTO signs VALUES (NULL,'6','Neurology','1');

-- PICTURES (DOUBLE CONFIRM THE SCORE)









SELECT signId FROM signs WHERE sign = 'Rash';

SELECT * FROM signs;

-- CREATE TABLE patientSymptomSign(
--     nric VARCHAR(15),
--     symptomId INT,
-- 	signId INT,
-- 	FOREIGN KEY(nric) REFERENCES patients(nric),
-- 	FOREIGN KEY(symptomId) REFERENCES symptoms(symptomId),
--     FOREIGN KEY(signId) REFERENCES signs(signId)
-- 
-- );
-- DROP TABLE patientSymptomSign;
-- INSERT INTO patientSymptomSign VALUES('S9811714J','2','3');
-- INSERT INTO patientSymptomSign VALUES('S9811714J','4','4');
-- SELECT * FROM patientSymptomSign;
-- 
-- -- Query for patient symptom sign
-- SELECT patients.nric,patients.firstName, GROUP_CONCAT(symptoms.symptom SEPARATOR ',')symptoms, 
-- GROUP_CONCAT(signs.sign SEPARATOR ',')signs
-- FROM patients
-- LEFT JOIN patientSymptomSign pss
-- ON patients.nric=pss.nric
-- LEFT JOIN symptoms 
-- ON pss.symptomId=symptoms.symptomId
-- LEFT JOIN signs 
-- ON pss.signId=signs.signId
-- GROUP BY patients.nric,patients.firstName;



-- CREATE TABLE cases(
-- 	caseId INT AUTO_INCREMENT,
--     nric VARCHAR(15),
--     licenceId VARCHAR(25),
-- 	createdAt TIMESTAMP DEFAULT NOW(),
--     symptomId INT,
--     signId INT,
--     additionalInfo VARCHAR(200),
-- 	FOREIGN KEY(nric) REFERENCES patients(nric),
-- 	FOREIGN KEY(licenceId) REFERENCES doctors(licenceId),
--     FOREIGN KEY(symptomId) REFERENCES symptoms(symptomId),
--     FOREIGN KEY(signId) REFERENCES signs(signId),
-- 	PRIMARY KEY (caseId)
-- );

SELECT * FROM cases;

-- CREATE TABLE cases(
-- 	caseId INT AUTO_INCREMENT,
--     nric VARCHAR(15),
--     licenceId VARCHAR(25),
-- 	createdAt TIMESTAMP DEFAULT NOW(),
--     additionalInfo VARCHAR(200),
-- 	FOREIGN KEY(nric) REFERENCES patients(nric),
-- 	FOREIGN KEY(licenceId) REFERENCES doctors(licenceId),
-- 	PRIMARY KEY (caseId)
-- );
-- INSERT INTO cases VALUES('10001','S9811714J','123456789','2018-04-18','Patient is in pain');
-- INSERT INTO cases VALUES(NULL,'S9911821P','123456789','2018-04-20','Patient complains of chest pain');


CREATE TABLE cases(
	caseId INT AUTO_INCREMENT,
    nric VARCHAR(15),
    licenceIdGP VARCHAR(25),
    createdAt TIMESTAMP DEFAULT NOW(),
    temperature decimal(3,1),
    systole int,
    diastole int,
    bp int,
    fullBloodCount CHAR(50) CHECK (fbz ="Normal" OR fbz ="Abnormal" OR fbz ="NA"),
	ptt CHAR(50) CHECK (ptt ="Normal" OR ptt ="Abnormal" OR ptt ="NA"),
    UECr CHAR(50) CHECK (uCER ="Normal" OR uCER ="Abnormal" OR uCER ="NA"),
    liverFunctionTest CHAR(50) CHECK (lft ="Normal" OR lft ="Abnormal" OR lft ="NA"),
    additionalInfo VARCHAR(200),
	assigned BOOLEAN,
	assignedTime DATETIME,
    licenceIdConsultant VARCHAR(25),
    appointmentTime DATETIME,
    FOREIGN KEY(nric) REFERENCES patients(nric),
	FOREIGN KEY(licenceIdGP) REFERENCES gps(licenceIdGP),
    FOREIGN KEY(licenceIdConsultant) REFERENCES consultants(licenceIdConsultant),
	PRIMARY KEY (caseId)
);

INSERT INTO cases VALUES('10001','S9811714J','0987654321','2018-04-18','36.8', '100','50','100','Normal','Normal','Normal','Normal','Patient is in pain',TRUE,'2018-04-28 10:30:59','123456789','2018-06-18 10:30:59');
INSERT INTO cases VALUES(NULL,'S9911821P','0897564312','2018-04-20','37.8', '110','70','90','Normal','Abnormal','Normal','Normal','Patient complains of chest pain',TRUE,'2018-04-28 10:30:59','123456789','2018-06-18 11:30:59');
INSERT INTO cases VALUES(NULL,'S9512721E','0897564312','2018-05-20','38.8', '110','70','90','Normal','Abnormal','Normal','Normal','Patient had been experiencing condition since he returned from camp',TRUE,'2018-04-18 10:30:59','123456789','2018-05-19 11:30:59');


SELECT * FROM cases;


CREATE TABLE caseSymptom(
	caseId INT,
    symptomId INT,
	FOREIGN KEY(caseId) REFERENCES cases(caseId),
	FOREIGN KEY(symptomId) REFERENCES symptoms(symptomId)
);

INSERT INTO caseSymptom VALUES('10001','2');
INSERT INTO caseSymptom VALUES('10001','3');
INSERT INTO caseSymptom VALUES('10001','4');
INSERT INTO caseSymptom VALUES('10001','5');

INSERT INTO caseSymptom VALUES('10002','24');
INSERT INTO caseSymptom VALUES('10002','25');
INSERT INTO caseSymptom VALUES('10002','26');
INSERT INTO caseSymptom VALUES('10002','27');

INSERT INTO caseSymptom VALUES('10003','38');
INSERT INTO caseSymptom VALUES('10003','41');
INSERT INTO caseSymptom VALUES('10003','43');
INSERT INTO caseSymptom VALUES('10003','46');
INSERT INTO caseSymptom VALUES('10003','47');



SELECT * FROM caseSymptom;


CREATE TABLE caseSign(
	caseId INT,
    signId INT,
	FOREIGN KEY(caseId) REFERENCES cases(caseId),
	FOREIGN KEY(signId) REFERENCES signs(signId)
);
INSERT INTO caseSign VALUES('10001','2');
INSERT INTO caseSign VALUES('10001','3');
INSERT INTO caseSign VALUES('10002','12');
INSERT INTO caseSign VALUES('10003','13');
INSERT INTO caseSign VALUES('10003','14');


SELECT * FROM caseSign;


CREATE TABLE casePatient(
	caseId INT,
    nric VARCHAR(15),
	FOREIGN KEY(caseId) REFERENCES cases(caseId),
	FOREIGN KEY(nric) REFERENCES patients(nric)
);
SELECT * FROM casePatient;

INSERT INTO casePatient VALUES('10001','S9811714J');
INSERT INTO casePatient VALUES('10002','S9911821P');
INSERT INTO casePatient VALUES('10003','S9512721E');




CREATE TABLE caseGP(
	caseId INT,
    licenceIdGP VARCHAR(25),
	FOREIGN KEY(caseId) REFERENCES cases(caseId),
	FOREIGN KEY(licenceIdGP) REFERENCES gps(licenceIdGP)
);
INSERT INTO caseGP VALUES('10001','0987654321');
INSERT INTO caseGP VALUES('10001','0987654321');
INSERT INTO caseGP VALUES('10002','0897564312');
INSERT INTO caseGP VALUES('10003','0897564312');

SELECT * FROM caseGP;

CREATE TABLE caseConsultant(
	caseId INT,
    licenceIdConsultant VARCHAR(25),
	FOREIGN KEY(caseId) REFERENCES cases(caseId),
	FOREIGN KEY(licenceIdConsultant) REFERENCES consultants(licenceIdConsultant)
);
INSERT INTO caseConsultant VALUES('10001','123456789');
INSERT INTO caseConsultant VALUES('10001','123456789');
INSERT INTO caseConsultant VALUES('10002','123456789');
INSERT INTO caseConsultant VALUES('10003','123456789');

SELECT * FROM caseConsultant;




-- Query for each case

SELECT cases.caseId, cases.nric, cases.temperature, cases.systole, cases.diastole, cases.bp, cases.fullBloodCount, cases.ptt, cases.UECr, cases.liverFunctionTest, 
GROUP_CONCAT(distinct symptom SEPARATOR ', ')symptoms, GROUP_CONCAT(distinct signs.sign SEPARATOR ', ')signs,
cases.additionalInfo, cases.licenceIdGP,cases.licenceIdConsultant, cases.assigned, cases.appointmentTime,
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
GROUP BY cases.caseId ORDER BY Score DESC;

-- Query by patients
-- Error Code: 1055. Expression #2 of SELECT list is not in GROUP BY clause and contains nonaggregated column 
-- 'capstonedb.consultants.firstName' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by

-- 

SELECT cases.caseId, GROUP_CONCAT(DISTINCT gps.firstName, ' ', gps.lastName)GP, GROUP_CONCAT(DISTINCT gps.organisation)organisation, GROUP_CONCAT(DISTINCT gps.email)email, GROUP_CONCAT(DISTINCT gps.number)phonenumber, 
cases.nric, cases.temperature, cases.systole, cases.diastole, cases.bp, cases.fullBloodCount, cases.ptt, cases.UECr, cases.liverFunctionTest, 
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
LEFT JOIN caseGP cgp
ON cases.caseId=cgp.caseId
LEFT JOIN gps 
ON cgp.licenceIdGP=gps.licenceIdGP
LEFT JOIN caseConsultant cc
ON cases.caseId=cc.caseId
LEFT JOIN consultants 
ON cc.licenceIdConsultant=consultants.licenceIdConsultant
WHERE nric='S9811714J'
GROUP BY cases.caseId;

-- Query by consultant
SELECT cases.caseId, cases.nric, cases.temperature, cases.systole, cases.diastole, cases.bp, cases.fullBloodCount, cases.ptt, cases.UECr, cases.liverFunctionTest, 
GROUP_CONCAT(distinct symptom SEPARATOR ', ')symptoms, GROUP_CONCAT(distinct signs.sign SEPARATOR ', ')signs,
cases.additionalInfo, cases.licenceIdGP,cases.licenceIdConsultant, cases.assigned, cases.appointmentTime,(SUM(symptoms.symptomScore)*COUNT(DISTINCT symptoms.symptomId)/COUNT(*)+SUM(signs.signScore)*COUNT(DISTINCT signs.signId)/COUNT(*))Score
FROM cases
LEFT JOIN caseSymptom csyp
ON cases.caseId=csyp.caseId
LEFT JOIN symptoms 
ON csyp.symptomId=symptoms.symptomId
LEFT JOIN caseSign csig
ON cases.caseId=csig.caseId
LEFT JOIN signs 
ON csig.signId=signs.signId
LEFT JOIN caseGP cgp
ON cases.caseId=cgp.caseId
LEFT JOIN gps 
ON cgp.licenceIdGP=gps.licenceIdGP
LEFT JOIN caseConsultant cc
ON cases.caseId=cc.caseId
LEFT JOIN consultants 
ON cc.licenceIdConsultant=consultants.licenceIdConsultant
WHERE cc.licenceIdConsultant='123456789'
GROUP BY cases.caseId;
-- 



delimiter $$

CREATE PROCEDURE query_cases()
BEGIN 
CREATE TEMPORARY TABLE querycasestbl 
SELECT cases.caseId, cases.nric, cases.temperature, cases.systole, cases.diastole, cases.bp, cases.fullBloodCount, cases.ptt, cases.UECr, cases.liverFunctionTest, 
GROUP_CONCAT(distinct symptom SEPARATOR ', ')symptoms, GROUP_CONCAT(distinct signs.sign SEPARATOR ', ')signs,
cases.additionalInfo, cases.licenceIdGP,cases.licenceIdConsultant, cases.assigned, cases.appointmentTime,(SUM(symptoms.symptomScore)*COUNT(DISTINCT symptoms.symptomId)/COUNT(*)+SUM(signs.signScore)*COUNT(DISTINCT signs.signId)/COUNT(*))Score
FROM cases
LEFT JOIN caseSymptom csyp
ON cases.caseId=csyp.caseId
LEFT JOIN symptoms 
ON csyp.symptomId=symptoms.symptomId
LEFT JOIN caseSign csig
ON cases.caseId=csig.caseId
LEFT JOIN signs 
ON csig.signId=signs.signId
LEFT JOIN caseGP cgp
ON cases.caseId=cgp.caseId
LEFT JOIN gps 
ON cgp.licenceIdGP=gps.licenceIdGP
LEFT JOIN caseConsultant cc
ON cases.caseId=cc.caseId
LEFT JOIN consultants 
ON cc.licenceIdConsultant=consultants.licenceIdConsultant
GROUP BY cases.caseId ORDER BY Score DESC;
END $$

delimiter ;

call query_cases();
select * from querycasestbl;







delimiter $$

CREATE PROCEDURE query_consultant()
BEGIN 
CREATE TEMPORARY TABLE queryconsultanttbl 
SELECT cases.caseId, cases.nric, cases.temperature, cases.systole, cases.diastole, cases.bp, ccases.fullBloodCount, cases.ptt, cases.UECr, cases.liverFunctionTest, 
GROUP_CONCAT(distinct symptom SEPARATOR ', ')symptoms, GROUP_CONCAT(distinct signs.sign SEPARATOR ', ')signs,
cases.additionalInfo, cases.licenceIdGP,cases.licenceIdConsultant, cases.assigned, cases.appointmentTime,(SUM(symptoms.symptomScore)*COUNT(DISTINCT symptoms.symptomId)/COUNT(*)+SUM(signs.signScore)*COUNT(DISTINCT signs.signId)/COUNT(*))Score
FROM cases
LEFT JOIN caseSymptom csyp
ON cases.caseId=csyp.caseId
LEFT JOIN symptoms 
ON csyp.symptomId=symptoms.symptomId
LEFT JOIN caseSign csig
ON cases.caseId=csig.caseId
LEFT JOIN signs 
ON csig.signId=signs.signId
LEFT JOIN caseGP cgp
ON cases.caseId=cgp.caseId
LEFT JOIN gps 
ON cgp.licenceIdGP=gps.licenceIdGP
LEFT JOIN caseConsultant cc
ON cases.caseId=cc.caseId
LEFT JOIN consultants 
ON cc.licenceIdConsultant=consultants.licenceIdConsultant
WHERE cc.licenceIdConsultant='123456789'
GROUP BY cases.caseId;
END $$

delimiter ;

call query_consultant();
select * from queryconsultanttbl;


DROP procedure query_consultant;
DROP table queryconsultanttbl;

-- -- Query for specific patient
-- SELECT cases.caseId, cases.nric,cases.licenceId, 
-- GROUP_CONCAT(distinct symptom SEPARATOR ',')symptoms, GROUP_CONCAT(distinct signs.sign SEPARATOR ',')signs,
-- cases.additionalInfo
-- FROM cases 
-- LEFT JOIN caseSymptom csyp
-- ON cases.caseId=csyp.caseId
-- LEFT JOIN symptoms 
-- ON csyp.symptomId=symptoms.symptomId
-- LEFT JOIN caseSign csig
-- ON cases.caseId=csig.caseId
-- LEFT JOIN signs 
-- ON csig.signId=signs.signId
-- WHERE nric='S9811714J'
-- GROUP BY cases.caseId;
-- 
-- -- Query for specific consultant
-- SELECT cases.caseId, cases.nric,cases.licenceId, SUM(symptoms.symptomScore)*COUNT(DISTINCT symptoms.symptomId)/COUNT(*)+SUM(signs.signScore)*COUNT(DISTINCT signs.signId)/COUNT(*),
-- GROUP_CONCAT(distinct symptom SEPARATOR ','), GROUP_CONCAT(distinct signs.sign SEPARATOR ', '), 
-- cases.additionalInfo
-- FROM cases 
-- LEFT JOIN caseSymptom csyp
-- ON cases.caseId=csyp.caseId
-- LEFT JOIN symptoms 
-- ON csyp.symptomId=symptoms.symptomId
-- LEFT JOIN caseSign csig
-- ON cases.caseId=csig.caseId
-- LEFT JOIN signs 
-- ON csig.signId=signs.signId
-- WHERE licenceIdConsultant='123456789'
-- GROUP BY cases.caseId;
-- 
-- -- Query for specific consultant
-- SELECT cases.caseId, cases.nric,cases.licenceId, SUM(symptoms.symptomScore)*COUNT(DISTINCT symptoms.symptomId)/COUNT(*)+SUM(signs.signScore)*COUNT(DISTINCT signs.signId)/COUNT(*),
-- GROUP_CONCAT(distinct symptom SEPARATOR ','), GROUP_CONCAT(distinct signs.sign SEPARATOR ', '), 
-- cases.additionalInfo
-- FROM cases 
-- LEFT JOIN caseSymptom csyp
-- ON cases.caseId=csyp.caseId
-- LEFT JOIN symptoms 
-- ON csyp.symptomId=symptoms.symptomId
-- LEFT JOIN caseSign csig
-- ON cases.caseId=csig.caseId
-- LEFT JOIN signs 
-- ON csig.signId=signs.signId
-- WHERE licenceIdConsultant='123456789'
-- GROUP BY cases.caseId;





DROP TABLE patients;
-- DROP TABLE patientMedical;
DROP TABLE gps;
DROP TABLE consultants;
DROP TABLE cases;
DROP TABLE caseSymptom;
DROP TABLE caseSign;
DROP TABLE casePatient;
DROP TABLE caseGP;
DROP TABLE caseConsultant;
DROP TABLE symptoms;
DROP TABLE signs;


