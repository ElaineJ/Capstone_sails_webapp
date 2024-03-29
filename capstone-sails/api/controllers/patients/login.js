module.exports = {


  friendlyName: 'Login Patient',


  description: 'Login patients.',


  inputs: {
    NRIC: {
      description: "the NRIC  number",
      type: 'string',
      required: true
    },

    DOB: {
      description: 'the Date of Birth',
      type: 'string',
      required: true
    }
  },


  exits: {

  },


  fn: async function (inputs, exits) {

    const NRIC = inputs.NRIC;
    const dateNormalizer = require('../../services/normalizeDate');
    const DOB = dateNormalizer.normalize(inputs.DOB);

    console.log("DOB IS" + DOB);

    const PATIENTS_GET = 'select * from patients WHERE nric = \'' + NRIC +'\' AND dob = \''+ DOB + '\'' ;
    const queryResults = await sails.sendNativeQuery(PATIENTS_GET);

    console.log("Query resylts = " + JSON.stringify(queryResults.rows, null, 2))


    // sails.log("QUERY RESULT" + JSON.stringify(queryResults.rows[0], null, 2));

    if (!_.isEmpty(queryResults.rows) && _.size(queryResults.rows) === 1){
      const patientData = queryResults.rows[0];
      patientData.dob = dateNormalizer.offsetTZ(patientData.dob);
      return exits.success({
        authData: patientData,
        error: false,
        role: 'patient'
      })

    }


    return exits.success({
      error: true,
      errorMessage:'Incorrect Credentials'
    });

  }
};
