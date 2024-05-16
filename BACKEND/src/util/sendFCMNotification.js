"use strict";

const firebaseConfig = require("../config/config.firebase");

exports.sendNotification = async (title, message, userToken) => {
  const notification = {
    token: userToken,
    notification: {
      title: title,
      body: message,
    },
  };
  try {
    await firebaseConfig.messaging().send(notification);
  } catch (error) {
    throw new error();
  }
};
