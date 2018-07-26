-- Seed file to populate DB with mock data for testing

USE Capstone_DB;

/* =
   =
   ================================== UP ============================
   =
   =
*/
 
INSERT INTO patients VALUES ('S9811714J', 'John', 'Tan','1998-05-05','Penicillin','patient had been hospitalise for asthma attack','M',  'No');
INSERT INTO patients VALUES ('S9911821P', 'James', 'Tan','1999-08-05','Penicillin',NULL,'M',  'No');
INSERT INTO patients VALUES ('S9512721E', 'Jacob', 'Tan','1995-09-05','Penicillin','patient had history of asthma','M',  'No');
INSERT INTO patients VALUES('Aaa', 'Test', 'User', '2018-07-23', 'Penicillin', 'patient is FAKE NEWS', 'M', 'No');
INSERT INTO patients VALUES('A', 'Test', 'User', '2018-07-24', 'Penicillin', 'patient is FAKE NEWS', 'M', 'No');

INSERT INTO gps VALUES ('0987654321', 'Matt', 'Tan','NUH','matttan@nuh.sg','matttan',  '90909090','No');
INSERT INTO gps VALUES ('0897564312', 'Alan', 'Tan','NUH','alantan@nuh.sg','alantan',  '90909091','No');
INSERT INTO gps values('123', 'Test', 'GP', 'NUH', 'test', 'testGP', '1234567','No');
INSERT INTO gps VALUES ('0897564382', 'Ala', 'Tan','NUH','123','123',  '90909091','No');

INSERT INTO consultants VALUES ('123456789', 'Kevin', 'Tan','NUH','kevintan@nuh.sg','kevintan',  '90900088',TRUE);
INSERT INTO consultants VALUES ('987654321', 'Test', 'Consultant', 'NUH', 'test@cons', 'testCons', '9876543', TRUE);
INSERT INTO consultants VALUES ('123456780', 'Kevin', 'Lee','NUH','123','123',  '90900088',TRUE);

INSERT INTO schedulers VALUES('0987654321', 'Matt', 'Tan','NUH','matttan@nuh.sg','matttan',  '90909090','Y');

INSERT INTO symptoms VALUES ('1','Site------Epigastrium','Gastrointestinal','1');
INSERT INTO symptoms VALUES (NULL,'Site------Right_Iliac_Fossa','Gastrointestinal','1');
INSERT INTO symptoms VALUES (NULL,'Site------Left_Iliac_Fossa','Gastrointestinal','1');
INSERT INTO symptoms VALUES (NULL,'Site------Right_Hypochondrium','Gastrointestinal','1');
INSERT INTO symptoms VALUES (NULL,'Site------Left_Hypochondrium','Gastrointestinal','1');
INSERT INTO symptoms VALUES (NULL,'Onset------Sudden','Gastrointestinal','2');
INSERT INTO symptoms VALUES (NULL,'Onset------Gradual','Gastrointestinal','1');
INSERT INTO symptoms VALUES (NULL,'Character------Sharp','Gastrointestinal','2');
INSERT INTO symptoms VALUES (NULL,'Character------Colicky','Gastrointestinal','1');
INSERT INTO symptoms VALUES (NULL,'Radiation------Back','Gastrointestinal','1');
INSERT INTO symptoms VALUES (NULL,'Radiation------Down_To_Groin','Gastrointestinal','1');
INSERT INTO symptoms VALUES (NULL,'Radiation------Umbilical_To_Right_Iliac_Fossa','Gastrointestinal','2');
INSERT INTO symptoms VALUES (NULL,'Alleviating_Factors------Curling_Up','Gastrointestinal','2');
INSERT INTO symptoms VALUES (NULL,'Alleviating_Factors------Staying_Still','Gastrointestinal','1');
INSERT INTO symptoms VALUES (NULL,'Timing------Constant','Gastrointestinal','1');
INSERT INTO symptoms VALUES (NULL,'Timing------Worse_With_Food','Gastrointestinal','2');
INSERT INTO symptoms VALUES (NULL,'Timing------Worse_After_Food','Gastrointestinal','1');
INSERT INTO symptoms VALUES (NULL,'Timing------Better_After_Vomiting','Gastrointestinal','2');
INSERT INTO symptoms VALUES (NULL,'Excerbating_Factors------Moving','Gastrointestinal','2');
INSERT INTO symptoms VALUES (NULL,'Anorexia','Gastrointestinal','1');
INSERT INTO symptoms VALUES (NULL,'Diarrhea------Bloody','Gastrointestinal','1');
INSERT INTO symptoms VALUES (NULL,'Diarrhea------Watery','Gastrointestinal','1');
INSERT INTO symptoms VALUES (NULL,'Vomiting','Gastrointestinal','2');
INSERT INTO symptoms VALUES (NULL,'Projectile------>3_Times','Gastrointestinal','2');
INSERT INTO symptoms VALUES (NULL,'Projectile------>1_Time','Gastrointestinal','1');
INSERT INTO symptoms VALUES (NULL,'Projectile------Yellow','Gastrointestinal','2');
INSERT INTO symptoms VALUES (NULL,'Wheezing','Respiratory','2');
INSERT INTO symptoms VALUES (NULL,'Stridor','Respiratory','2');
INSERT INTO symptoms VALUES (NULL,'Barking_Cough','Respiratory','3');
INSERT INTO symptoms VALUES (NULL,'Phelgm','Respiratory','1');
INSERT INTO symptoms VALUES (NULL,'Drooling','Respiratory','3');
INSERT INTO symptoms VALUES (NULL,'Difficulty_Breathing------Able_To_Speak_In_Full_Sentences','Respiratory','3');
INSERT INTO symptoms VALUES (NULL,'Difficulty_Breathing------Gasping','Respiratory','3');
INSERT INTO symptoms VALUES (NULL,'Difficulty_Breathing------Tripod_Position','Respiratory','3');
INSERT INTO symptoms VALUES (NULL,'Fever','Respiratory','1');
INSERT INTO symptoms VALUES (NULL,'Difficulty_Breathing','Circulatory','3');
INSERT INTO symptoms VALUES (NULL,'Palpitations','Circulatory','2');
INSERT INTO symptoms VALUES (NULL,'Dizziness','Circulatory','3');
INSERT INTO symptoms VALUES (NULL,'Lethargy','Circulatory','2');
INSERT INTO symptoms VALUES (NULL,'Joint_Pain------Upper_Limb','Musculoskeletal','1');
INSERT INTO symptoms VALUES (NULL,'Joint_Pain------Lower_Limb','Musculoskeletal','1');
INSERT INTO symptoms VALUES (NULL,'Joint_Pain------Worse_After_Activity','Musculoskeletal','1');
INSERT INTO symptoms VALUES (NULL,'Joint_Pain------Pain_At_Rest','Musculoskeletal','3');
INSERT INTO symptoms VALUES (NULL,'Trauma','Musculoskeletal','3');
INSERT INTO symptoms VALUES (NULL,'Rash------>12_Hrs','Musculoskeletal','2');
INSERT INTO symptoms VALUES (NULL,'Rash------>3_Days','Musculoskeletal','1');
INSERT INTO symptoms VALUES (NULL,'Rash------Sudden','Musculoskeletal','3');
INSERT INTO symptoms VALUES (NULL,'Rash------Bites','Musculoskeletal','2');
INSERT INTO symptoms VALUES (NULL,'Rash------Expose_To_Natural','Musculoskeletal','2');
INSERT INTO symptoms VALUES (NULL,'Rash------Overseas_Travel','Musculoskeletal','2');
INSERT INTO symptoms VALUES (NULL,'Rash------Itchy','Musculoskeletal','1');
INSERT INTO symptoms VALUES (NULL,'Rash------Discharge','Musculoskeletal','1');
INSERT INTO symptoms VALUES (NULL,'Hematuria','Urinary','2'); -- menses
INSERT INTO symptoms VALUES (NULL,'Frequency_Of_Urine------<5','Urinary','2'); 
INSERT INTO symptoms VALUES (NULL,'Frequency_Of_Urine------>5','Urinary','1'); 
INSERT INTO symptoms VALUES (NULL,'Frequency_Of_Urine------>10','Urinary','2'); 
INSERT INTO symptoms VALUES (NULL,'Dysuria','Urinary','1');
INSERT INTO symptoms VALUES (NULL,'Fever','Urinary','1');
INSERT INTO symptoms VALUES (NULL,'Urine_Flow------Normal','Urinary','1');
INSERT INTO symptoms VALUES (NULL,'Urine_Flow------Abnormal','Urinary','2'); 
INSERT INTO symptoms VALUES (NULL,'Testicular_Pain','Urinary','3'); 
INSERT INTO symptoms VALUES (NULL,'Fits','Neurology','2');
INSERT INTO symptoms VALUES (NULL,'Fever','Neurology','1');
INSERT INTO symptoms VALUES (NULL,'Duration------<1_min','Neurology','1');
INSERT INTO symptoms VALUES (NULL,'Duration------1-3_mins','Neurology','2');
INSERT INTO symptoms VALUES (NULL,'Duration------>3_mins','Neurology','3');
INSERT INTO symptoms VALUES (NULL,'Self_Aborted','Neurology','2');
INSERT INTO symptoms VALUES (NULL,'Type_Of_Movement------Atonic','Neurology','3');
INSERT INTO symptoms VALUES (NULL,'Type_Of_Movement------Clonic','Neurology','2');
INSERT INTO symptoms VALUES (NULL,'Type_Of_Movement------Tonic-Clonic','Neurology','3');
INSERT INTO symptoms VALUES (NULL,'Eye_Rolling','Neurology','2');
INSERT INTO symptoms VALUES (NULL,'Vomiting','Neurology','1');
INSERT INTO symptoms VALUES (NULL,'Loss_Of_Continence','Neurology','1');

INSERT INTO signs VALUES ('1','Rousing','Gastrointestinal','2');
INSERT INTO signs VALUES (NULL,'McBurnerys','Gastrointestinal','2');
INSERT INTO signs VALUES (NULL,'Ballotable_Kidneys','Gastrointestinal','1');
INSERT INTO signs VALUES (NULL,'Diagram0','Gastrointestinal','1');
INSERT INTO signs VALUES (NULL,'Diagram1','Gastrointestinal','1');
INSERT INTO signs VALUES (NULL,'Diagram2','Gastrointestinal','1');
INSERT INTO signs VALUES (NULL,'Diagram3','Gastrointestinal','1');
INSERT INTO signs VALUES (NULL,'Diagram4','Gastrointestinal','1');
INSERT INTO signs VALUES (NULL,'Diagram5','Gastrointestinal','1');
INSERT INTO signs VALUES (NULL,'Diagram6','Gastrointestinal','1');
INSERT INTO signs VALUES (NULL,'Diagram7','Gastrointestinal','1');
INSERT INTO signs VALUES (NULL,'Diagram8','Gastrointestinal','1');
INSERT INTO signs VALUES (NULL,'Wheeze','Respiratory','2');
INSERT INTO signs VALUES (NULL,'Creps','Respiratory','1');
INSERT INTO signs VALUES (NULL,'Stony_Dullness','Respiratory','3');
INSERT INTO signs VALUES (NULL,'Diagram0','Respiratory','1');
INSERT INTO signs VALUES (NULL,'Diagram1','Respiratory','1');
INSERT INTO signs VALUES (NULL,'Diagram2','Respiratory','1');
INSERT INTO signs VALUES (NULL,'Diagram3','Respiratory','1');
INSERT INTO signs VALUES (NULL,'Heart_Sounds','Circulatory','1');
INSERT INTO signs VALUES (NULL,'Rash','Musculoskeletal','0');
INSERT INTO signs VALUES (NULL,'Hypospadia','Urinary','3');
INSERT INTO signs VALUES (NULL,'Undescended_Testes','Urinary','3');
INSERT INTO signs VALUES (NULL,'Clitoromegaly','Urinary','2');
INSERT INTO signs VALUES (NULL,'Trauma','Urinary','3');
INSERT INTO signs VALUES (NULL,'Female_Diagram0','Urinary','1');
INSERT INTO signs VALUES (NULL,'Female_Diagram1','Urinary','1');
INSERT INTO signs VALUES (NULL,'Female_Diagram2','Urinary','1');
INSERT INTO signs VALUES (NULL,'Female_Diagram3','Urinary','1');
INSERT INTO signs VALUES (NULL,'Male_Diagram0','Urinary','1');
INSERT INTO signs VALUES (NULL,'Male_Diagram1','Urinary','1');
INSERT INTO signs VALUES (NULL,'Male_Diagram2','Urinary','1');
INSERT INTO signs VALUES (NULL,'Male_Diagram3','Urinary','1');
INSERT INTO signs VALUES (NULL,'Tone------Abnormal','Neurology','3');
INSERT INTO signs VALUES (NULL,'Power-----Abnormal','Neurology','3');
INSERT INTO signs VALUES (NULL,'Reflex------Abnormal','Neurology','1');
INSERT INTO signs VALUES (NULL,'Tone------Normal','Neurology','0');
INSERT INTO signs VALUES (NULL,'Power-----Normal','Neurology','0');
INSERT INTO signs VALUES (NULL,'Reflex------Normal','Neurology','0');
INSERT INTO signs VALUES (NULL,'Diagram0','Neurology','1');
INSERT INTO signs VALUES (NULL,'Diagram1','Neurology','1');
INSERT INTO signs VALUES (NULL,'Diagram2','Neurology','1');
INSERT INTO signs VALUES (NULL,'Diagram3','Neurology','1');
INSERT INTO signs VALUES (NULL,'Diagram4','Neurology','1');
INSERT INTO signs VALUES (NULL,'Diagram5','Neurology','1');
INSERT INTO signs VALUES (NULL,'Diagram6','Neurology','1');

-- PICTURES (DOUBLE CONFIRM THE SCORE)

INSERT INTO notifications VALUES ('101','123456780','5 days','2018-04-18');

INSERT INTO cases VALUES('10001','S9811714J','0987654321','2018-04-18','36.8', '100','50','100','Normal','Normal','Normal','Normal','','','Patient is in pain',TRUE,'2018-04-28 10:30:59','123456789','2018-06-18 10:30:59');
INSERT INTO cases VALUES(NULL,'S9911821P','0897564312','2018-04-20','37.8', '110','70','90','Normal','Abnormal','Normal','Normal','','','Patient complains of chest pain',TRUE,'2018-04-28 10:30:59','123456789','2018-06-18 11:30:59');
INSERT INTO cases VALUES(NULL,'S9512721E','0897564312','2018-05-20','38.8', '110','70','90','Normal','Abnormal','Normal','Normal','','','Patient had been experiencing condition since he returned from camp',TRUE,'2018-04-18 10:30:59','123456789','2018-05-19 11:30:59');

INSERT INTO case_symptoms VALUES('10001','2');
INSERT INTO case_symptoms VALUES('10001','3');
INSERT INTO case_symptoms VALUES('10001','4');
INSERT INTO case_symptoms VALUES('10001','5');

INSERT INTO case_symptoms VALUES('10002','24');
INSERT INTO case_symptoms VALUES('10002','25');
INSERT INTO case_symptoms VALUES('10002','26');
INSERT INTO case_symptoms VALUES('10002','27');

INSERT INTO case_symptoms VALUES('10003','38');
INSERT INTO case_symptoms VALUES('10003','41');
INSERT INTO case_symptoms VALUES('10003','43');
INSERT INTO case_symptoms VALUES('10003','46');
INSERT INTO case_symptoms VALUES('10003','47');

INSERT INTO case_signs VALUES('10001','2');
INSERT INTO case_signs VALUES('10001','3');
INSERT INTO case_signs VALUES('10002','12');
INSERT INTO case_signs VALUES('10003','13');
INSERT INTO case_signs VALUES('10003','14');

INSERT INTO case_patients VALUES('10001','S9811714J');
INSERT INTO case_patients VALUES('10002','S9911821P');
INSERT INTO case_patients VALUES('10003','S9512721E');

INSERT INTO case_gps VALUES('10001','0987654321');
INSERT INTO case_gps VALUES('10001','0987654321');
INSERT INTO case_gps VALUES('10002','0897564312');
INSERT INTO case_gps VALUES('10003','0897564312');

INSERT INTO case_consultants VALUES('10001','123456789');
INSERT INTO case_consultants VALUES('10001','123456789');
INSERT INTO case_consultants VALUES('10002','123456789');
INSERT INTO case_consultants VALUES('10003','123456789');

INSERT INTO case_notifications VALUES('10001','101');


/* =
   =
   ============================= TEST ======================= 
   =   
   =
  */

-- Successfully inserted consultants 
-- SELECT * FROM consultants;
-- SELECT * FROM consultants WHERE consultants.email = 'matttan@nuh.sg' AND consultants.password = 'matttan';

-- SELECT * FROM registers;

-- SELECT * FROM gps;
-- SELECT * FROM gps WHERE email = 'alantan@nuh.sg' AND password = 'alantan';

-- SELECT * FROM symptoms;

-- SELECT * FROM case_symptoms;

-- SELECT * FROM cases;


-- SELECT * FROM case_signs;

-- SELECT * FROM case_patients;

-- SELECT * FROM case_gps;

-- SELECT * FROM case_consultants;


/* ============================= DOWN ======================== */
--  NOTE THIS WILL EMPTY ALL CONTENTS OF THAT TABLE! USE WITH CAUTION

-- SET FOREIGN_KEY_CHECKS=0;
-- SELECT Concat('TRUNCATE TABLE ',table_schema,'.',TABLE_NAME, ';') 
-- FROM INFORMATION_SCHEMA.TABLES where  table_schema in ('db1_name','db2_name');
-- SET FOREIGN_KEY_CHECKS=1;