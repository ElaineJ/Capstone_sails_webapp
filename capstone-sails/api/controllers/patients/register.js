module.exports = {


  friendlyName: 'Register new patient ',


  description: 'Register patient if not found in database',


  inputs: {
    firstName: {
      description: "patient's first name",
      type: 'string',
      required: true
    },

    lastName: {
      description: "patient's last name",
      type: 'string',
      required: true
    },
    gender: {
      description: "Male or Female",
      type: 'string',
      isIn: ['male', 'female']
    },
    drugAllergies: {
      description: "JSON collection object of Drug allergies",
      type: "JSON"
    },
    medicalHistories: {
      description: "JSON collection object of medical histories",
      type: "JSON"
    }
  },


  exits: {

  },


  fn: async function (inputs, exits) {
    const {
      firstName,
      lastName,
      gender,
      drugAllergies,
      medicalHistories
    } = inputs;

    // TODO insert if not exist into patients database
    // TODO return if success or fail

    const queryResults = {}

    if (queryResults) {
      return exits.success({
        status: "200 inserted successfully"
      })
    }


    return exits.success({
      status: "200 failed to insert"
    });

  }


};
