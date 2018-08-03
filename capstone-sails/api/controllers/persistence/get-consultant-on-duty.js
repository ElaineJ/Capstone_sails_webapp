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

    const QUERY = "SELECT * FROM persistence ORDER BY loggedTime DESC LIMIT 1";
    const result = await sails.sendNativeQuery(QUERY);

    console.log(result.rows)
    if (!_.isEmpty(result.rows)){
      console.log(result.rows)
      if (result.rows[0].is_consultant_on_duty === 1) {
        sails.log.info("Consultant is on duty")
        const assigned = result.rows[0]
        return exits.success({
          is_consultant_on_duty: true,
          consultant_on_duty: assigned,
          error: false,
        })

      } else if (result.rows[0].is_consultant_on_duty === 0){
        sails.log.info("Consultant is off duty")

        return exits.success({
          consultant_on_duty: null,
          is_consultant_on_duty: false,
          error: false,
        })
      }

    }


    return exits.success({
      is_consultant_on_duty: false,
      consultant_on_duty: null
    });

  }


};
