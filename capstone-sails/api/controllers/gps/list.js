module.exports = {


  friendlyName: 'list',


  description: 'list gps.',


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
    GPEmail: {
      description: 'a',
      type: 'string',
      required: true
    },
    licenceIdGP: {
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

        const { email, password, GPEmail, licenceIdGP } = inputs;
        //console.log(DOB)
        const GPS_GET = 'select * from gps WHERE email = \'' + email +'\' AND hashed_password = \''+ password + '\'' ;
        const rawGP = await sails.sendNativeQuery(GPS_GET);
        console.log(i);


        const GPS_CASES = 'call query_case()';
        const rawGPCases =  await sails.sendNativeQuery(GPS_CASES);


        //const GPS_QUERY_CASES = 'select * patients';

        const GPS_QUERY_CASES = ' select * from querycasetbl WHERE licenceIdGP=\'' + licenceIdGP + '\'AND GPEmail = \''+ GPEmail +' \''  ;

        const rawQueryGPCases = await sails.sendNativeQuery(GPS_QUERY_CASES);


        if (!_.isEmpty(rawQueryGPCases.rows)){
          return exits.success({
            gp_record: rawGPCases.rows,
            gp_cases: rawQueryGPCases.rows,
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
