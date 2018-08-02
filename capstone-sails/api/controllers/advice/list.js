module.exports = {


  friendlyName: 'Fetch',


  description: 'Fetch advice.',


  inputs: {

  },


  exits: {

  },


  fn: async function (inputs, exits) {
    const PATIENTS_CASES = 'call query_notifications()';


    const CASE_QUERY_CASES = 'select * from temp_table_notifications WHERE notification_id IS NULL';
    const rawPatientCases =  await sails.sendNativeQuery(PATIENTS_CASES);
    const result = await sails.sendNativeQuery(CASE_QUERY_CASES)

    if (!_.isEmpty(result.rows)) {
      return exits.success({
        error: false,
        referral_datalist: result.rows
      });
    }
    return exits.success({
      error: true,
      errorMessage: 'no notifications found'
    });

  }


};
