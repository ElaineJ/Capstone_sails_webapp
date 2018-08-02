module.exports = {


  friendlyName: 'LoginConsultant',


  description: 'Login consultants. ',


  inputs: {
    email: {
      description: 'The registered email address',
      type: 'string',
      required: true,
      //isEmail: true
    },

    password: {
      description: 'The password to be compared',
      type: 'string',
      required: true,
      //minLength: 8
    }
  },


  exits: {
    success: {
      statusCode: '200',

    }
  },


  fn: async function (inputs, exits) {


    const email = inputs.email.toLowerCase();
    const password = inputs.password;
    // ails.log("Loggin in as GP with " + email + password);

    const GPS_LOGIN = 'select * from consultants WHERE email = \'' + email + '\' AND hashed_password = \'' + password + '\'';
    const queryResults = await sails.sendNativeQuery(GPS_LOGIN);


    if (!_.isEmpty(queryResults.rows) && _.size(queryResults.rows) === 1) {
      const consultantData = _.drop(queryResults.rows[0], ['hashed_password']);
      //sails.log("Found consultant data" + consultantData);
      return exits.success({
        authData: { ...consultantData,
          role: 'consultant'},
        error: false,
      })
    }

    return exits.success({
      error: true,
      errorMessage: 'Incorrect Credentials'
    })
  }
}
