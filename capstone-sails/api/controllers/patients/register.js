module.exports = {


  friendlyName: 'Register new patient ',


  description: 'Register patient if not found in database',


  inputs: {
    NRIC: {
      type: 'string',
      required: true
    },
    firstName: {
      description: "patient's first name",
      type: 'string',
      required: true
    },

    lastName: {
      description: "patient's last name",
      type: 'string',
      required: true
    },
    DOB: {
      type: 'string',
      required: true
    },
    gender: {
      description: "Male or Female",
      type: 'string',
      isIn: ['M', 'F']
    },
    drugAllergies: {
      description: "JSON collection object of Drug allergies",
      type: "JSON"
    },
    medicalHistories: {
      description: "JSON collection object of medical histories",
      type: "JSON"
    },
    isOverseas: {
      type: 'boolean'
    }
  },


  exits: {

  },


  fn: async function (inputs, exits) {
    const {
      NRIC,
      firstName,
      lastName,
      gender,
      drugAllergies,
      medicalHistories,

    } = inputs;
    const isOverseas = inputs.isOverseas ? "Yes" : "No";
    const dateNormalizer = require('../../services/normalizeDate');
    const DOB = dateNormalizer.normalize(inputs.DOB);
    const INSERT_PATIENT_QUERY = `
    INSERT INTO patients 
    (patients.nric, patients.first_name, patients.last_name, patients.dob, patients.allergy, patients.medical_history,
    patients.gender, patients.is_overseas, patients.expo_push_token)
    VALUES 
    ($1, $2, $3, $4, $5, $6, $7, $8, $9)
    `
    const queryResults = await sails.sendNativeQuery(INSERT_PATIENT_QUERY, [
      NRIC, firstName, lastName, DOB, drugAllergies, medicalHistories, gender, isOverseas, null
    ]);

    if (queryResults) {
      const patientData = {
        nric: NRIC,
        first_name: firstName,
        last_name: lastName,
        dob: DOB,
        allergy: drugAllergies,
        medical_history: medicalHistories,
        gender: gender,
      };
      sails.log(JSON.stringify(patientData))
      return exits.success({
        error: false,
        status: "200 inserted successfully",
        patientData: patientData
      })
    }


    return exits.success({
      errorMessage: "200 failed to insert",
      error: true,

    });
  }
};
