"use strict";
const { CreatedResponse, Ok } = require("../core/sucess.response");
const catchAsync = require("../helper/catchAsync");
const {
  createOder,
  createVnpay,
  vnpayReturn,
} = require("../service/order.service");

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
      courseId: req.body.courseId,
      userId: req.params.id,
    }),
  }).send(res);
});

// tra ve thong tin giao dich
exports.vnpayReturn = catchAsync(async (req, res, next) => {
  const vnp_Params = req.query;
  // const x = await vnpayReturn(vnp_Params);
  // console.log("x::", x);
  new Ok({
    message: "payment is success",
    data: await vnpayReturn(vnp_Params),
  }).send(res);
});
