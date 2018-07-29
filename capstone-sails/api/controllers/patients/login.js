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

    const PATIENTS_GET = 'select * from patients WHERE nric = \'' + NRIC +'\' AND dob = \''+ DOB + '\'' ;
    const queryResults = await sails.sendNativeQuery(PATIENTS_GET);

    //const mailgunService = require("../../services/mailgunService");
    //mailgunService.sendEmail();

    sails.log("QUERY RESULT" + JSON.stringify(queryResults.rows[0], null, 2));
    const notificationPusher = require("../../services/pushNotification");
    const message = {
      title: queryResults.rows[0].first_name + " Has logged in",
      body: "BEWARE!"
    }
    notificationPusher.pushNewNotification(message, queryResults.rows[0].expo_push_token);

    if (!_.isEmpty(queryResults.rows) && _.size(queryResults.rows) === 1){
      const patientData = queryResults.rows[0];
      patientData.DOB = dateNormalizer.offsetTZ(patientData.DOB);
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
