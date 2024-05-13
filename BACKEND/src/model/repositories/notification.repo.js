"use strict";
const notificationModel = require("../notification.model");

const getNotification = async ({ userId, select, type, page, limit }) => {
  let notifications;
  const skip = (page - 1) * limit;
  if (type !== undefined) {
    notifications = await notificationModel
      .find({ userId, status: type })
      .skip(skip)
      .limit(limit)
      .sort({ createdAt: -1 })
      .select(select)
      .lean();
  } else {
    notifications = await notificationModel
      .find({ userId })
      .skip(skip)
      .limit(limit)
      .sort({ createdAt: -1 })
      .select(select)
      .lean();
  }

  return { notifications, number_notification: notifications.length };
};

module.exports = { getNotification };
