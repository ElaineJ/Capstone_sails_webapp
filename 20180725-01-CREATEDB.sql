-- Database initialization file

CREATE DATABASE nCubedDB;
USE nCubedDB;

-- CREATE TABLE users (
-- 	created_at DATETIME,
--     updated_t DATETIME,
--     id INT,
-- 	email_address VARCHAR(100),
--     password VARCHAR(50),
--     full_name VARCHAR(150),
--     is_super_admin BOOLEAN,
--     password_reset_token VARCHAR(100),
--     password_reset_token_expires_at VARCHAR(100),
--     stripe_customer_id VARCHAR (100),
--     has_billing_card BOOLEAN,
--     billing_card_brand VARCHAR (100),
--     billing_card_last_four VARCHAR (100),
--     billing_card_exp_month VARCHAR (100),
--     billing_card_exp_year VARCHAR (100),
--     email_proof_token VARCHAR(100),
--     email_proof_token_expires_at VARCHAR(100),
--     email_status BOOLEAN,
--     email_change_candidate VARCHAR(100),
--     tos_accepted_by_ip VARCHAR(100),
--     last_seen_at DATETIME,
--     PRIMARY KEY (id)
-- );


CREATE TABLE patients (
	nric VARCHAR(15),
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    dob DATE,
    allergy VARCHAR(150),
    medical_history VARCHAR(150),
	gender CHAR(1) CHECK (gender="F" or gender="M"),
    is_overseas CHAR(5) CHECK (status="Yes" OR status="No"),
    PRIMARY KEY (nric)
);


CREATE TABLE gps (
	licence_id_gp VARCHAR(25),
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    organisation VARCHAR(100),
	email VARCHAR(60),
	hashed_password VARCHAR(30),
    contact_number VARCHAR(30),
	is_overseas CHAR(5) CHECK (status="Yes" OR status="No"),
	PRIMARY KEY(licence_id_gp)
);



CREATE TABLE consultants (
	licence_id_consultant VARCHAR(25),
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    organisation VARCHAR(100),
	email VARCHAR(60),
	hashed_password VARCHAR(30),
    contact_number VARCHAR(30),
    scheduler BOOLEAN,
	PRIMARY KEY(licence_id_consultant)
);



CREATE TABLE schedulers (
	licence_id VARCHAR(25),
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    organisation VARCHAR(50),
	email VARCHAR(30),
	hashed_password VARCHAR(30),
    contact_number INT,
    confirmation CHAR(1) CHECK (confirmation="Y" or confirmation="N"),
	PRIMARY KEY(licence_id)
);




CREATE TABLE symptoms(
	symptom_id INT AUTO_INCREMENT,
    symptom VARCHAR(100),
    system VARCHAR(50),
    symptom_score INT,
    PRIMARY KEY(symptom_id)
);



CREATE TABLE signs(
	sign_id INT AUTO_INCREMENT,
    sign VARCHAR(100),
    system VARCHAR(50),
    sign_score INT,
    PRIMARY KEY(sign_id)
);

CREATE TABLE notifications(
	notification_id INT,
    licence_id_consultant VARCHAR(25),
    selection VARCHAR(50),
    selection_sent DATETIME,
	FOREIGN KEY(licence_id_consultant) REFERENCES consultants(licence_id_consultant),
    PRIMARY KEY(notification_id)
);


CREATE TABLE cases(
	case_id INT AUTO_INCREMENT,
    nric VARCHAR(15),
    licence_id_gp VARCHAR(25),
    created_at TIMESTAMP DEFAULT NOW(),
    temperature decimal(3,1),
    systole int,
    diastole int,
    blood_pressure int,
    full_blood_count CHAR(50) CHECK (full_blood_count ="Normal" OR full_blood_count ="Abnormal" OR full_blood_count ="NA"),
	ptt CHAR(50) CHECK 
    (ptt ="Normal" OR ptt ="Abnormal" OR ptt ="NA"),
    uecr CHAR(50) CHECK 
    (uecr ="Normal" OR uecr ="Abnormal" OR uecr ="NA"),
    liver_function_test CHAR(50) CHECK (lft ="Normal" OR lft ="Abnormal" OR lft ="NA"),
    photo VARCHAR(150),
    pdf VARCHAR(150),
    additional_info VARCHAR(200),
	assigned BOOLEAN,
	assigned_time DATETIME,
    licence_id_consultant VARCHAR(25),
    appointment_time DATETIME,
    FOREIGN KEY(nric) REFERENCES patients(nric),
	FOREIGN KEY(licence_id_gp) REFERENCES gps(licence_id_gp),
    FOREIGN KEY(licence_id_consultant) REFERENCES consultants(licence_id_consultant),
	PRIMARY KEY (case_id)
);



CREATE TABLE case_symptoms(
	case_id INT,
    symptom_id INT,
	FOREIGN KEY(case_id) REFERENCES cases(case_id),
	FOREIGN KEY(symptom_id) REFERENCES symptoms(symptom_id)
);


CREATE TABLE case_signs(
	case_id INT,
    sign_id INT,
	FOREIGN KEY(case_id) REFERENCES cases(case_id),
	FOREIGN KEY(sign_id) REFERENCES signs(sign_id)
);



CREATE TABLE case_patients(
	case_id INT,
    nric VARCHAR(15),
	FOREIGN KEY(case_id) REFERENCES cases(case_id),
	FOREIGN KEY(nric) REFERENCES patients(nric)
);


CREATE TABLE case_gps(
	case_id INT,
    licence_id_gp VARCHAR(25),
	FOREIGN KEY(case_id) REFERENCES cases(case_id),
	FOREIGN KEY(licence_id_gp) REFERENCES gps(licence_id_gp)
);


CREATE TABLE case_consultants(
	case_id INT,
    licence_id_consultant VARCHAR(25),
	FOREIGN KEY(case_id) REFERENCES cases(case_id),
	FOREIGN KEY(licence_id_consultant) REFERENCES consultants(licence_id_consultant)
);

CREATE TABLE case_notifications(
	case_id INT,
    notification_id INT,
	FOREIGN KEY(case_id) REFERENCES cases(case_id),
	FOREIGN KEY(notification_id) REFERENCES notifications(notification_id)
);

-- ============================ DOWN ===========================
-- NOTE THIS WILL DESTROY ALL TABLES IN DATABASE, PROCEED WITH CAUTION
-- 
-- use `Capstone_DB`;
--   SET FOREIGN_KEY_CHECKS = 0; 
--   SET @tables = NULL;
--   SET GROUP_CONCAT_MAX_LEN=32768;
-- 
--   SELECT GROUP_CONCAT('`', table_schema, '`.`', table_name, '`') INTO @tables
--   FROM   information_schema.tables 
--   WHERE  table_schema = (SELECT DATABASE());
--   SELECT IFNULL(@tables, '') INTO @tables;
-- 
--   SET        @tables = CONCAT('DROP TABLE IF EXISTS ', @tables);
--   PREPARE    stmt FROM @tables;
--   EXECUTE    stmt;
--   DEALLOCATE PREPARE stmt;
--   SET        FOREIGN_KEY_CHECKS = 1;


