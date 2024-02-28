"use strict";

const userModel = require("../user.model");

const findByEmail = async (
  email,
  select = {
    user_email: 1,
    user_password: 2,
    user_name: 1,
    user_isBlocked: 1,
    user_role: 1,
  }
) => {
  return await userModel.findOne({ user_email: email }).select(select).lean();
};

module.exports = { findByEmail };
