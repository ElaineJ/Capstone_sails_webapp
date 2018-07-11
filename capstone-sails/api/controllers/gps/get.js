module.exports = {


  friendlyName: 'Get',


  description: 'Get gps.',


  inputs: {

  },


  exits: {

  },


  fn: async function (inputs, exits) {

    try{

      var GPS_GET = 'select * from gps'
      var rawGPs = await sails.sendNativeQuery(GPS_GET);


      return exits.success(rawGPs.rows);
    }
    catch(err){
      console.log(err);
      return exits.success();
    }

  }


};
