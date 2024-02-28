"use strict";

const JWT = require("jsonwebtoken");

// Tao Token OTP
const createTokenOtp = async (payload) => {
  /**
   * 1- tao mot ma code otp ngau nhien
   * 2- tao token gom access va refresh
   * 3- tra ve token va ma otp
   */

  try {
    const otpCode = Math.floor(1000 + Math.random() * 9000).toString();

    const activationToken = await JWT.sign(
      { payload, otpCode },
      process.env.PUBLICKEY,
      {
        expiresIn: "5m",
      }
    );

    return { activationToken, otpCode };
  } catch (error) {}
};

// Tao AccessToken
const createTokenPair = async (payload) => {
  try {
    const accessToken = await JWT.sign(payload, process.env.PUBLICKEY, {
      expiresIn: "3 days",
    });

    JWT.verify(accessToken, process.env.PUBLICKEY, (err, decode) => {
      if (err) {
        console.error("error verify::", err);
      } else {
        console.error("Verify decode::", decode);
      }
    });

    return accessToken;
  } catch (error) {}
};

module.exports = { createTokenOtp, createTokenPair };
