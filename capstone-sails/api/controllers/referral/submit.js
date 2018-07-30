module.exports = {


  friendlyName: 'InsertNew',


  description: 'Insert new referral into the database.',


  inputs: {
    patient: {
      type: 'JSON'
    },
    referral: {
      type: 'JSON'
    }
  },


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
    if (role === "consultant") {
      licenceId = referringDoctor.licence_id_consultant
    } else {
      licenceId = referringDoctor.licence_id_gp
    }

    sails.log("Successfully captured variables")

    // ===================== INSERT NEW CASE RECORD ============
    const randomCaseId = Math.floor(Math.random() * (9999999 - 1000000) + 1000000);

    // case_id, nric, licence_id_gp, created_at, temperature, systole, diastole, heart_rate, full_blood_count, ptt, uecr, liver_function_test, photo, pdf,
    // additional_info, assigned, assigned_time, licence_id_consultant, appointment_time
    const dateNormalizer = require('../../services/normalizeDate');
    const now = dateNormalizer.now();
    const INSERT_CASE_SQL = `
      INSERT INTO cases VALUES 
      ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19);
    `;
    sails.log("investigations PTT = " + investigations.PTT,)

    try {
      const rawResult = await sails.sendNativeQuery(INSERT_CASE_SQL, [
        randomCaseId,                                            // case_id
        patient.NRIC,                                            // nric
        role === 'consultant' ? null : licenceId,                // licence_id_gp
        now,                                                     // created_at
        parameters.temperature,                                  // temperature
        parameters.systole,                                      // systole
        parameters.diastole,                                     // diastole
        parameters.HR,                                           // heart_rate
        investigations.FBC,                                      // full_blood_count
        investigations.PTT,                                      // ptt
        investigations.UECr,                                     // uercr
        investigations.LFT,                                      // liver_function_test
        null,                                                    // photo
        null,                                                    // pdf
        additionalInfo,                                          // additional_info
        false,                                                   // assigned
        now,                                                     // asigned_time
        role === 'consultant' ? licenceId : null,                // licence_id_consultant
        now                                                      // appointment_time
      ])

      sails.log("successfully created case" + JSON.stringify(rawResult))
      // ======================= MATCH CASE TO SYMPTOM =============

      await Promise.all(symptoms.map( async (id) => {

        const INSERT_SYMPTOM = "INSERT INTO case_symptoms VALUES ($1, $2)";
        const result = await sails.sendNativeQuery(INSERT_SYMPTOM, [randomCaseId, id])
        sails.log("INSERT SYMPTOMS result" + JSON.stringify(result));
      }))


      sails.log("successfully matched symptoms")

      await Promise.all(signs.map( async (id) => {

        const INSERT_SIGN = "INSERT INTO case_signs VALUES ($1, $2)";
        const result = await sails.sendNativeQuery(INSERT_SIGN, [randomCaseId, id])
        sails.log("INSERT SIGNS result" + JSON.stringify(result));
      }));


      sails.log("successfully matched signs")

      if (role === "consultant") {
        // MATCH CASE TO CONSULTANTS
        const INSERT_CASE_CONSULTANT = "INSERT INTO case_consultants VALUES ($1, $2)";
        const match = await sails.sendNativeQuery(INSERT_CASE_CONSULTANT, [randomCaseId, licenceId]);

        sails.log("successfully matched GP")
      } else if (role === "gp") {
        // MATCH CASE TO GP
        const INSERT_CASE_GP = "INSERT INTO case_gps VALUES ($1, $2)";
        const match = await sails.sendNativeQuery(INSERT_CASE_GP, [randomCaseId, licenceId]);

        sails.log("successfully matched GP")
      } else {
        throw new Error();
      }

      // MATCH CASE TO PATIENT

      const INSERT_CASE_PATIENT = "INSERT INTO case_patients VALUES ($1, $2)";
      const result = await sails.sendNativeQuery(INSERT_CASE_PATIENT, [randomCaseId, patient.NRIC]);

      sails.log("successfully matched Patient")
      sails.log("INSERT FINISHED WITH CASE ID, "  + randomCaseId);

      const notificationPusher = require("../../services/pushNotification");
      const pushToken = await notificationPusher.getAssociatedPushToken(licenceId, role)
      const message = {
        title: "A new referral",
        body: "Click to View",
      }
      notificationPusher.pushNewNotification(message, pushToken);

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
