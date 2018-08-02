module.exports = {


  friendlyName: 'Get consultant on duty',


  description: '',


  inputs: {
    nric: {
      type: 'string'
    }
  },


  exits: {

  },


  fn: async function (inputs, exits) {

    const QUERY = "SELECT TOP 1 * FROM persistence ORDER BY loggedTime DESC";
    const result = await sails.sendNativeQuery(QUERY);

    if (!_.isEmpty(result.rows)){
      if (result.rows[0].is_consultant_on_duty === 1) {
        const assigned = result.rows[0]
        return exits.success({
          consultant_on_duty: assigned
        });
      }

    }


    return exits.success({
      is_consultant_on_duty: false,
      consultant_on_duty: null
    });

  }


};
