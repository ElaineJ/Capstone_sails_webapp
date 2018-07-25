CREATE DATABASE capstonev2;
USE capstonev2;

CREATE TABLE user (
	createdAt DATETIME,
    updatedAt DATETIME,
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
    emailStatus BOOLEAN,
    emailChangeCandidate VARCHAR(100),
    tosAcceptedByIp VARCHAR(100),
    lastSeenAt DATETIME,
    PRIMARY KEY (id)
);


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


CREATE TABLE gps (
	licenceIdGP VARCHAR(25),
    firstName VARCHAR(100),
    lastName VARCHAR(100),
    organisation VARCHAR(50),
	email VARCHAR(30),
	password VARCHAR(30),
    number INT,
	isOverseas CHAR(5) CHECK (status="Yes" OR status="No"),
	PRIMARY KEY(licenceIdGP)
);



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



CREATE TABLE scheduler (
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




CREATE TABLE symptoms(
	symptomId INT AUTO_INCREMENT,
    symptom VARCHAR(100),
    system VARCHAR(50),
    symptomScore INT,
    PRIMARY KEY(symptomId)
);



CREATE TABLE signs(
	signId INT AUTO_INCREMENT,
    sign VARCHAR(100),
    system VARCHAR(50),
    signScore INT,
    PRIMARY KEY(signId)
);

CREATE TABLE notifications(
	notificationId INT,
    licenceIdConsultant VARCHAR(25),
    selection VARCHAR(50),
    selectionSent DATETIME,
	FOREIGN KEY(licenceIdConsultant) REFERENCES consultants(licenceIdConsultant),
    PRIMARY KEY(notificationId)
);


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
    photos VARCHAR(150),
    pdf VARCHAR(150),
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



CREATE TABLE caseSymptom(
	caseId INT,
    symptomId INT,
	FOREIGN KEY(caseId) REFERENCES cases(caseId),
	FOREIGN KEY(symptomId) REFERENCES symptoms(symptomId)
);


CREATE TABLE caseSign(
	caseId INT,
    signId INT,
	FOREIGN KEY(caseId) REFERENCES cases(caseId),
	FOREIGN KEY(signId) REFERENCES signs(signId)
);



CREATE TABLE casePatient(
	caseId INT,
    nric VARCHAR(15),
	FOREIGN KEY(caseId) REFERENCES cases(caseId),
	FOREIGN KEY(nric) REFERENCES patients(nric)
);


CREATE TABLE caseGP(
	caseId INT,
    licenceIdGP VARCHAR(25),
	FOREIGN KEY(caseId) REFERENCES cases(caseId),
	FOREIGN KEY(licenceIdGP) REFERENCES gps(licenceIdGP)
);


CREATE TABLE caseConsultant(
	caseId INT,
    licenceIdConsultant VARCHAR(25),
	FOREIGN KEY(caseId) REFERENCES cases(caseId),
	FOREIGN KEY(licenceIdConsultant) REFERENCES consultants(licenceIdConsultant)
);

CREATE TABLE caseNotification(
	caseId INT,
    notificationId INT,
	FOREIGN KEY(caseId) REFERENCES cases(caseId),
	FOREIGN KEY(notificationId) REFERENCES notifications(notificationId)
);

-- 
-- 
-- DROP TABLE user;
-- DROP TABLE patients;
-- DROP TABLE gps;
-- DROP TABLE consultants;
-- DROP TABLE cases;
-- DROP TABLE caseSymptom;
-- DROP TABLE caseSign;
-- DROP TABLE casePatient;
-- DROP TABLE caseGP;
-- DROP TABLE caseConsultant;
-- DROP TABLE caseNotification;
-- -- DROP TABLE symptoms;
-- -- DROP TABLE signs;
-- DROP DATABASE capstonev2;
-- 
