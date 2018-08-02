module.exports = {


  friendlyName: 'InsertNew',


  description: 'Insert new notification into the database.',


  inputs: {

  },
///////// Queries
//   INSERT INTO case_notification VALUES(case_id, notification_id)
//   INSERT INTO notifications VALUES(notification_id,licence_id_consultant,selection, selection_sent)

  exits: {},


  fn: async function (inputs, exits) {

    const randomCaseId = Math.floor(Math.random() * (9999999 - 1000000) + 1000000);

    const INSERT_NOTE = 'INSERT INTO notifications VALUES()';
    const INSERT_CASE_NOTE = 'INSERT INTO case_notification VALUES(case_id, notification_id)';
    const rawPatientCases =  await sails.sendNativeQuery(INSERT_NOTE);
    const result = await sails.sendNativeQuery(INSERT_CASE_NOTE)

    if (!_.isEmpty(result.rows)) {
      return exits.success({
        error: false,
        referral_data: result.rows[0]
      });
    }
    return exits.success({
      error: true,
      errorMessage: 'no notifications found'
    });



  }
};
