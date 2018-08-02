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

  async getAssociatedPushToken(identifier, role) {
    switch(role) {
      case "gp":

        const queryPushTokenGP = "SELECT expo_push_token from gps WHERE licence_id_gp = $1";
        const resultGP =  await sails.sendNativeQuery(queryPushTokenGP, [identifier]);
        return resultGP.rows[0].expo_push_token;

      case "consultant":
        const queryPushTokenConsultant = "SELECT expo_push_token from consultants WHERE licence_id_consultant = $1"
        const resultConsultant =   await sails.sendNativeQuery(queryPushTokenConsultant, [identifier]);
        return resultConsultant.rows[0].expo_push_token;

      case "patient":
        const queryPushTokenPatient = "SELECT expo_push_token from patients WHERE nric = $1"
        const resultPatient =   await sails.sendNativeQuery(queryPushTokenPatient, [identifier]);
        return resultPatient.rows[0].expo_push_token;
      default:
        throw new Error();
        return null
    }
  },

  pushNewNotification(message, to) {
    var payload = {
      ...defaultFormat,
      to: to,
      title: message.title,
      body: message.body,
      data: message.data,
    }



    var mergedConfig = {
      ...config,
      body: payload
    };
    function callback(error, response, body) {
      if (!error && response.statusCode === 200) {
      }
    }

    request(mergedConfig, callback);


  },

  async pushAllConsultants(message) {
      const query = 'SELECT expo_push_token FROM consultants';
      const queryResults = await sails.sendNativeQuery(query);

      const pushTokenRaw = queryResults.rows;
      const pushTokenArray = _.map(pushTokenRaw, 'expo_push_token')
      const cleanedPushTokenArray = _.compact(pushTokenArray)
      sails.log.info("Push token are " + JSON.stringify(cleanedPushTokenArray));
      this.batchPushNotifications(message, cleanedPushTokenArray);
  },

  batchPushNotifications(message, toList) {
    let messageList = []

    _.forEach(toList, function(sendTo) {
      const messageContent = {
        ...defaultFormat,
        to: sendTo,
        title: message.title,
        body: message.body,
        data: message.data,
      }

      messageList.push(messageContent)
    });

    var mergedConfig = {
      ...config,
      body: messageList
    }


    sails.log.info("PUSHES" + JSON.stringify(messageList, null, 2));
    function callback(error, response, body) {
      if (!error && response.statusCode === 200) {
        sails.log.info("Success")
      }
    }

    request(mergedConfig, callback);
  }
}

