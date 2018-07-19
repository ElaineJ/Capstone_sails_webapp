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

    const NRIC = inputs.NRIC.toLowerCase();
    const DOB = inputs.DOB.toLowerCase();
    // TODO query in DB for a specific email address
    // Then, take the

    const PATIENTS_GET = 'select * from patients WHERE nric = \'' + NRIC +'\' AND DOB = \''+ DOB + '\'' ;
    const queryResults = await sails.sendNativeQuery(PATIENTS_GET);

    if (!_.isEmpty(queryResults.rows) && _.size(queryResults.rows) === 1){
      const patientData = queryResults.rows[0];
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
