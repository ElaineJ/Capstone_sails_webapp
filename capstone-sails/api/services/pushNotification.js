const defaultFormat= {
  priority: 'high',
    channelId: 'referral-notification',
}


const config= {
  url: 'https://exp.host/--/api/v2/push/send',
  method: 'POST',
  json: true,
  gzip: true,
  headers: {
    accept: 'application/json',
  },
}
const request = require('request');
module.exports = {



  pushNewNotification(message, to) {
    var payload = {
      ...defaultFormat,
      to: to,
      title: message.title,
      body: message.body,
    }



    var mergedConfig = {
      ...config,
      body: payload
    };

    console.log("CONTENTS = " + JSON.stringify(mergedConfig, null, 2));
    function callback(error, response, body) {
      if (!error && response.statusCode === 200) {
      }
    }

    request(mergedConfig, callback);


  },
  batchPushNotifications(message, [toList]) {
    let messageList = []

    _.forEach(toList, function(sendTo) {
      const messageContent = {
        ...defaultFormat,
        to: sendTo,
        title: message.title,
        body: message.body,
      }

      messageList.push(messageContent)
    })

    var mergedConfig = {
      ...config,
      body: messageList
    }

    function callback(error, response, body) {
      if (!error && response.statusCode === 200) {
      }
    }

    request(mergedConfig, callback);
  }
}

