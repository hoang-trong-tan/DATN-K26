"use strict";

const userModel = require("../model/user.model");
const { BadRequestError } = require("../core/error.response");
const bcrypt = require("bcrypt");
const crypto = require("crypto");
const { createTokenPair } = require("../auth/authUtils");
const RoleUser = {
  STUDENT: "student",
  TEACHER: "teacher",
  ADMIN: "admin",
};

// Đăng Kí Tài Khoảng người dùng
const signUp = async ({ name, email, password }) => {
  /**
   * 1- Kiem tra email da ton tai hay chua
   * 2-Ma hoa password
   * 3-Tao tai khoan user
   * 4-kiem tra tai khoan da duoc tao thanh cong hay chua
   * 5-Neu thanh cong thi tao 2 privateKey dung de de sign refeshtoken to va publicKey sign cho accesstoken
   * 6- tao token
   */

  const isEmailExist = await userModel.findOne({ email });

  if (isEmailExist) {
    throw new BadRequestError("User Is Already Registered");
  }

  //const passwordHash = await bcrypt.hash(password, 10);

  //   const newUser = await userModel.create({
  //     name,
  //     email,
  //     password: passwordHash,
  //     role: RoleUser.STUDENT,
  //   });

  if (!newUser) {
    throw new BadRequestError("Registered Is Fail");
  }

  const publicKey = crypto.randomBytes(64).toString("hex");
  const privateKey = crypto.randomBytes(64).toString("hex");

  const tokens = await createTokenPair(
    { userId: newUser._id, email },
    publicKey,
    privateKey
  );

  const otpCode = tokens.otpCode;

  const data = { name: newUser.name, otpCode };
};
