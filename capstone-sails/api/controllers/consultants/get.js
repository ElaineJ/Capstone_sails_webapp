module.exports = {


  friendlyName: 'Get',


  description: 'Get consultants.',


  inputs: {

  },


  exits: {

  },


  fn: async function (inputs, exits) {

    try{


      var CONSULTANTS_GET = 'select * from consultants'
      var rawConsultants = await sails.sendNativeQuery(CONSULTANTS_GET);


      return exits.success(rawConsultants.rows);
    }
    catch(err){
      console.log(err);
      return exits.success();
    }

  }


};
