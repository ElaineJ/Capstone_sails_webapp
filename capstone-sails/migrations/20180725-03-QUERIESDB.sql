-- Stores procedure needed to query and rank the files

USE Capstone_DB;

-- =============== UP ===================


-- saving case query into table
DROP PROCEDURE IF EXISTS query_cases;
delimiter $$

CREATE PROCEDURE query_cases()
BEGIN 
DROP TEMPORARY TABLE IF EXISTS temp_table_cases;
CREATE TEMPORARY TABLE temp_table_cases 
SELECT cases.case_id, 
  GROUP_CONCAT(DISTINCT patients.first_name, ' ', patients.last_name)patient_name, cases.nric, 
  GROUP_CONCAT(DISTINCT patients.dob)dob, 
  GROUP_CONCAT(DISTINCT patients.allergy)allergy,
  GROUP_CONCAT(DISTINCT patients.medical_history)medical_history, 
  GROUP_CONCAT(DISTINCT patients.gender)gender, 
  GROUP_CONCAT(DISTINCT gps.first_name, ' ', gps.last_name)gp_name, 
  GROUP_CONCAT(DISTINCT gps.organisation)gp_clinic,
  cases.licence_id_gp, 
  GROUP_CONCAT(DISTINCT gps.email)gp_email, 
  GROUP_CONCAT(DISTINCT gps.number)gp_number, 
  cases.temperature, 
  cases.systole, 
  cases.diastole, 
  cases.blood_pressure, 
  cases.full_blood_count, 
  cases.ptt, 
  cases.uecr, 
  cases.liver_function_test, 
  GROUP_CONCAT(DISTINCT symptoms.system)system,
  GROUP_CONCAT(distinct symptoms.symptom_id SEPARATOR ', ')symptoms_id, 
  GROUP_CONCAT(distinct signs.sign_id SEPARATOR ', ')signs_id, 
  cases.photo, 
  cases.pdf,
  cases.additional_info, 
  GROUP_CONCAT(DISTINCT consultants.first_name, ' ',consultants.last_name)consultant_name, 
  cases.licence_id_consultant, 
  GROUP_CONCAT(DISTINCT consultants.email)consultant_email,
  GROUP_CONCAT(DISTINCT consultants.number)consultant_phone_number, 
  cases.assigned, 
  cases.appointment_time,
  (SUM(symptoms.symptom_score)*COUNT(DISTINCT symptoms.symptom_id)/COUNT(*)+
  SUM(signs.sign_score)*COUNT(DISTINCT signs.sign_id)/COUNT(*))total_severity_score
FROM cases
LEFT JOIN case_symptoms csyp
ON cases.case_id=csyp.case_id
LEFT JOIN symptoms 
ON csyp.symptom_id=symptoms.symptom_id
LEFT JOIN case_signs csig
ON cases.case_id=csig.case_id
LEFT JOIN signs 
ON csig.sign_id=signs.sign_id
LEFT JOIN case_patients pat
ON cases.case_id=pat.case_id
LEFT JOIN patients
ON pat.nric=patients.nric
LEFT JOIN case_gps cgp
ON cases.case_id=cgp.case_id
LEFT JOIN gps 
ON cgp.licence_id_gp=gps.licence_id_gp
LEFT JOIN case_consultants cc
ON cases.case_id=cc.case_id
LEFT JOIN consultants 
ON cc.licence_id_consultant=consultants.licence_id_consultant
GROUP BY cases.case_id ORDER BY total_severity_score DESC, appointment_time ASC;

END $$

delimiter ;


-- ---------------------------------- NOTIFICATION QUERY ---------------------------------------------
DROP PROCEDURE IF EXISTS query_notifications;
delimiter $$

CREATE PROCEDURE query_notifications()
BEGIN 
DROP TEMPORARY TABLE IF EXISTS temp_table_notifications;
CREATE TEMPORARY TABLE temp_table_notifications 
SELECT cases.case_id, 
  GROUP_CONCAT(DISTINCT patients.first_name, ' ', patients.last_name)patient_name, 
  cases.nric, 
  GROUP_CONCAT(DISTINCT patients.dob)dob, 
  GROUP_CONCAT(DISTINCT patients.allergy)allergy,
  GROUP_CONCAT(DISTINCT patients.medical_history)medical_history, 
  GROUP_CONCAT(DISTINCT patients.gender)gender, 
  GROUP_CONCAT(DISTINCT gps.first_name, ' ', gps.last_name)gp_name, 
  GROUP_CONCAT(DISTINCT gps.organisation)gp_clinic,cases.licence_id_gp, 
  GROUP_CONCAT(DISTINCT gps.email)gp_email, 
  GROUP_CONCAT(DISTINCT gps.number)gp_number, 
  cases.temperature, 
  cases.systole, 
  cases.diastole, 
  cases.blood_pressure, 
  cases.full_blood_count, 
  cases.ptt, 
  cases.uecr, 
  cases.liver_function_test, 
  GROUP_CONCAT(DISTINCT symptoms.system)system,
  GROUP_CONCAT(distinct symptoms.symptom_id SEPARATOR ', ')symptoms_id, 
  GROUP_CONCAT(distinct signs.sign_id SEPARATOR ', ')signsId, 
  cases.photo, 
  cases.pdf,
  cases.additional_info, 
  GROUP_CONCAT(DISTINCT notifications.selection)selection, 
  GROUP_CONCAT(DISTINCT notifications.selection_sent)selection_sent,
  GROUP_CONCAT(DISTINCT notifications.licence_id_consultant)consultant_input,
  (SUM(symptoms.symptom_score)*COUNT(DISTINCT symptoms.symptom_id)/COUNT(*)+SUM(signs.sign_score)*COUNT(DISTINCT signs.sign_id)/COUNT(*))total_severity_score
FROM cases
LEFT JOIN case_symptoms csyp
ON cases.case_id=csyp.case_id
LEFT JOIN symptoms 
ON csyp.symptom_id=symptoms.symptom_id
LEFT JOIN case_signs csig
ON cases.case_id=csig.case_id
LEFT JOIN signs 
ON csig.sign_id=signs.sign_id
LEFT JOIN case_patients pat
ON cases.case_id=pat.case_id
LEFT JOIN patients
ON pat.nric=patients.nric
LEFT JOIN case_gps cgp
ON cases.case_id=cgp.case_id
LEFT JOIN gps 
ON cgp.licence_id_gp=gps.licence_id_gp
LEFT JOIN case_consultants cc
ON cases.case_id=cc.case_id
LEFT JOIN consultants 
ON cc.licence_id_consultant=consultants.licence_id_consultant
LEFT JOIN case_notifications cn
ON cases.case_id=cn.case_id
LEFT JOIN notifications 
ON cn.notification_id=notifications.notification_id
GROUP BY cases.case_id ORDER BY total_severity_score DESC, appointment_time ASC;

END $$

delimiter ;

-- =================== TEST =======================
-- 
-- -- Query for referral history for patients

-- call query_cases();


-- select * from temp_table_cases WHERE nric='S9811714J' AND dob = '1998-05-05';

-- -- Query for referral history for consultants
-- select * from temp_table_cases WHERE licence_id_consultant='123456789' AND consultant_email= 'kevintan@nuh.sg';
-- 
-- 
-- -- Query for referral history for gps
-- 
-- call query_cases();
-- select * from temp_table_cases WHERE licence_id_gp='0897564312' AND gp_email = 'alantan@nuh.sg';


-- 
-- -- Query for nofications

-- call query_notifications();
-- select * from temp_table_notifications WHERE nric='S9811714J' AND dob = '1998-05-05';

-- -- Query for referral history for consultants
select * from temp_table_notifications WHERE licence_id_consultant='123456789' AND consultant_email= 'kevintan@nuh.sg';
-- 
-- -- Query for referral history for gps
-- 
call query_notifications();
select * from temp_table_notifications WHERE licence_id_gp='0897564312' AND gp_email = 'alantan@nuh.sg';
SELECT * FROM temp_table_notifications;

-- ====================== DOWN =========================
-- 
-- DROP PROCEDURE query_cases;
-- DROP TEMPORARY TABLE IF EXISTS temp_table_cases;
-- 
-- DROP PROCEDURE query_notifications;
-- DROP TEMPORARY TABLE IF EXISTS temp_table_notifications;