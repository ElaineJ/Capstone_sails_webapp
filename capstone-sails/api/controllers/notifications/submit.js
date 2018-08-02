module.exports = {


  friendlyName: 'InsertNew',


  description: 'Insert new notification into the database.',


  inputs: {
    patient: {
      type: 'JSON'
    },
    referral: {
      type: 'JSON'
    }
  },
///////// Queries
//   INSERT INTO case_notification VALUES(case_id, notification_id)
//   INSERT INTO notifications VALUES(notification_id,licence_id_consultant,selection, selection_sent)

  exits: {},


  fn: async function (inputs, exits) {

    // Do a verification check


    // get params
    sails.log("INPUT RECEIVED AS" + JSON.stringify(inputs, null, 2));
    const patient = inputs.patient;
    const referral = inputs.referral;
    const {
      parameters,
      symptoms,
      signs,
      investigations,
      additionalInfo,
      referringDoctor
    } = referral;

    let licenceId = null;
    let role = referringDoctor.role


    sails.log("Successfully captured variables")
    sails.log("Successfully captured parameters" + JSON.stringify(investigations, null, 2))

    // ===================== INSERT NEW CASE RECORD ============
    const randomNotificationId = Math.floor(Math.random() * (9999999 - 1000000) + 1000000);

    // case_id, nric, licence_id_gp, created_at, temperature, systole, diastole, heart_rate, full_blood_count, ptt, uecr, liver_function_test, photo, pdf,
    // additional_info, assigned, assigned_time, licence_id_consultant, appointment_time
    const dateNormalizer = require('../../services/normalizeDate');
    const now = dateNormalizer.now();
    const INSERT_CASE_SQL = `
      INSERT INTO cases VALUES 
      ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19);
    `;

    try {
      const rawResult = await sails.sendNativeQuery(INSERT_CASE_SQL, [
        randomCaseId,                                            // case_id
        patient.nric,                                            // nric
        role === 'consultant' ? null : licenceId,                // licence_id_gp
        now,                                                     // created_at
        parameters.temperature,                                  // temperature
        parameters.systole,                                      // systole
        parameters.diastole,                                     // diastole
        parameters.HR,                                           // heart_rate
        investigations.full_blood_count,                                      // full_blood_count
        investigations.ptt,                                      // ptt
        investigations.uecr,                                     // uercr
        investigations.liver_function_test,                                      // liver_function_test
        null,                                                    // photo
        null,                                                    // pdf
        additionalInfo,                                          // additional_info
        false,                                                   // assigned
        now,                                                     // assigned_time
        role === 'consultant' ? licenceId : null,                // licence_id_consultant
        null                                                      // appointment_time
      ])

      sails.log("successfully created case" + JSON.stringify(rawResult, null, 2));
      // ======================= MATCH CASE TO SYMPTOM =============

      const case_notification = await Promise.all(symptoms.map( async (id) => {

        const INSERT_SYMPTOM = "INSERT INTO case_symptoms VALUES ($1, $2)";
        sails.log("INSERTING SYMPTOM" + randomCaseId + id);
        const result = await sails.sendNativeQuery(INSERT_SYMPTOM, [randomCaseId, id])
        sails.log("INSERT SYMPTOMS result " + JSON.stringify(result));
      }))


      sails.log("successfully matched symptoms" + case_symptom)

      await Promise.all(signs.map( async (id) => {

        const INSERT_SIGN = "INSERT INTO case_signs VALUES ($1, $2)";
        sails.log("INSERTING SIGN " + randomCaseId + id);
        const result = await sails.sendNativeQuery(INSERT_SIGN, [randomCaseId, id])
        sails.log("INSERT SIGNS result " + JSON.stringify(result));
      }));


      sails.log("successfully matched signs")


      const notificationPusher = require("../../services/pushNotification");


      const pushToken = await notificationPusher.getAssociatedPushToken(licenceId, role)

      const message = {
        title: "A new referral",
        body: "Case ID " + randomCaseId,
        data: {
          case_id: randomCaseId
        }
      }


      return exits.success({
        error: false,
        caseId: randomCaseId
      })
    } catch (err) {
      sails.log("ERROR: ", JSON.stringify(err))
      return exits.success({
        error: true,
        errorMessage: err
      })
    }




  }
};
