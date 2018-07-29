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

    let licenseId = null;
    if (referringDoctor.role === "consultant") {
      licenseId = referral.licenseIdConsultant
    } else {
      licenseId = referral.licenseIdGP
    }

    sails.log("Successfully captured variables")

    // ===================== INSERT NEW CASE RECORD ============
    const randomCaseId = Math.floor(Math.random() * (9999999 - 1000000) + 1000000);
    // # caseId, nric, licenceIdGP, createdAt, temperature(5), systole, diastole, bp, fullBloodCount, ptt(10), UECr,
    // liverFunctionTest, additionalInfo, assigned, assignedTime(15), licenceIdConsultant, appointmentTime
    const dateNormalizer = require('../../services/normalizeDate');
    const now = dateNormalizer.now();
    const INSERT_CASE_SQL = `
      INSERT INTO cases VALUES 
      ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17);
    `;


    try {
      const rawResult = await sails.sendNativeQuery(INSERT_CASE_SQL, [
        randomCaseId,
        patient.NRIC,
        licenseId,
        now,
        parameters.temperature,
        parameters.systole,
        parameters.diastole,
        parameters.BP,
        investigations.FBC,
        investigations.PTT,
        investigations.UECr,
        investigations.LFT,
        additionalInfo,
        false,
        now,
        null,
        now
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


      sails.log("successfully matched sings")
      // MATCH CASE TO GP
      const INSERT_CASE_GP = "INSERT INTO case_consultants VALUES ($1, $2)";
      const match = await sails.sendNativeQuery(INSERT_CASE_GP, [randomCaseId, licenseId]);

      sails.log("successfully matched GP")
      // MATCH CASE TO PATIENT

      const INSERT_CASE_PATIENT = "INSERT INTO case_patients VALUES ($1, $2)";
      const result = await sails.sendNativeQuery(INSERT_CASE_PATIENT, [randomCaseId, patient.NRIC]);

      sails.log("successfully matched Patient")
      sails.log("INSERT FINISHED WITH CASE ID, "  + randomCaseId);


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
