module.exports = {
  normalize(DOB) {
    const moment = require('moment');

    try {
      return moment(DOB).format('YYYY-MM-DD');
    } catch (error) {
      return 'error';
    }
  },
  now() {
    const moment = require('moment');
    return moment().format('YYYY-MM-DD HH:mm:ss');
  },
  offsetTZ(DateTime) {
    const moment = require('moment-timezone');
    const converted = moment.tz(DateTime, "Singapore").format('YYYY-MM-DD');
    return converted
  }
}
