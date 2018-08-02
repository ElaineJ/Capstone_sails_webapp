module.exports = {
  async sendEmail(to) {
    // old credentials
    //var api_key = '3e9a4ace00f9fe15d93feb40f93974b1-3b1f59cf-0a254f7b';
    //var DOMAIN = 'sandbox2f2fbd8bd1ce44989f20b455e3150168.mailgun.org';


    const api_key = '83397d004e8f8fb353bf5c1abdbca5ce-a5d1a068-c31c921f';
    const DOMAIN = 'sandboxecd47c1f14ef43b383a7cb0457962451.mailgun.org';
    var mailgun = require('mailgun-js')({apiKey: api_key, domain: DOMAIN});

    var data = {
      from: 'Excited User <me@samples.mailgun.org>',
      to: to,
      subject: 'Hello',
      text: 'Testing some Mailgun awesomness!'
    };

    mailgun.messages().send(data, function (error, body) {
      console.log(body);
    });
  }
}
