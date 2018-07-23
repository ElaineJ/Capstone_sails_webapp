module.exports = {
  normalize(DOB) {
    const moment = require('moment');

    try {
      return moment(DOB).format('YYYY-MM-DD');
    } catch (error) {
      return 'error';
    }
  }
}
