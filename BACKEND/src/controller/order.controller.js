"use strict";
const { CreatedResponse, Ok } = require("../core/sucess.response");
const catchAsync = require("../helper/catchAsync");
const { createVnpay, vnpayReturn } = require("../service/order.service");

// tao payment vnpay
exports.createVNPAY = catchAsync(async (req, res, next) => {
  const ipAddr =
    req.headers["x-forwarded-for"] ||
    req.connection.remoteAddress ||
    req.socket.remoteAddress ||
    req.connection.socket.remoteAddress;

  new CreatedResponse({
    message: "Create vnpay is success",
    data: await createVnpay({
      ipAddr,
      courseId: req.params.id,
      userId: req.user.userId,
    }),
  }).send(res);
});

// tra ve thong tin giao dich
exports.vnpayReturn = catchAsync(async (req, res, next) => {
  const vnp_Params = req.query;

  new Ok({
    message: "payment is success",
    data: await vnpayReturn(vnp_Params),
  }).send(res);
});
