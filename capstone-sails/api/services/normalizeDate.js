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
  }
}
