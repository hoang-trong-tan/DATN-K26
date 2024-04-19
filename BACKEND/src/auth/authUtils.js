"use strict";

const JWT = require("jsonwebtoken");

const catchAsync = require("../helper/catchAsync");

const {
  AuthFailureError,
  NotFoundError,
  FobiddenError,
} = require("../core/error.response");
const userModel = require("../model/user.model");
const HEADER = {
  CLIENT_ID: "x-client-id",
  ACCESSTOKEN: "x-atoken-id",
};

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
  } catch (error) {
    throw error;
  }
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
  } catch (error) {
    throw error;
  }
};

const authentication = catchAsync(async (req, res, next) => {
  /**
   *  1 - Kiểm tra xem user có được truyền vào ko
   *  2 - Kiểm tra user có trong database
   *  3 - verify token
   *  4 - kiểm tra user truyền vào có giống với user khi verify thành công
   *  5 - ok tất cả thì next
   */

  //1
  const userId = req.headers[HEADER.CLIENT_ID];
  if (!userId) {
    throw new AuthFailureError("Invalid Request");
  }

  //2
  const checkUser = await userModel.findById(userId);

  if (!checkUser) {
    throw new NotFoundError("Not found user");
  }

  //3
  if (req.headers[HEADER.ACCESSTOKEN]) {
    try {
      const accessToken = req.headers[HEADER.ACCESSTOKEN];
      const decodeUser = await verifyJWT(accessToken, process.env.PUBLICKEY);
      // 4
      if (userId !== decodeUser.userId) {
        throw new AuthFailureError("Invalid UserId");
      }

      const findUser = await userModel.findById(decodeUser.userId);
      //5
      req.user = decodeUser;
      req.user.user_role = findUser.user_role;

      req.accessToken = accessToken;
      return next();
    } catch (error) {
      throw error;
    }
  }
});

const verifyJWT = async (token, publicKey) => {
  return await JWT.verify(token, publicKey);
};

const authorizeRoles = (...roles) => {
  return (req, res, next) => {
    if (!roles.includes(req.user.user_role || "")) {
      throw new FobiddenError(
        `Role: ${req.user.user_role} is not allowed to access this resource`
      );
    }
    next();
  };
};

module.exports = {
  createTokenOtp,
  createTokenPair,
  authentication,
  authorizeRoles,
};
