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
    sails.log(inputs.NRIC, inputs.DOB)

      var _ =require('lodash');

      const { NRIC } = inputs;
      sails.log(NRIC, inputs.DOB);
      const dateNormalizer = require('../../services/normalizeDate');
      const DOB = dateNormalizer.normalize(inputs.DOB);
      sails.log(NRIC, DOB);

      const PATIENTS_GET = 'select * from patients WHERE NRIC = \'' + NRIC +'\' AND DOB = \''+ DOB + '\'' ;
      const rawPatients = await sails.sendNativeQuery(PATIENTS_GET);

      const PATIENTS_CASES = 'call query_cases()';


      const PATIENTS_QUERY_CASES = 'select * from querycasestbl WHERE NRIC=\'' + NRIC + '\'';
      const rawPatientCases =  await sails.sendNativeQuery(PATIENTS_CASES);
      const rawQueryPatientCases = await sails.sendNativeQuery(PATIENTS_QUERY_CASES);

      const patientRecord = rawPatients.rows;
      const queryPatientCaseRow = rawQueryPatientCases.rows;

      sails.log(JSON.stringify(queryPatientCaseRow, null, 2));
      const output = [];

      _.forEach(queryPatientCaseRow, function(fullCase) {
        const {
          caseId,
          temperature,
          systole,
          diastole,
          bp
        } = fullCase

        const parameters = {
          Temperature: temperature,
          Systole: systole,
          Diastole: diastole,
          BP: bp
        }

        const symptoms = fullCase.symptoms;
        const signs = fullCase.signs;

        const {
          fullBloodCount,
          ptt,
          UECr,
          liverFunctionTest
        } = fullCase;
        const investigations = {
          fullBloodCount,
          ptt,
          UECr,
          LFT: liverFunctionTest
        }

        const additionalInfo = _.pick(fullCase, ["additionalInfo"])

        // const referringDoctor = _.pick(fullCase, ['Name', 'GPClinic', 'LicenseIDGP', 'GPEmail', 'GPPhoneNumber'])
        const referringDoctor = {
          Name: "Dr. Dale Lincoln",
        }
        const caseListItem = {
          caseId,
          parameters,
          symptoms,
          signs,
          investigations,
          additionalInfo,
          referringDoctor,
          createdAt: "2018-06-6"
        };
        output.push(caseListItem);
      });

      const payload = {
        history: output,
        status: '200 OK'
      };

      if (!_.isEmpty(patientRecord)){
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
