module.exports = {


  friendlyName: 'fetch patient data',


  description: 'Used fetch patient data. Returns the patient\'s bio',


  inputs: {
    nric: {
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


  },


  fn: async function (inputs, exits) {

    try{

      var _ =require('lodash');

      const { nric, DOB } = inputs;
      sails.log(nric, DOB);
      const PATIENTS_GET = 'select * from patients WHERE nric = \'' + nric +'\' AND DOB = \''+ DOB + '\'' ;
      const rawPatients = await sails.sendNativeQuery(PATIENTS_GET);

      const PATIENTS_CASES = 'call query_case()';
      const PATIENTS_QUERY_CASES = 'select * from querycasetbl WHERE nric=\'' + nric + '\'';
      const rawPatientCases =  await sails.sendNativeQuery(PATIENTS_CASES);

      const rawQueryPatientCases = await sails.sendNativeQuery(PATIENTS_QUERY_CASES);

      sails.sendNativeQuery('DROP TABLE IF EXISTS querycasetbl');

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

      constcase= {
        parameters: parameters,
        symptoms: accessSymptom,
        signs: accessSigns,
        investigations: investigations,
        additionalInformation: Object.values(queryPatientCaseRow[0])[23]
      };

      doctorInformation = {
        Name: Object.values(queryPatientCaseRow[0])[7],
        GPClinic: Object.values(queryPatientCaseRow[0])[8],
        LicenceIdGP: Object.values(queryPatientCaseRow[0])[9],
        GPEmail: Object.values(queryPatientCaseRow[0])[10],
        GPPhoneNumber: Object.values(queryPatientCaseRow[0])[11],
      };

      if (!_.isEmpty(patientRecord) && _.size(patientRecord) == 1){
        return exits.success({
          caseId: caseId,
          patient: patientRecord[0],
          case: constcase,
          referringDoctor: doctorInformation,
          createdAt: Date.now(),

          status: '200 OK'
        })

      }
      return exits.success({
        status: '200 Patient Not Found'
      });





    }
    catch(err){
      //console.log(err);
      return exits.success();
    }

  }


};
