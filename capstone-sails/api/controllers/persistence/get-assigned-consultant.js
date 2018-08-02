module.exports = {


  friendlyName: 'Get assigned consultant',


  description: '',


  inputs: {
    nric: {
      type: 'string'
    }
  },


  exits: {

  },


  fn: async function (inputs, exits) {
    sails.log("result row is not empty" + JSON.stringify(inputs))
    const { nric } = inputs;

    const GET_QUERY =  'SELECT licence_id_consultant from patient_consultants where nric = $1'
    const result = await sails.sendNativeQuery(GET_QUERY, [nric])


    // sails.log("result row is not empty" + JSON.stringify(result.rows[0]))

    if (!_.isEmpty(result.rows)) {
      const referencedLicenceId = result.rows[0].licence_id_consultant
      const GET_CONSULTANT = 'SELECT * FROM consultants WHERE licence_id_consultant = $1';
      const consultantResult = await sails.sendNativeQuery(GET_CONSULTANT, [referencedLicenceId]);
      // sails.log("Consultant result row is not empty" + consultantResult.rows)
      if (!_.isEmpty(consultantResult.rows)) {
        const assigned_consultant = _.pick(consultantResult.rows[0],
          ['first_name', 'last_name', 'licence_id_consultant'])
        // sails.log("returning true" + JSON.stringify(assigned_consultant));

        return exits.success({
          error: false,
          assigned_consultant: assigned_consultant,
          is_assigned_consultant_available: true
        });
      }

    }

    sails.log("returning false");
    return exits.success({
      error: false,
      assigned_consultant: null,
      is_assigned_consultant_available: false

    });
  }


};
