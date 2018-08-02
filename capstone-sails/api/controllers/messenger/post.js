module.exports = {


  friendlyName: 'Post',


  description: 'Post messenger.',


  inputs: {

  },


  exits: {

  },


  fn: async function (inputs, exits) {
    const {licence_id_consultant, nric} = inputs;

    const QUERY_MESSAGES = 'INSERT INTO message_boards VALUES' +
      '($1, $2, $3, $4, $5<, $6, $7)';

    const dateNormalizer = require('../../services/normalizeDate');
    const isNow = dateNormalizer.now();
    const result = await sails.sendNativeQuery(QUERY_MESSAGES, [
      null, nric, patient_name, message, licence_id_consultant, consultant_name, isNow])

    if (!_.isEmpty(result.rows)) {
      return exits.success({
        error: false,
      });
    }
    return exits.success();

  }


};
