module.exports = {


  friendlyName: 'Get',


  description: 'Get patients.',


  inputs: {
    nric: {
      description: 'The ID of the user to look up.',
      type: 'string',
      required: true
    },
    DOB: {
      description: 'a',
      type: 'string',
      required: true
    }

    // nric:{
    //   type: 'number',
    //   required: true,
    // }

  },


  exits: {
    success: {

    },
    notFound: {
      description: 'No user with the specified ID was found in the database.',
      responseType: 'notFound'
    }

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


      const { nric, DOB } = inputs;

      var PATIENTS_GET = 'select * from patients WHERE nric = ' + nric +' AND DOB = '+ DOB + ';';
      var rawPatients = await sails.sendNativeQuery(PATIENTS_GET);


      return exits.success({list: rawPatients.rows});
    }
    catch(err){
      console.log(err);
      return exits.success();
    }

  }


};
