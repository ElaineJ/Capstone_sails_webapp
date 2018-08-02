module.exports = {


  friendlyName: 'InsertNew',


  description: 'Insert new notification into the database.',


  inputs: {
    advice: {
      type: 'string'
    },
    licence_id_consultant: {
      type: 'string'
    },
    case_id: {
      type: 'string'
    }

  },
///////// Queries
//   INSERT INTO case_notification VALUES(case_id, notification_id)
//   INSERT INTO notifications VALUES(notification_id,licence_id_consultant,selection, selection_sent)

  exits: {},


  fn: async function (inputs, exits) {
    const { advice, licence_id_consultant, case_id } = inputs
    const randomCaseId = Math.floor(Math.random() * (9999999 - 1000000) + 1000000);


    const dateNormalizer = require('../../services/normalizeDate');
    // notification_id, licence_id_consultant, selection, selection_sent
    const INSERT_NOTE = 'INSERT INTO notifications VALUES($1, $2, $3, $4)';
    const INSERT_CASE_NOTE = 'INSERT INTO case_notifications VALUES($1, $2)';

    const rawPatientCases =  await sails.sendNativeQuery(INSERT_NOTE, [randomCaseId, licence_id_consultant, advice, dateNormalizer.now()]);
    const result = await sails.sendNativeQuery(INSERT_CASE_NOTE, [case_id, randomCaseId])


    if (!_.isEmpty(result.rows)) {
      return exits.success({
        error: false,
        referral_data: result.rows[0]
      });
    }
    return exits.success({
      error: true,
      errorMessage: 'no notification found'
    });



  }
};
