module.exports = {


  friendlyName: 'Update consultant on duty',


  description: '',


  inputs: {
    licence_id_consultant: {
      type: 'string'
    },
    push_token: {
      type: 'string'
    },
    status: {
      type: 'string'
    }
  },


  exits: {

  },


  fn: async function (inputs, exits) {
    const {
      licence_id_consultant,
      push_token,
      status
    } = inputs;
    sails.log.info("Licence" + licence_id_consultant);
    sails.log.info(push_token)
    sails.log.info(status)

    const POST_QUERY = 'INSERT INTO persistence ' +
      '(persistence.loggedTime, persistence.is_consultant_on_duty, persistence.licence_id_consultant, persistence.expo_push_token)' +
      'values ($1, $2, $3, $4)'

    const GET_QUERY = 'SELECT * FROM consultants WHERE licence_id_consultant = $1';
    const result = await sails.sendNativeQuery(POST_QUERY, [null, status, licence_id_consultant, push_token]);

    const returnResult = await sails.sendNativeQuery(GET_QUERY, [licence_id_consultant]);
    if (!_.isEmpty(returnResult.rows)) {
      return exits.success({
        is_consultant_on_duty: status,
        consultant_on_duty: returnResult.rows[0],
        error: false,
      });
    }
    return exits.success({
      is_consultant_on_duty: false,
      error: false,
    });



  }


};
