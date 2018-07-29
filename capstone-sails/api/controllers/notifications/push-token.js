module.exports = {


  friendlyName: 'Push token',


  description: '',


  inputs: {
    identifier: {
      type: 'string'
    },
    role: {
      type: 'string'
    },
    token: {
      type: 'string'
    }
  },


  exits: {

  },


  fn: async function (inputs, exits) {
    sails.log(JSON.stringify(inputs, null, 2))
    const {identifier, role, token} = inputs;

    let tableName;
    let pKey;
    if (role === 'gp') {
      tableName = 'gps';
      pKey = 'license_id_gp';
    }
    else if (role === 'consultant') {
      tableName = 'consultants';
      pKey = 'license_id_consultant';
    }
    else if (role === 'patient') {
      tableName = 'patients';
      pKey = 'nric';
    }



    const INSERT_QUERY = 'UPDATE $1 SET expo_push_token=$2 WHERE $3=$4';
    sails.log.info("UPDATING TABLE " + tableName + '' + 'WHERE ' + pKey + "= " + identifier);
    sails.sendNativeQuery(
      INSERT_QUERY, [tableName, token, pKey, identifier]
    )
    return exits.success();

  }


};
