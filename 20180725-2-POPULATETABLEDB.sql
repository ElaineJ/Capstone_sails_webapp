-- SELECT * FROM patients WHERE patients.nric = 'S9811714J' AND patients.DOB = '1998-05-05 13:09:11';
-- 
SELECT * FROM patients;
INSERT INTO patients VALUES ('S9811714J', 'John', 'Tan','1998-05-05','Penicillin','patient had been hospitalise for asthma attack','M',  'No');
INSERT INTO patients VALUES ('S9911821P', 'James', 'Tan','1999-08-05','Penicillin',NULL,'M',  'No');
INSERT INTO patients VALUES ('S9512721E', 'Jacob', 'Tan','1995-09-05','Penicillin','patient had history of asthma','M',  'No');
INSERT INTO patients VALUES('Aaa', 'Test', 'User', '2018-07-23', 'Penicillin', 'patient is FAKE NEWS', 'M', 'No');
INSERT INTO patients VALUES('A', 'Test', 'User', '2018-07-24', 'Penicillin', 'patient is FAKE NEWS', 'M', 'No');

INSERT INTO gps VALUES ('0987654321', 'Matt', 'Tan','NUH','matttan@nuh.sg','matttan',  '90909090','No');
INSERT INTO gps VALUES ('0897564312', 'Alan', 'Tan','NUH','alantan@nuh.sg','alantan',  '90909091','No');
INSERT INTO gps values('123', 'Test', 'GP', 'NUH', 'test', 'testGP', '1234567','No');
INSERT INTO gps VALUES ('0897564382', 'Ala', 'Tan','NUH','123','123',  '90909091','No');


-- SELECT * FROM gps;
-- SELECT * FROM gps WHERE email = 'alantan@nuh.sg' AND password = 'alantan';

INSERT INTO consultants VALUES ('123456789', 'Kevin', 'Tan','NUH','kevintan@nuh.sg','kevintan',  '90900088',TRUE);
INSERT INTO consultants VALUES ('987654321', 'Test', 'Consultant', 'NUH', 'test@cons', 'testCons', '9876543', TRUE);

INSERT INTO consultants VALUES ('123456780', 'Kevin', 'Lee','NUH','123','123',  '90900088',TRUE);


-- SELECT * FROM consultants;
-- SELECT * FROM consultants WHERE consultants.email = 'matttan@nuh.sg' AND consultants.password = 'matttan';

INSERT INTO register VALUES('0987654321', 'Matt', 'Tan','NUH','matttan@nuh.sg','matttan',  '90909090','Y');

-- SELECT * FROM register;
-- 


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
INSERT INTO symptoms VALUES (NULL,'BarkingCough','Respiratory','3');
INSERT INTO symptoms VALUES (NULL,'Phelgm','Respiratory','1');
INSERT INTO symptoms VALUES (NULL,'Drooling','Respiratory','3');
INSERT INTO symptoms VALUES (NULL,'DifficultyBreathing------AbleToSpeakInFullSentences','Respiratory','3');
INSERT INTO symptoms VALUES (NULL,'DifficultyBreathing------Gasping','Respiratory','3');
INSERT INTO symptoms VALUES (NULL,'DifficultyBreathing------TripodPosition','Respiratory','3');
INSERT INTO symptoms VALUES (NULL,'Fever','Respiratory','1');
INSERT INTO symptoms VALUES (NULL,'DifficultyBreathing','Circulatory','3');
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



-- SELECT * FROM symptoms;
-- 


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

INSERT INTO notifications VALUES ('101','123456780','5 days','2018-04-18');


INSERT INTO cases VALUES('10001','S9811714J','0987654321','2018-04-18','36.8', '100','50','100','Normal','Normal','Normal','Normal','','','Patient is in pain',TRUE,'2018-04-28 10:30:59','123456789','2018-06-18 10:30:59');
INSERT INTO cases VALUES(NULL,'S9911821P','0897564312','2018-04-20','37.8', '110','70','90','Normal','Abnormal','Normal','Normal','','','Patient complains of chest pain',TRUE,'2018-04-28 10:30:59','123456789','2018-06-18 11:30:59');
INSERT INTO cases VALUES(NULL,'S9512721E','0897564312','2018-05-20','38.8', '110','70','90','Normal','Abnormal','Normal','Normal','','','Patient had been experiencing condition since he returned from camp',TRUE,'2018-04-18 10:30:59','123456789','2018-05-19 11:30:59');


-- SELECT * FROM cases;


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



-- SELECT * FROM caseSymptom;
-- 

INSERT INTO caseSign VALUES('10001','2');
INSERT INTO caseSign VALUES('10001','3');
INSERT INTO caseSign VALUES('10002','12');
INSERT INTO caseSign VALUES('10003','13');
INSERT INTO caseSign VALUES('10003','14');

-- 
-- SELECT * FROM caseSign;
-- 
-- SELECT * FROM casePatient;
-- 
INSERT INTO casePatient VALUES('10001','S9811714J');
INSERT INTO casePatient VALUES('10002','S9911821P');
INSERT INTO casePatient VALUES('10003','S9512721E');


INSERT INTO caseGP VALUES('10001','0987654321');
INSERT INTO caseGP VALUES('10001','0987654321');
INSERT INTO caseGP VALUES('10002','0897564312');
INSERT INTO caseGP VALUES('10003','0897564312');

-- SELECT * FROM caseGP;
-- 
INSERT INTO caseConsultant VALUES('10001','123456789');
INSERT INTO caseConsultant VALUES('10001','123456789');
INSERT INTO caseConsultant VALUES('10002','123456789');
INSERT INTO caseConsultant VALUES('10003','123456789');

-- SELECT * FROM caseConsultant;

INSERT INTO caseNotification VALUES('10001','101');

