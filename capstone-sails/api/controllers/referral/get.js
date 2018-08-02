module.exports = {


  friendlyName: 'Get',


  description: 'Get referral.',


  inputs: {
    case_id: {
      type: "string"
    }
  },


  exits: {

  },


  fn: async function (inputs, exits) {
    const { case_id } = inputs;


    const PATIENTS_CASES = 'call query_cases()';


    const CASE_QUERY_CASES = 'select * from temp_table_cases WHERE case_id=\'' + case_id + '\'';
    const rawPatientCases =  await sails.sendNativeQuery(PATIENTS_CASES);
    const result = await sails.sendNativeQuery(CASE_QUERY_CASES)

    if (!_.isEmpty(result.rows)) {
      return exits.success({
        error: false,
        referral_data: result.rows[0]
      });
    }
    return exits.success();

  }


};
