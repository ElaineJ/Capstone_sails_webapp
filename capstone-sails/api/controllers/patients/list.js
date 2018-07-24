module.exports = {


  friendlyName: 'list',


  description: 'list gps.',


  inputs: {
    NRIC: {
      description: 'The ID of the user to look up.',
      type: 'string',
      required: true
    },
    DOB: {
      description: 'a',
      type: 'string',
      required: true
    }

  },


  exits: {
    success: {

    },
    notFound: {
      description: 'No user with the specified ID was found in the database.',
      responseType: 'notFound'
    },
    timeOut: {
      description: 'Account locked for 30 mins, incorrect email or password.',
      responseType: 'notFound'
    },

  },


  fn: async function (inputs, exits) {

    try{

      var _ =require('lodash');

      const { NRIC, DOB } = inputs;
      sails.log(NRIC, DOB);
      await sails.sendNativeQuery('DROP TEMPORARY TABLE IF EXISTS querycasetbl');

      const PATIENTS_GET = 'select * from patients WHERE NRIC = \'' + NRIC +'\' AND DOB = \''+ DOB + '\'' ;
      const rawPatients = await sails.sendNativeQuery(PATIENTS_GET);

      const PATIENTS_CASES = 'call query_cases()';
      const PATIENTS_QUERY_CASES = 'select * from querycasetbl WHERE NRIC=\'' + NRIC + '\'';
      const rawPatientCases =  await sails.sendNativeQuery(PATIENTS_CASES);
      sails.log(JSON.stringify(rawPatientCases));
      const rawQueryPatientCases = await sails.sendNativeQuery(PATIENTS_QUERY_CASES);

      sails.sendNativeQuery('DROP TEMPORARY TABLE querycasetbl');

      const patientRecord = rawPatients.rows;
      const queryPatientCaseRow = rawQueryPatientCases.rows;
      const caseId = Object.values(queryPatientCaseRow[0])[0];
      //const system = Object.values(queryPatientCaseRow[0])[20];

      const parameters={
        Temperature:String(Object.values(queryPatientCaseRow[0])[12]),
        Systole: String(Object.values(queryPatientCaseRow[0])[13]),
        Diastole: String(Object.values(queryPatientCaseRow[0])[14]),
        Blood_Pressure: String(Object.values(queryPatientCaseRow[0])[15])

      };

      const accessSymptom= {
        Symptoms:Object.values(queryPatientCaseRow[0])[21]

      };
      const accessSigns={
        Signs: Object.values(queryPatientCaseRow[0])[22]

      };

      const investigations = {
        Full_Blood_Count: Object.values(queryPatientCaseRow[0])[16],
        PTT: Object.values(queryPatientCaseRow[0])[17],
        UCEr: Object.values(queryPatientCaseRow[0])[18],
        Liver_Function_Test:Object.values(queryPatientCaseRow[0])[19]
      };

      const cases = {
        parameters: parameters,
        symptoms: accessSymptom,
        signs: accessSigns,
        investigations: investigations,
        additionalInformation: Object.values(queryPatientCaseRow[0])[23]
      };

      const doctorInformation = {
        Name: Object.values(queryPatientCaseRow[0])[7],
        GPClinic: Object.values(queryPatientCaseRow[0])[8],
        LicenceIdGP: Object.values(queryPatientCaseRow[0])[9],
        GPEmail: Object.values(queryPatientCaseRow[0])[10],
        GPPhoneNumber: Object.values(queryPatientCaseRow[0])[11],
      };

      const payload = {
        caseId: caseId,
        patient: patientRecord[0],
        case: cases,
        referringDoctor: doctorInformation,
        createdAt: Date.now(),

        status: '200 OK'
      }
      if (!_.isEmpty(patientRecord) && _.size(patientRecord) === 1){
        return exits.success(payload)

      }
      return exits.success({
        status: '200 Patient Not Found'
      });





    }
    catch(err){
      console.log(err);
      return exits.success({
        error: err
      });
    }

  }



};
