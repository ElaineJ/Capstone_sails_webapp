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

    sails.log.info(NRIC, "AND " + DOB + "AND" + inputs.DOB);
    const PATIENTS_GET = 'select * from patients WHERE nric = \'' + NRIC + '\' AND dob = \'' + inputs.DOB + '\'';

    const queryResults = await sails.sendNativeQuery(PATIENTS_GET);

    sails.log.info(queryResults.rows[0])
    if (!_.isEmpty(queryResults.rows)) {
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
