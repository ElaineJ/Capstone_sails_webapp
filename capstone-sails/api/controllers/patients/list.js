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
        // _.drop(fullCase, ['nric', 'dob'])

        // process symptoms and signs
        const symptoms = _.compact(_.split(fullCase.symptoms_id, ",").map(function(item) {
            return parseInt(item, 10);
          }));
        const signs = _.compact(_.split(fullCase.signs_id, ",").map(function(item) {
          return parseInt(item, 10);
        }));

        _.drop(fullCase, ['symptoms_id', 'signs_id']);

        const investigations = {
          full_blood_count: fullCase.full_blood_count,
          ptt: fullCase.ptt,
          uecr: fullCase.uecr,
          liver_function_test: fullCase.liver_function_test
        }
        const finalCase = {
          ...fullCase,
          symptoms,
          signs,
          investigations
        }
        output.push(finalCase);
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
