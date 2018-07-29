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



    const UPDATE_QUERY = "UPDATE " + tableName + " SET expo_push_token=$2 WHERE " + pKey + " = $4";
    const results = await sails.sendNativeQuery(
      UPDATE_QUERY, [tableName, token, pKey, identifier]
    )
    // const RAW_UPDATE = "UPDATE " + tableName + ' SET expo_push_token = \'' + token + '\' WHERE ' + pKey + '= \'' + identifier + '\'';
    // sails.log.info(RAW_UPDATE);
    // const rawesults = await sails.sendNativeQuery(
    //   RAW_UPDATE
    // )
    return exits.success();

  }


};
