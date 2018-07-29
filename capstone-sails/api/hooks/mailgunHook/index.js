module.exports = function mailgunHook(sails) {
  return {

    initialize: async function (done) {

      sails.log.info('Initializing hook... (`api/hooks/email`)');
      return done()
    },

      sendEmail: async function() {
        var api_key = '3b1f59cf-0a254f7b ';
        var DOMAIN = 'https://app.mailgun.com/app/domains/sandbox2f2fbd8bd1ce44989f20b455e3150168.mailgun.org';
        var mailgun = require('mailgun-js')({apiKey: api_key, domain: DOMAIN});

        var data = {
          from: 'Excited User <me@samples.mailgun.org>',
          to: 'jason.julian27sg@gmail.com, YOU@YOUR_DOMAIN_NAME',
          subject: 'Hello',
          text: 'Testing some Mailgun awesomness!'
        };

        mailgun.messages().send(data, function (error, body) {
          console.log(body);
        });
    }
  }

}
