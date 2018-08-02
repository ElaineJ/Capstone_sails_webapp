module.exports = {


  friendlyName: 'List',


  description: 'List messenger.',


  inputs: {
      licence_id_consultant: {
        type: 'string'
      }
  },


  exits: {

  },


  fn: async function (inputs, exits) {
    const { licence_id_consultant } = inputs;
    const LIST_QUERY = 'SELECT DISTINCT nric,patient_name FROM message_boards WHERE consultant_id=$1'
    const result = await sails.sendNativeQuery(LIST_QUERY, [licence_id_consultant])

    if (!_.isEmpty(result.rows)) {
      return exits.success({
        contacts: result.rows,
        error: false
      });
    }
    return exits.success();

  }


};
