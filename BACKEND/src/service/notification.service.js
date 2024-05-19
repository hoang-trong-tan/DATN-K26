"use strict";

const { NotFoundError } = require("../core/error.response");
const notificationModel = require("../model/notification.model");
const { getNotification } = require("../model/repositories/notification.repo");

const printNotification = async ({ userId, type, page, limit }) => {
  return await getNotification({
    userId,
    select: ["title", "message", "status", "courseId", "videoId", "createdAt"],
    type,
    page,
    limit,
  });
};

const updateNotification = async (notificationId, userId) => {
  const notification = await notificationModel.findOne({
    _id: notificationId,
    userId,
  });
  if (!notification) {
    throw new NotFoundError("notification is exits");
  }
  notification.status = true;
  await notification.save();

  return notification;
};

module.exports = { printNotification, updateNotification };
