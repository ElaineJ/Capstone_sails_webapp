module.exports = {


  friendlyName: 'fetch patient data',


  description: 'Used fetch patient data. Returns the patient\'s bio',


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


  },


  fn: async function (inputs, exits) {
    const NRIC = inputs.NRIC;
    const dateNormalizer = require('../../services/normalizeDate');
    const DOB = dateNormalizer.normalize(inputs.DOB);

    const PATIENTS_GET = 'select * from patients WHERE nric = \'' + NRIC + '\' AND DOB = \'' + DOB + '\'';
    sails.log("printing query, " + PATIENTS_GET);
    const queryResults = await sails.sendNativeQuery(PATIENTS_GET);

    if (!_.isEmpty(queryResults.rows) && _.size(queryResults.rows) === 1) {
      const patientData = queryResults.rows[0];
      return exits.success({
        patientData: patientData,
        error: false,
      })

    }


    return exits.success({
      error: true,
      errorMessage: 'Patient not found'
    });

  }
}
