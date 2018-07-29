module.exports = {


  friendlyName: 'Push notification',


  description: '',


  inputs: {

  },


  exits: {

  },


  fn: async function (inputs, exits) {

    const notificationPusher = require("../../services/pushNotification");


    return exits.success();

  }


};
