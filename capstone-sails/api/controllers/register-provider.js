module.exports = {


  friendlyName: 'Register',


  description: 'Register gps. exactly the same as register consultants',


  inputs: {
    firstName: {
      description: "provider's first name",
      type: "string",
      required: true
    },
    lastName: {
      description: "provider's last name",
      type: 'string',
      required: true
    },
    organization: {
      description: "the organization the provider belongs to",
      type: 'string',
      required: true
    },
    isOverseas: {
      description: "is the organization an overseas organization?",
      type: 'boolean',
    },
    email: {
      description: "the provider's email address",
      isEmail: true
    },
    password: {
      description: "The password used to login",
      minLength: 8,
      type: "string",
      required: true,
    },
    contact: {
      description: "The provider's phone number",
      type: 'string',
      required: true
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

    // TODO insert if not exist into the temporary table
    // TODO the table is the one before manual validation

    // upon successful insert, return 200 OK
    return exits.success();

  }


};
