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
      DOB,
      gender,
      drugAllergies,
      medicalHistories,

    } = inputs;
    sails.log("GENDER = " + gender)
    const isOverseas = inputs.isOverseas ? inputs.isOverseas :false;
    // nric, first_name, last_name, dob, allergy, medical_history, gender, is_overseas
    const INSERT_PATIENT_QUERY = `
    INSERT INTO patients 
    (patients.nric, patients.first_name, patients.last_name, patients.dob, patients.allergy, patients.medical_history,
    patients.gender, patients.is_overseas)
    VALUES 
    ($1, $2, $3, $4, $5, $6, $7, $8)
    `
    const queryResults = await sails.sendNativeQuery(INSERT_PATIENT_QUERY, [
      NRIC, firstName, lastName, DOB, drugAllergies, medicalHistories, gender, isOverseas
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
