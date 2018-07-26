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
      isIn: ['male', 'female']
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
      DOB,
      gender,
      drugAllergies,
      medicalHistories,

    } = inputs;
    const isOverseas = input.isOverseas ? inputs.isOverseas :false;
    // nric, firstName, lastName, DOB, allergies, medicalHistory, gender, isOverseas
    const INSERT_PATIENT_QUERY = `
    INSERT INTO patients 
    (patients.nric, patients.first_name, patients.last_name, patients.dob, patients.allergy, patients.medical_history,
    patients.gender, patients.is_overseas)
    VALUES 
    ($1, $2, $3, $4, $5, $6, $7, $8)
    `
    const queryResults = await sails.sendNativeQuery(INSERT_PATIENT_QUERY, [
      NRIC, firstName, lastName, DOB, gender, drugAllergies, medicalHistories, isOverseas
    ]);


    if (queryResults) {
      const patientData = {
        nric: NRIC,
        first_name: firstName,
        last_name: lastName,
        gender: gender,
        dob: DOB
      };

      return exits.success({
        status: "200 inserted successfully",
        patientData: patientData
      })
    }


    return exits.success({
      status: "200 failed to insert"
    });

  }


};
