module.exports = {


  friendlyName: 'Get',


  description: 'Get patients.',


  inputs: {

    // nric:{
    //   type: 'number',
    //   required: true,
    // }

  },


  exits: {
    // success: {
    //   responseType:'view'
    // },

  },


  fn: async function (inputs, exits) {

    try{
      // var PATIENTS_GET_SQL = 'call sp_pat_get()'
      // var patientstable = 'select * from patientstbl'
      //
      // var rawResults = await sails.sendNativeQuery(PATIENTS_GET_SQL);
      // var rawTable = await sails.sendNativeQuery(patientstable);
      // return exits.success(rawTable.rows);

      //
      // var CONSULTANTS_GET_SQL = 'call query_consultant()'
      //
      // var consultantstable = 'select * from queryconsultanttbl'
      //
      // var rawResults = await sails.sendNativeQuery(CONSULTANTS_GET_SQL);
      // var rawTable = await sails.sendNativeQuery(consultantstable);
      // return exits.success(rawTable.rows);

      var PATIENTS_GET = 'select * from patients'
      var rawPatients = await sails.sendNativeQuery(PATIENTS_GET);


      return exits.success(rawPatients.rows);
    }
    catch(err){
      console.log(err);
      return exits.success();
    }

  }


};
