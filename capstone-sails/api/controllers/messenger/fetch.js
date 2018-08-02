module.exports = {


  friendlyName: 'Fetch',


  description: 'Fetch messenger.',


  inputs: {
      licence_id_consultant: {
        type: 'string'
      },
    nric: {
        type: 'string'
    }
  },


  exits: {

  },


  fn: async function (inputs, exits) {

    const {licence_id_consultant, nric} = inputs;

    const QUERY_MESSAGES = 'SELECT * FROM message_boards WHERE licence_id_consultant=$1 AND nric=$2 ORDER BY created_at DESC';

    const result = await sails.sendNativeQuery(QUERY_MESSAGES, [licence_id_consultant, nric])

    if (!_.isEmpty(result.rows)) {
      return exits.success({
        messages: result.rows,
        error: false,
      });
    }
    return exits.success();

  }


};
