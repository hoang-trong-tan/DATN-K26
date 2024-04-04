"use strict";

const userModel = require("../model/user.model");
const { BadRequestError, AuthFailureError } = require("../core/error.response");
const bcrypt = require("bcrypt");
const ejs = require("ejs");
const path = require("path");
const { findByEmail } = require("../model/repositories/user.repo");
const { createTokenOtp, createTokenPair } = require("../auth/authUtils");
const sendMail = require("../util/sendMail");
const JWT = require("jsonwebtoken");
const { getinFoData } = require("../util");
const RoleUser = {
  STUDENT: "student",
  TEACHER: "teacher",
  ADMIN: "admin",
};

// Đăng Kí Tài Khoảng người dùng
const signUp = async ({ name, email, password }) => {
  /**
   * 1- Kiem tra email da ton tai hay chua
   * 2- tao mot cai publickey
   * 3-Tao mot token de kich hoat
   * 4- tra ve mot token de duoc kich hoat
   * 5- nguoi dung check mail de xem ma otp
   */

  const isEmailExist = await findByEmail(email);
  if (isEmailExist) {
    throw new BadRequestError("User Is Already Registered");
  }
  const payload = { name, email, password };

  const token = await createTokenOtp(payload);

  const otpCode = token.otpCode;

  const data = { name, otpCode };

  await ejs.renderFile(
    path.join(__dirname, "../mails/activation-mail.ejs"),
    data
  );

  try {
    await sendMail({
      email: payload.email,
      subject: "Activate your account",
      template: "activation-mail.ejs",
      data,
    });
  } catch (error) {
    console.error("Goi mail that bai::", error);
  }

  return { activationToken: token.activationToken };
};

// Kích hoạt tài khoản user
const activateUser = async (payload) => {
  const { activationToken, otpCode } = payload;
  const decodeUser = await JWT.verify(activationToken, process.env.PUBLICKEY);

  if (decodeUser.otpCode !== otpCode) {
    throw new BadRequestError("Invalid activation code");
  }

  const { name, email, password } = decodeUser.payload;

  const passwordHash = await bcrypt.hash(password, 10);

  const newUser = await userModel.create({
    user_name: name,
    user_email: email,
    user_password: passwordHash,
    user_role: RoleUser.STUDENT,
  });

  return getinFoData(["_id", "user_name", "user_email"], newUser);
};

// Đăng Nhập
const login = async (payload) => {
  /**
   * 1 - kiem tra su ton tai cua email
   * 2 - so sanh password cua req voi password cua database
   * 3 - tao mot accesstoken
   * 4 - tra du lieu
   */

  const { user_email, user_password } = payload;

  const foundUser = await findByEmail(user_email);

  if (!foundUser) {
    throw new BadRequestError("Email or Password are wrong");
  }

  const macthPassword = await bcrypt.compare(
    user_password,
    foundUser.user_password
  );

  if (!macthPassword) {
    throw new BadRequestError("Email or Password are wrong");
  }

  const { _id: userId } = foundUser;

  const userInFor = { userId, user_email };
  const token = await createTokenPair(userInFor);
  return {
    metaData: getinFoData(["_id", "user_name", "user_email"], foundUser),
    accessToken: token,
  };
};

module.exports = { signUp, activateUser, login };
