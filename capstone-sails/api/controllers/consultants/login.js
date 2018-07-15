module.exports = {


  friendlyName: 'LoginConsultant',


  description: 'Login consultants. ',


  inputs: {
    email: {
      description: 'The registered email address',
      type: 'string',
      required: true
    },

    password: {
      description: 'The password to be compared',
      type: 'string',
      required: true
    }
  },


  exits: {
    success: {
      statusCode: '200',

    }
  },


  fn: async function (inputs, exits) {
      let emailAddress = inputs.email;
      let password = inputs.password;

      var credentials = require('./../../services/credentials');

      // TODO query in DB for a specific email address
      // Then, take the

      const row = {hashed: "2345678ijvcdrty"}; // replace this later
      const passwordMatch = credentials.comparePassword(password, row.hashed)

      if (passwordMatch) {
        return exits.success({
          // return the entire consultant data here
        });
      }

      return exits.success({
        status: '200 Invalid Credentials'
      });
  }
};
