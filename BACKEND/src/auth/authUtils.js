"use strict";

const JWT = require("jsonwebtoken");

// Tao Token
const createTokenPair = async ({ payload, publicKey, privateKey }) => {
  /**
   * 1- tao mot ma code otp ngau nhien
   * 2- tao token gom access va refresh
   * 3- tra ve token va ma otp
   */

  const otpCode = Math.floor(1000 + Math.random() * 9000).toString();

  const accessToken = JWT.sign(payload, publicKey, otpCode, {
    expiresIn: "2 days",
  });

  const refreshToken = JWT.sign(payload, privateKey, otpCode, {
    expiresIn: "7 days",
  });

  return { accessToken, refreshToken, otpCode };
};

module.exports = { createTokenPair };
