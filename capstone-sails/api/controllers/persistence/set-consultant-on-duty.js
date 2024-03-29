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
    advice: {
      type: 'string'
    }
  },


  exits: {

  },


  fn: async function (inputs, exits) {
    const {
      license_id_consultant,
      push_token,
      advice
    } = inputs;

    const POST_QUERY = 'INSERT INTO persistence ' +
      '(persistence.is_consultant_on_duty, persistence.licence_id_consultant, persistence.expo_push_token)' +
      'values ($1, $2, $3)'

    const GET_QUERY = 'SELECT * FROM consultants WHERE licence_id_consultant = $1';
    const result = await sails.sendNativeQuery(POST_QUERY, [advice, license_id_consultant, push_token]);

    const returnResult = await sails.sendNativeQuery(GET_QUERY, [license_id_consultant]);
    const returnPayload = {
      is_consultant_on_duty: true,
      consultant_on_duty: returnResult.rows[0]
    }

    return exits.success({
      returnPayload,
      error: false,
    });

  }


};
