module.exports = {


  friendlyName: 'Post',


  description: 'Post referralinsert.',


  inputs: {

  },


  exits: {

  },


  fn: async function (inputs, exits) {

    var _ =require('lodash');

    var obj = {
      "patient_record": {
        "nric": "S9512721E",
        "firstName": "Jacob",
        "lastName": "Tan",
        "DOB": "1995-09-04T16:00:00.000Z",
        "allergies": "Penicillin",
        "medicalHistory": "patient had history of asthma",
        "gender": "M",
        "isOverseas": "No"
      },
      "patient_cases": {
        "caseId": 10003,
        "patientName": "Jacob Tan",
        "nric": "S9512721E",
        "DOB": "1995-09-05",
        "allergies": "Penicillin",
        "medicalHistory": "patient had history of asthma",
        "gender": "M",
        "gpName": "Alan Tan",
        "licenceIdGP": "0897564312",
        "gpEmail": "alantan@nuh.sg",
        "gpPhoneNumber": "90909091",
        "temperature": 38.8,
        "systole": 110,
        "diastole": 70,
        "bp": 90,
        "fullBloodCount": "Normal",
        "ptt": "Abnormal",
        "UECr": "Normal",
        "liverFunctionTest": "Normal",
        "system": "Neurology",
        "symptoms": "Duration ------ >3min, Eye Rolling, Fever, Type Of Movement ------ Atonic, Vomitting",
        "signs": "Power - Abnormal, Tone - Abnormal",
        "additionalInfo": "Patient had been experiencing condition since he returned from camp",
        "consultantName": "Kevin Tan",
        "licenceIdConsultant": "123456789",
        "consultantEmail": "kevintan@nuh.sg",
        "consultantPhoneNumber": "90900088",
        "assigned": 1,
        "appointmentTime": "2018-05-19T03:30:59.000Z",
        "totalSeverityScore": 16
      },
      "status": "200 OK"
    };



    //console.log(obj);
    var nric = _.get(obj, 'patient_record.nric');
    var firstName = _.get(obj, 'patient_record.firstName');
    var lastName = _.get(obj, 'patient_record.lastName');
    var DOB = _.get(obj, 'patient_record.DOB');
    var allergies = _.get(obj, 'patient_record.allergies');
    var medicalHistory = _.get(obj, 'patient_record.medicalHistory');
    var gender = _.get(obj, 'patient_record.gender');
    var isOverseas = _.get(obj, 'patient_record.isOverseas');

    //var caseId = Math.floor((Math.random() * 100000000) + 1);
    var caseId = _.get(obj, 'patient_cases.caseId');
    var GPName = _.get(obj, 'patient_cases.GPName');
    //var createdAt = time.now();

    var licenceIdGP = _.get(obj, 'patient_cases.licenceIdGP');
    var GPEmail = _.get(obj, 'patient_cases.GPEmail');
    var GPPhoneNumber = _.get(obj, 'patient_cases[0].GPPhoneNumber');
    var temperature = _.get(obj, 'patient_cases[0].temperature');
    var systole = _.get(obj, 'patient_cases[0].systole');
    var diastole = _.get(obj, 'patient_cases[0].diastole');
    var bp = _.get(obj, 'patient_cases[0].bp');
    var fullBloodCount = _.get(obj, 'patient_cases[0].fullBloodCount');
    var ptt = _.get(obj, 'patient_cases[0].ptt');
    var UECr = _.get(obj, 'patient_cases[0].UECr');
    var liverFunctionTest = _.get(obj, 'patient_cases[0].liverFunctionTest');
    var system = _.get(obj, 'patient_cases[0].system');
    var symptoms = _.get(obj, 'patient_cases[0].symptoms');
    var signs = _.get(obj, 'patient_cases[0].signs');
    var additionalInfo = _.get(obj, 'patient_cases[0].additionalInfo');
    var consultantName = _.get(obj, 'patient_cases[0].consultantName');
    var licenceIdConsultant = _.get(obj, 'patient_cases[0].licenceIdConsultant');
    var consultantEmail = _.get(obj, 'patient_cases[0].consultantEmail');
    var consultantPhoneNumber = _.get(obj, 'patient_cases[0].consultantPhoneNumber');
    var assigned = _.get(obj, 'patient_cases[0].assigned');
    var appointmentTime = '2018-07-27 10:30:59';
    var totalSeverityScore = _.get(obj, 'patient_cases[0].totalSeverityScore');
    var createdAt = '2018-07-01 10:30:59';
    var assignedTime = '2018-07-20 10:30:59';
    //
    //
    //
    // var rawsymptoms = _.get(obj, 'patient_cases[0].symptoms');
    // var symptoms = rawsymptoms.split(',')
    // //var symptoms = rawsymptoms.push();
    //

    //
    // // ------------------------------- INSERT PATIENT RECORD -------------------------------------------
    // var INSERT_PATIENT = "\'"+nric+"\'" +','+"\'"+firstName+"\'"+','+"\'"+lastName+"\'" +','+"\'"+DOB+"\'" +','+"\'"+allergies+"\'" +','+"\'" + medicalHistory+"\'"  +','+"\'"+gender+"\'" + ',' +"\'"+isOverseas+"\'";
    //
    // const INSERT_RECORD = "INSERT INTO patients VALUES ("+ INSERT_PATIENT+")";
    //
    // const insertPatient = await sails.sendNativeQuery(INSERT_RECORD);
    //
    //
    // // ---------------------------------INSERT NEW CASE ----------------------------------
    // //
    // var INSERT_CASE = "\'"+caseId+"\'" +','+"\'"+nric+"\'"+','+"\'"+licenceIdGP+"\'" +','+"\'"+createdAt+"\'" +','+"\'"+temperature+"\'" +','+"\'" + systole+"\'"  +','+"\'"+diastole+"\'" + ',' +"\'"+bp+"\'" +','+"\'"+fullBloodCount+"\'"+','+"\'"+ptt+"\'"+','+"\'"+UECr+"\'" +','+"\'"+liverFunctionTest+"\'" +','+"\'"+additionalInfo+"\'" +','+"\'"+assigned+"\'" +','+"\'"+assignedTime+"\'" +','+"\'"+licenceIdConsultant+"\'" +','+"\'"+appointmentTime+"\'"    ;
    //
    // const INSERT_CASE_RECORD = "INSERT INTO cases VALUES ("+ INSERT_CASE +")";
    //
    // const insertCase = await sails.sendNativeQuery(INSERT_CASE_RECORD);
    //
    // // ----------- MATCH CASE TO SYMPOTOM -----------------
    //
    // const INSERT_CASE_SYMPTOM1 = "INSERT INTO caseSymptom VALUES('10006','24')";
    // const INSERT_CASE_SYMPTOM2 = "INSERT INTO caseSymptom VALUES('10006','25')";
    // const INSERT_CASE_SYMPTOM3 = "INSERT INTO caseSymptom VALUES('10006','26')";
    // const INSERT_CASE_SYMPTOM4 = "INSERT INTO caseSymptom VALUES('10006','27')";
    // const insertCaseSYMPTOM1 = await sails.sendNativeQuery(INSERT_CASE_SYMPTOM1);
    // const insertCaseSYMPTOM2 = await sails.sendNativeQuery(INSERT_CASE_SYMPTOM2);
    // const insertCaseSYMPTOM3 = await sails.sendNativeQuery(INSERT_CASE_SYMPTOM3);
    // const insertCaseSYMPTOM4 = await sails.sendNativeQuery(INSERT_CASE_SYMPTOM4);
    //
    //
    // // INSERT INTO caseSymptom VALUES('10002','24'); -- Match the symptoms entries to the case
    // // INSERT INTO caseSymptom VALUES('10002','25');
    // // INSERT INTO caseSymptom VALUES('10002','26');
    // // INSERT INTO caseSymptom VALUES('10002','27');
    //
    // // ----------- MATCH CASE TO SIGN -----------------
    //
    // const INSERT_CASE_SIGN = "INSERT INTO caseSign VALUES('10006','12')";
    // const insertCaseSIGN = await sails.sendNativeQuery(INSERT_CASE_SIGN);
    // // INSERT INTO caseSign VALUES('10002','12');   -- Match the signs entries to the case
    //
    // //------------ MATCH CASE TO GP -------------
    //
    // var INSERT_CASE_GP = "\'"+caseId+"\'" +','+"\'"+licenceIdGP+"\'";
    //
    // const INSERT_CASE_GP_RECORD = "INSERT INTO caseGP VALUES ("+ INSERT_CASE_GP +")";
    //
    // const insertCaseGP = await sails.sendNativeQuery(INSERT_CASE_GP_RECORD);
    //
    //
    // //------------ MATCH CASE TO Consultant -------------
    //
    // var INSERT_CASE_CONSULTANT = "\'"+caseId+"\'" +','+"\'"+licenceIdConsultant+"\'";
    //
    // const INSERT_CASE_CONSULTANT_RECORD = "INSERT INTO caseConsultant VALUES ("+ INSERT_CASE_CONSULTANT +")";
    //
    // const insertCaseConsultant = await sails.sendNativeQuery(INSERT_CASE_CONSULTANT_RECORD);
    //
    //
    // //------------ MATCH CASE TO PAIENT -------------
    //
    // var INSERT_CASE_PATIENT = "\'"+caseId+"\'" +','+"\'"+nric+"\'";
    //
    // const INSERT_CASE_PATIENT_RECORD = "INSERT INTO casePatient VALUES ("+ INSERT_CASE_PATIENT +")";
    //
    // const insertCasePatient = await sails.sendNativeQuery(INSERT_CASE_PATIENT_RECORD);
    //
    //
    //
    //
    //
    //
    // return exits.success(insertCase,insertCaseConsultant,insertCaseGP,insertCasePatient,insertCaseSYMPTOM1,insertCaseSYMPTOM2,insertCaseSYMPTOM3,insertCaseSYMPTOM4,insertCaseSIGN);

    return exits.success(nric);
    return exits.success(symptoms);
    //return exits.success(insertPatient);

  }


};


