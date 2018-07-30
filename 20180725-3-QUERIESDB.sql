

USE capstonev2;

-- saving case query into table

delimiter $$

CREATE PROCEDURE query_cases()
BEGIN 
DROP TABLE IF EXISTS querycasestbl;
CREATE TEMPORARY TABLE querycasestbl 
SELECT cases.caseId, GROUP_CONCAT(DISTINCT patients.firstName, ' ', patients.lastName)patientName, cases.nric, GROUP_CONCAT(DISTINCT patients.DOB)DOB, GROUP_CONCAT(DISTINCT patients.allergies)allergies,
GROUP_CONCAT(DISTINCT patients.medicalHistory)medicalHistory, GROUP_CONCAT(DISTINCT patients.gender)gender, GROUP_CONCAT(DISTINCT gps.firstName, ' ', gps.lastName)GPName, GROUP_CONCAT(DISTINCT gps.organisation)GPClinic,cases.licenceIdGP, GROUP_CONCAT(DISTINCT gps.email)GPEmail, GROUP_CONCAT(DISTINCT gps.number)GPPhoneNumber, 
cases.temperature, cases.systole, cases.diastole, cases.bp, cases.fullBloodCount, cases.ptt, cases.UECr, cases.liverFunctionTest, GROUP_CONCAT(DISTINCT symptoms.system)system,
GROUP_CONCAT(distinct symptoms.symptomId SEPARATOR ', ')symptomsId, GROUP_CONCAT(distinct signs.signId SEPARATOR ', ')signsId, cases.photos, cases.pdf,
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

call query_cases();
select * from querycasestbl WHERE nric='S9811714J' AND DOB = '1998-05-05';


-- Query for referral history for consultants
call query_cases();
select * from querycasestbl WHERE licenceIdConsultant='123456789' AND consultantEmail= 'kevintan@nuh.sg';


-- Query for referral history for gps

call query_cases();
select * from querycasestbl WHERE licenceIdGP='0897564312' AND GPEmail = 'alantan@nuh.sg';



DROP TABLE IF EXISTS querycasestbl;
DROP procedure query_cases;
DROP table querycasestbl;




-- ---------------------------------- NOTIFICATION QUERY ---------------------------------------------
delimiter $$

CREATE PROCEDURE query_notifications()
BEGIN 
DROP TABLE IF EXISTS querynotificationstbl;
CREATE TEMPORARY TABLE querynotificationstbl 
SELECT cases.caseId, GROUP_CONCAT(DISTINCT patients.firstName, ' ', patients.lastName)patientName, cases.nric, GROUP_CONCAT(DISTINCT patients.DOB)DOB, GROUP_CONCAT(DISTINCT patients.allergies)allergies,
GROUP_CONCAT(DISTINCT patients.medicalHistory)medicalHistory, GROUP_CONCAT(DISTINCT patients.gender)gender, GROUP_CONCAT(DISTINCT gps.firstName, ' ', gps.lastName)GPName, GROUP_CONCAT(DISTINCT gps.organisation)GPClinic,cases.licenceIdGP, GROUP_CONCAT(DISTINCT gps.email)GPEmail, GROUP_CONCAT(DISTINCT gps.number)GPPhoneNumber, 
cases.temperature, cases.systole, cases.diastole, cases.bp, cases.fullBloodCount, cases.ptt, cases.UECr, cases.liverFunctionTest, GROUP_CONCAT(DISTINCT symptoms.system)system,
GROUP_CONCAT(distinct symptoms.symptomId SEPARATOR ', ')symptomsId, GROUP_CONCAT(distinct signs.signId SEPARATOR ', ')signsId, cases.photos, cases.pdf,
cases.additionalInfo, GROUP_CONCAT(DISTINCT notifications.selection)selection, GROUP_CONCAT(DISTINCT notifications.selectionSent)selectionSent,GROUP_CONCAT(DISTINCT notifications.licenceIdConsultant)consultantInput,
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
LEFT JOIN caseNotification cn
ON cases.caseId=cn.caseId
LEFT JOIN notifications 
ON cn.notificationId=notifications.notificationId
GROUP BY cases.caseId ORDER BY totalSeverityScore DESC, appointmentTime ASC;

END $$

delimiter ;

-- Query for nofications

call query_notifications();
select * from querynotificationstbl WHERE nric='S9811714J' AND DOB = '1998-05-05';


-- Query for referral history for consultants
call query_notifications();
select * from querynotificationstbl WHERE licenceIdConsultant='123456789' AND consultantEmail= 'kevintan@nuh.sg';


-- Query for referral history for gps

call query_notifications();
select * from querynotificationstbl WHERE licenceIdGP='0897564312' AND GPEmail = 'alantan@nuh.sg';


DROP procedure query_notifications;
DROP table querynotificationstbl;


