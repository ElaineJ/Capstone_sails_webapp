module.exports = {


  friendlyName: 'secondPost',


  description: 'Post referral.',


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
    // get params
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
    sails.log("INPUT RECEIVED AS" + JSON.stringify(inputs));
    // ===================== INSERT NEW CASE RECORD ============
    const randomCaseId = Math.random() * (9999999 - 1000000) + 1000000;
    // # caseId, nric, licenceIdGP, createdAt, temperature(5), systole, diastole, bp, fullBloodCount, ptt(10), UECr,
    // liverFunctionTest, additionalInfo, assigned, assignedTime(15), licenceIdConsultant, appointmentTime
    const now = Date.now();
    const INSERT_CASE_SQL = `
      INSERT INTO cases VALUES 
      ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17);
    `;
    caseId, nric, licenceIdGP, createdAt, temperature, systole, diastole, bp, fullBloodCount, ptt, UECr, liverFunctionTest, additionalInfo, assigned, assignedTime, licenceIdConsultant, appointmentTime

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
        null,
        null,
        null
      ])

        sails.log("successfully created case")
      // ======================= MATCH CASE TO SYMPTOM =============

      await Promise.all(symptoms.map( async (id) => {

        const INSERT_SYMPTOM = "INSERT INTO caseSymptom VALUES ($1, $2)";
        const result = await sails.sendNativeQuery(INSERT_SYMPTOM, [randomCaseId, id])
        sails.log("INSERT SYMPTOMS result" + result);
      }))


      sails.log("successfully matched symptoms")

      await Promise.all(signs.map( async (id) => {

        const INSERT_SIGN = "INSERT INTO caseSign VALUES ($1, $2)";
        const result = await sails.sendNativeQuery(INSERT_SIGN, [randomCaseId, id])
        sails.log("INSERT SIGNS result" + result);
      }));


      sails.log("successfully matched sings")
      // MATCH CASE TO GP
      const INSERT_CASE_GP = "INSERT INTO caseConsultant VALUES ($1, $2)";
      const match = await sails.sendNativeQuery(INSERT_CASE_GP, [randomCaseId, licenseId]);

      sails.log("successfully matched GP")
      // MATCH CASE TO PATIENT

      const INSERT_CASE_PATIENT = "INSERT INTO casePatient VALUES ($1, $2)";
      const result = await sails.sendNativeQuery(INSERT_CASE_PATIENT, [randomCaseId, patient.NRIC]);

      sails.log("successfully matched Patient")
      sails.log("INSERT FINISHED WITH CASE ID, "  + randomCaseId);


      return exits.success({
        error: false,
        caseId: randomCaseId
      })
    } catch (err) {
      sails.log("PRINTING ERROR: " , err)
      return exits.success({
        error: true,
        errorMessage: err
      })
    }




  }
}