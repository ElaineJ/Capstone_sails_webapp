module.exports = {


  friendlyName: 'list',


  description: 'list gps.',


  inputs: {
    NRIC: {
      description: 'The ID of the user to look up.',
      type: 'string',
      //required: true
    },
    DOB: {
      description: 'a',
      type: 'string',
      //required: true
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

      var _ =require('lodash');

      const { NRIC } = inputs;
      const dateNormalizer = require('../../services/normalizeDate');
      const DOB = dateNormalizer.normalize(inputs.DOB);

      const PATIENTS_GET = 'select * from patients WHERE nric = \'' + NRIC +'\' AND dob = \''+ DOB + '\'' ;
      const rawPatients = await sails.sendNativeQuery(PATIENTS_GET);

      const PATIENTS_CASES = 'call query_cases()';


      const PATIENTS_QUERY_CASES = 'select * from temp_table_cases WHERE nric=\'' + NRIC + '\'';
      const rawPatientCases =  await sails.sendNativeQuery(PATIENTS_CASES);
      const rawQueryPatientCases = await sails.sendNativeQuery(PATIENTS_QUERY_CASES);

      const patientRecord = rawPatients.rows;
      const queryPatientCaseRow = rawQueryPatientCases.rows;

      sails.log(JSON.stringify(queryPatientCaseRow, null, 2));
      const output = [];

      _.forEach(queryPatientCaseRow, function(fullCase) {
        console.log("FULL CASE" + JSON.stringify(fullCase, null, 2))
        const {
          case_id,
          temperature,
          systole,
          diastole,
          heart_rate
        } = fullCase

        const parameters = {
          Temperature: temperature,
          Systole: systole,
          Diastole: diastole,
          BP: heart_rate
        }

        const symptoms = fullCase.symptoms;
        const signs = fullCase.signs;

        const {
          full_blood_count,
          ptt,
          uecr,
          liver_function_test
        } = fullCase;

        const investigations = {
          full_blood_count,
          ptt,
          uecr,
          LFT: liver_function_test
        }

        const additional_info = _.pick(fullCase, ["additional_info"])

        // const referringDoctor = _.pick(fullCase, ['Name', 'GPClinic', 'LicenseIDGP', 'GPEmail', 'GPPhoneNumber'])
        const referringDoctor = {
          Name: "Dr. Dale Lincoln",
        }
        const caseListItem = {
          case_id,
          parameters,
          symptoms,
          signs,
          investigations,
          additional_info,
          referringDoctor,
          createdAt: "2018-06-6"
        };
        output.push(caseListItem);
      });


      if (!_.isEmpty(output)){
        const payload = {
          history: output,
          status: '200 OK'
        };
        sails.log("Returned " + JSON.stringify(payload, null, 2))
        return exits.success({
          ...payload,
          error: false
        })

      }
      return exits.success({
        error: true,
        errorMessage: '200 No cases found'
      });







  }



};
