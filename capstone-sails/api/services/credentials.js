'use strict';
const bcrypt = require('bcrypt');


module.exports = {

  hashPassword(password) {
    return new Promise((resolve, reject) => {
      bcrypt.genSalt(10, (genSaltErr, salt) => {
        if (genSaltErr) return reject(genSaltErr);

        bcrypt.hash(password, salt, (hashErr, hash) => {
          if (hashErr) return reject(hashErr);
          resolve(hash);
        });
      });
    });
  },

  comparePassword: function(userPassword, hash) {
    bcrypt.compare(userPassword, hash, function(err, res) {
      return res
    });
  }


};
