module.exports = {


  friendlyName: 'list',


  description: 'list consultant.',


  inputs: {
    email: {
      description: 'The ID of the user to look up.',
      type: 'string',
      required: true
    },
    password: {
      description: 'a',
      type: 'string',
      required: true
    },
    consultantEmail: {
      description: 'a',
      type: 'string',
      required: true
    },
    licenceIdConsultant: {
      description: 'licenceID',
      type: 'string',
      required: true
    },

  },


  exits: {
    success: {

    },
    notFound: {
      description: 'No user with the specified ID was found in the database.',
      responseType: 'notFound'
    },
    timeOut: {
      description: 'Account locked for 30 mins, incorrect email or password.',
      responseType: 'notFound'
    },

  },


  fn: async function (inputs, exits) {


    for (var i = 0; i < 4; i += 1) {

      try{

        var _ =require('lodash');

        const { email, password, consultantEmail, licenceIdConsultant } = inputs;


        const CONSULTANTS_CASES = 'call query_cases()';
        const rawConsultantCases =  await sails.sendNativeQuery(CONSULTANTS_CASES);


        const CONSULTANT_QUERY_CASES = ' select * from temp_table_cases WHERE licence_id_consultant=\'' + licenceIdConsultant + '\'AND consultant_email = \''+ consultantEmail +' \''  ;

        const rawQueryConsultantCases = await sails.sendNativeQuery(CONSULTANT_QUERY_CASES);


        if (!_.isEmpty(rawQueryConsultantCases.rows)){
          return exits.success({
            gp_record: rawConsultantCases.rows,
            gp_cases: rawQueryConsultantCases.rows,
            status: '200 OK'
          })



        }
        return exits.success({
          status: '200 General Practitioner Not Found'
        });

      }
      catch(err){
        console.log(err);
        return exits.success();

      }


    }}



};
