"use strict";
const { CreatedResponse, Ok } = require("../core/sucess.response");
const catchAsync = require("../helper/catchAsync");

const { signUp, activateUser, login } = require("../service/access.service");

// tao tai khoan
exports.signUp = catchAsync(async (req, res, next) => {
  new CreatedResponse({
    message: `Please check your email: ${req.body.user_email} to activate your account!`,
    data: await signUp({
      ...req.body,
      name: req.body.user_name,
      email: req.body.user_email,
      password: req.body.user_password,
      role: req.body.user_role,
    }),
  }).send(res);
});

// kich hoat tai khoan
exports.activateUser = catchAsync(async (req, res, next) => {
  new CreatedResponse({
    message: `Activate your account is sucess!`,
    data: await activateUser(req.body),
  }).send(res);
});

// dang nhap tai khoan
exports.login = catchAsync(async (req, res, next) => {
  new CreatedResponse({
    message: `Login is sucess!`,
    data: await login(req.body),
  }).send(res);
});
