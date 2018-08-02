module.exports = {


  friendlyName: 'Push notification',


  description: '',


  inputs: {
    nric: {
      type: 'string'
    },
    title: {
      type: "string"
    },
    body: {
      type: 'string'
    },
  case_id: {
    type: 'string'
  }
  },

  exits: {

  },


  fn: async function (inputs, exits) {
    const { nric } = inputs;
    const title = inputs.title ? inputs.title : "A new notification"
    const body = inputs.body ? inputs.body : "";

    const message = {
      title: title,
        body: body
    };

    const notificationPusher = require("../../services/pushNotification");
    notificationPusher.pushAllConsultants(message);

    return exits.success();

  }


};
