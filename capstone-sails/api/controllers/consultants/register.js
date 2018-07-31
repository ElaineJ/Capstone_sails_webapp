module.exports = {


  friendlyName: 'RegisterConsultant',


  description: 'Register a new consultant into the database.',


  inputs: {
    first_name: {
      description: "provider's first name",
      type: "string",
      // required: true
    },
    last_name: {
      description: "provider's last name",
      type: 'string',
      // required: true
    },
    organisation: {
      description: "the organization the provider belongs to",
      type: 'string',
      // required: true
    },
    is_overseas: {
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
    contact_number: {
      description: "The provider's phone number",
      type: 'string',
      // required: true
    },
    role: {
      description: "GP or a consultant",
      type: 'string',
      isIn: ["gp", "consultant"]
    },
    licence_id: {
      description: "The provider's medical license number",
      type: 'string',
    }
  },


  exits: {

  },


  fn: async function (inputs, exits) {
    sails.log.info(inputs);
    const {
      licence_id,
      first_name,
      last_name,
      organisation,
      email,
      password,
      contact_number,
      isOverseas,
      role,

    } = inputs;
    // licence_id_consultant, first_name, last_name, organisation, email, hashed_password, contact_number, scheduler, expo_push_token

    const registration_id = Math.floor(Math.random() * (9999999 - 1000000) + 1000000);
    const REGISTER_SQL = `
    INSERT INTO consultants 
             (consultants.licence_id_consultant, consultants.first_name, consultants.last_name, consultants.organisation, consultants.email, consultants.hashed_password, 
             consultants.contact_number, consultants.scheduler, consultants.expo_push_token, consultants.is_verified, consultants.registration_id)
    VALUES ( $1,          $2,        $3,       $4,          $5,     $6,       $7, $8, $9, $10, $11);
    `

    try {
      const rawResult = await sails.sendNativeQuery(REGISTER_SQL, [licence_id, first_name, last_name, organisation, email, password, contact_number, 1, null, 0, registration_id]);

      sails.log("raw result = " + JSON.stringify(rawResult, null, 2))
      return exits.success({
        error: false,
        registration_id: registration_id

      })
    } catch (err) {
      const errorcode = err.cause.raw.error.errno;
      sails.log.error("ERRORL " + errorcode);
      return exits.success({
        error: true,
        errorMessage: "Server returned with error " + errorcode
      })
    }
  }
}
