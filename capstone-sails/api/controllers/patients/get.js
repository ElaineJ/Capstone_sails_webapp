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
    },


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

      var _ =require('lodash');

      const { nric, DOB } = inputs;
      sails.log(nric, DOB);
      const PATIENTS_GET = 'select * from patients WHERE nric = \'' + nric +'\' AND DOB = \''+ DOB + '\'' ;
      const rawPatients = await sails.sendNativeQuery(PATIENTS_GET);

      const PATIENTS_CASES = 'call query_case()';
      const PATIENTS_QUERY_CASES = 'select * from querycasetbl WHERE nric=\'' + nric + '\'';
      const rawPatientCases =  await sails.sendNativeQuery(PATIENTS_CASES);
      //sails.log(rawPatientCases);
      const rawQueryPatientCases = await sails.sendNativeQuery(PATIENTS_QUERY_CASES);
      //sails.log(rawQueryPatientCases);

      sails.sendNativeQuery('DROP TABLE IF EXISTS querycasetbl');



      if (!_.isEmpty(rawPatients.rows)){
        return exits.success({
          patient_record: rawPatients.rows,
          patient_cases: rawQueryPatientCases.rows,
          status: '200 OK'
        })

      }
      return exits.success({
        status: '200 Patient Not Found'
      });





    }
    catch(err){
      //console.log(err);
      return exits.success();
    }

  }


};
