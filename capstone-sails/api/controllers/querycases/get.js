module.exports = {


  friendlyName: 'Get',


  description: 'Get querycases.',


  inputs: {

  },


  exits: {

  },


  fn: async function (inputs, exits) {

    try{

      var QUERYCASES_GET_SQL = 'call query_cases()'

      var querycasestable = 'select * from querycasestbl'

      var rawResults = await sails.sendNativeQuery(QUERYCASES_GET_SQL);
      var rawTable = await sails.sendNativeQuery(querycasestable);
      return exits.success(rawTable.rows);


    }
    catch(err){
      console.log(err);
      return exits.success();
    }

  }


};
