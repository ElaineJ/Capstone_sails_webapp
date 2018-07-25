module.exports = {


  friendlyName: 'Login',


  description: 'Login gps.',


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
    sails.log("Loggin in as GP with " + email + password);

    const GPS_LOGIN = 'select * from gps WHERE email = \'' + email + '\' AND password = \'' + password + '\'';

    sails.log("Trying query")
    const queryResults = await sails.sendNativeQuery(GPS_LOGIN);
    sails.log("query finished with ", queryResults.rows)

    if (!_.isEmpty(queryResults.rows) && _.size(queryResults.rows) === 1) {
      const gpData = queryResults.rows[0];
      sails.log("Found gp data " + gpData);
      return exits.success({
        authData: gpData,
        error: false,
        role: 'gp'
      })
    }

    return exits.success({
      error: true,
      errorMessage: 'Incorrect Credentials'
    })

  }
}
