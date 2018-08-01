// var express = require('express');
// var router = express.Router();
// router.get('/',function (req,res,next){
//   res.render('index',{title:'HELLO'});
// });
//

module.exports = {


  friendlyName: 'View rankedcases',


  description: 'Display "Rankedcases" page.',


  // exits: {
  //   success: {
  //     // responseType: 'view',
  //     // viewTemplatePath: 'pages/scheduler/ranked-cases'
  //
  //   },
  //
  // },
  //
  //
  // fn: async function (inputs, exits) {
  //   //sails.log(inputs.NRIC, inputs.DOB)
  //
  //   var _ =require('lodash');
  //
  //   const PATIENTS_CASES = 'call query_cases()';
  //
  //
  //   const PATIENTS_QUERY_CASES = 'select * from temp_table_cases';
  //   const rawPatientCases =  await sails.sendNativeQuery(PATIENTS_CASES);
  //   const rawQueryPatientCases = await sails.sendNativeQuery(PATIENTS_QUERY_CASES);
  //
  //   //const patientRecord = rawPatients.rows;
  //   const queryPatientCaseRow = rawQueryPatientCases.rows;
  //
  //   sails.log(JSON.stringify(queryPatientCaseRow, null, 2));
  //   const output = [];
  //
  //   _.forEach(queryPatientCaseRow, function(fullCase) {
  //     const {
  //       case_id,
  //       temperature,
  //       systole,
  //       diastole,
  //       blood_pressure
  //     } = fullCase
  //
  //     const parameters = {
  //       Temperature: temperature,
  //       Systole: systole,
  //       Diastole: diastole,
  //       BP: blood_pressure
  //     }
  //
  //     const symptoms = fullCase.symptoms;
  //     const signs = fullCase.signs;
  //
  //     const {
  //       full_blood_count,
  //       ptt,
  //       uecr,
  //       liver_function_test
  //     } = fullCase;
  //
  //     const investigations = {
  //       full_blood_count,
  //       ptt,
  //       uecr,
  //       LFT: liver_function_test
  //     }
  //
  //     const additional_info = _.pick(fullCase, ["additional_info"])
  //
  //     // const referringDoctor = _.pick(fullCase, ['Name', 'GPClinic', 'LicenseIDGP', 'GPEmail', 'GPPhoneNumber'])
  //     const referringDoctor = {
  //       Name: "Dr. Dale Lincoln",
  //     }
  //     const caseListItem = {
  //       case_id,
  //       parameters,
  //       symptoms,
  //       signs,
  //       investigations,
  //       additional_info,
  //       referringDoctor,
  //       createdAt: "2018-06-6"
  //     };
  //     output.push(caseListItem);
  //   });
  //
  //   const payload = {
  //     history: output,
  //     status: '200 OK'
  //   };
  //
  //   if (!_.isEmpty(queryPatientCaseRow)){
  //     return exits.success({
  //         ... payload,
  //       error: false
  //     })
  //
  //   }
  //   return exits.success({
  //     error: true,
  //     errorMessage: '200 No cases found'
  //   });
  //
  //
  //
  //
  //
  //
  //
  // }


  exits: {

    success: {
      //viewTemplatePath: 'pages/scheduler/ranked-cases'
    }

  },


  fn: async function (inputs, exits) {


      try{

        var _ =require('lodash');

        // const { email, password, consultantEmail, licenceIdConsultant } = inputs;


        const CONSULTANTS_CASES = 'call query_appointments()';
        const rawConsultantCases =  await sails.sendNativeQuery(CONSULTANTS_CASES);


        const CONSULTANT_QUERY_CASES = ' select * from temp_table_appointments' ;

        const rawQueryConsultantCases = await sails.sendNativeQuery(CONSULTANT_QUERY_CASES);
        sails.log(rawQueryConsultantCases.rows);

        if (!_.isEmpty(rawQueryConsultantCases.rows)){
          return exits.success({
            //gp_record: rawConsultantCases.rows,
            cases: rawQueryConsultantCases.rows,
            status: '200 OK'
          })



        }
        return exits.success({
          status: '200 No records'
        });

      }
      catch(err){
        console.log(err);
        return exits.success();

      }


    }


};
