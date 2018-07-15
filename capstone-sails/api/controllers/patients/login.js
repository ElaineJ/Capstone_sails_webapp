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
    const {
      NRIC,
      DOB
    } = inputs;

    // TODO query in DB for a specific email address
    // Then, take the

    const queryResults = {patient: {}}

    if (!_.isEmpty(queryResults.rows)){
      return exits.success({
        patient: queryResults.patient,
        status: '200 OK'
      })

    }

    return exits.success({
      status: '200 Not found'
    });

  }
};
