"use strict";
const { CreatedResponse, Ok } = require("../core/sucess.response");
const catchAsync = require("../helper/catchAsync");
const {
  printNotification,
  updateNotification,
} = require("../service/notification.service");
// tra ve tat ca review
exports.getNotifications = catchAsync(async (req, res, next) => {
  new Ok({
    message: "get notification is sucess",
    data: await printNotification({
      userId: req.user.userId,
      type: req.query.type,
      ...req.query,
    }),
  }).send(res);
});

exports.updateNotification = catchAsync(async (req, res, next) => {
  new Ok({
    message: "update notification is sucess",
    data: await updateNotification(req.params.id, req.user.userId),
  }).send(res);
});
