module.exports = {


  friendlyName: 'RegisterConsultant',


  description: 'Register a new consultant into the database.',


  inputs: {
    firstName: {
      description: "provider's first name",
      type: "string",
      // required: true
    },
    lastName: {
      description: "provider's last name",
      type: 'string',
      // required: true
    },
    organization: {
      description: "the organization the provider belongs to",
      type: 'string',
      // required: true
    },
    isOverseas: {
      description: "is the organization an overseas organization?",
      type: 'boolean',
    },
    email: {
      description: "the provider's email address",
      // isEmail: true
      type: 'string'
    },
    password: {
      description: "The password used to login",
      // minLength: 8,
      type: "string",
      // required: true,
    },
    contact: {
      description: "The provider's phone number",
      type: 'string',
      // required: true
    },
    role: {
      description: "GP or a consultant",
      type: 'string',
      isIn: ["GP", "Consultant"]
    },
    licenseNumber: {
      description: "The provider's medical license number",
      type: 'string',
    }
  },


  exits: {

  },


  fn: async function (inputs, exits) {
    const {
      firstName,
      lastName,
      organization,
      isOverseas,
      email,
      password,
      contact,
      role,
      licenseNumber
    } = inputs;
    const REGISTER_SQL = `
    INSERT INTO consultants 
             (consultants.licence_id_consultant, consultants.first_name, consultants.last_name, consultants.organisation, consultants.email, consultants.hashed_password, consultants.contact_number, consultants.scheduler)
    VALUES ( $1,          $2,        $3,       $4,          $5,     $6,       $7, $8);
    `

    try {
      const rawResult = await sails.sendNativeQuery(REGISTER_SQL, [licenseNumber, firstName, lastName, organization, email, password, contact, 1]);

      const random = Math.random() * (9999999 - 1000000) + 1000000
      sails.log("raw result = " + JSON.stringify(rawResult, null, 2))
      return exits.success({
        error: false,
        registrationId: random

      })
    } catch (err) {
      const errorcode = err.cause.raw.error.errno;
      return exits.success({
        error: true,
        errorMessage: "Server returned with error " + errorcode
      })
    }
  }
}
