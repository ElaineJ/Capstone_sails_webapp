module.exports = {


  friendlyName: 'Post',


  description: 'Post test.',


  inputs: {

  },


  exits: {

  },


  fn: async function (inputs, exits) {
    console.log(inputs);
    return exits.success();

  }


};
