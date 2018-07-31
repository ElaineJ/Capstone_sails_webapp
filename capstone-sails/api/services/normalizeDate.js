
const moment = require('moment');
const momentTZ = require('moment-timezone');

module.exports = {
  normalize(DOB) {

    try {
      return moment(DOB).format('YYYY-MM-DD');
    } catch (error) {
      return 'error';
    }
  },
  now() {
    return moment().format('YYYY-MM-DD HH:mm:ss');
  },
  offsetTZ(DateTime) {
    const converted = momentTZ.tz(DateTime, "Singapore").format('YYYY-MM-DD');
    return converted
  },

  normalizeDateTime(dateTime) {
    return moment(dateTime).format('DD-MMM-YYYY HH:mm:ss')
  }
}
