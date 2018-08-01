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


      // for each single case
      _.forEach(queryPatientCaseRow, function(fullCase) {

        const patient_data = _.pick(fullCase, [
          'patient_name', 'nric', 'dob', 'allergy', 'medical_history', 'gender'
        ])


        // take the parameters

        const parameters = _.pick(fullCase, [
          'temperature', 'systole', 'diastole', 'heart_rate'
        ])



        // process symptoms and signs
        const symptoms = _.compact(_.split(fullCase.symptoms_id, ",").map(function(item) {
            return parseInt(item, 10);
          }));
        const signs = _.compact(_.split(fullCase.signs_id, ",").map(function(item) {
          return parseInt(item, 10);
        }));

        const investigations = _.pick(fullCase, [
          'full_blood_count', 'ptt', 'uecr', 'liver_function_test'
        ]);


        const additional_info = fullCase.additional_info;

        const gp = _.pick(fullCase, [
          'gp_name', 'gp_clinic', 'licence_id_gp', 'gp_email', 'gp_contact_number'
        ]);

        const consultant = _.pick(fullCase, [
          'consultant_name', 'licence_id_consultant', 'consultant_email', 'consultant_contact_number'
        ])

        // normalize appointment time
        const dateNormalizer = require('../../services/normalizeDate');
        const appointment_time = dateNormalizer.normalizeDateTime(fullCase.appointment_time);
        const created_at = dateNormalizer.normalizeDateTime(fullCase.created_at);

        // pick everything else
        const {
          case_id,
          assigned,
          total_severity_score
        } = fullCase;

        // craft payloadconsultant
        const payload = {
          case_id,
          patient_data,
          parameters,
          symptoms,
          signs,
          investigations,
          additional_info,
          gp,
          consultant,
          assigned,
          appointment_time,
          created_at,
          total_severity_score

        }

        output.push(payload);
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
