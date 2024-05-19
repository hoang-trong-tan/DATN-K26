"use strict";

const { BadRequestError, NotFoundError } = require("../core/error.response");
const { course } = require("../model/course.model");
const orderModel = require("../model/order.model");
const userModel = require("../model/user.model");
const ejs = require("ejs");
const path = require("path");
const sendMail = require("../util/sendMail");
const { sortObject, cutString } = require("../util/index");
const moment = require("moment");
let querystring = require("qs");

var crypto = require("crypto");
const notificationModel = require("../model/notification.model");

const newOrder = async (data) => {
  const order = await orderModel.create(data);
  return order;
};

const createOder = async ({ courseId, userId, deliveryCode }) => {
  const user = await userModel.findById(userId);

  const existCourse = await course.findById(courseId).populate("user_teacher");

  if (!existCourse) {
    throw new NotFoundError("Course not found");
  }

  const data = {
    courseId: existCourse._id,
    userId: user._id,
    payment_info: deliveryCode,
  };

  const mailData = {
    order: {
      _id: existCourse._id.toString().slice(0, 6),
      name: existCourse.course_name,
      price: existCourse.course_price,
      date: new Date().toLocaleDateString("vi-VN", {
        day: "numeric",
        month: "long",
        year: "numeric",
      }),
    },
  };

  await ejs.renderFile(
    path.join(__dirname, "../mails/order-confirmation.ejs"),
    mailData
  );

  try {
    if (user) {
      await (0, sendMail)({
        email: user.user_email,
        subject: "Order Confirmation",
        template: "order-confirmation.ejs",
        data: mailData,
      });
    }
  } catch (error) {
    throw error;
  }

  user.user_course.push(existCourse._id);
  await user.save();

  const title = "ĐƠN HÀNG MỚI";
  const message = `Một người dùng có tên là ${user.user_name} vừa mua thành công khóa học ${existCourse.course_name} của bạn`;
  await notificationModel.create({
    title: title,
    message: message,
    userId: existCourse.user_teacher,
  });

  const userToken = existCourse.user_teacher.user_fcm_token;

  if (userToken) {
    await sendNotification(title, message, userToken);
  }

  existCourse.course_purchased = existCourse.course_purchased + 1;
  await existCourse.save();

  return await newOrder(data);
};

const createVnpay = async ({ ipAddr, courseId, userId }) => {
  const user = await userModel.findById(userId);

  const existCourseInUser = user.user_course.some(
    (course) => course._id.toString() === courseId
  );

  if (existCourseInUser) {
    throw new BadRequestError("You have already purchased this course");
  }

  const existCourse = await course.findById(courseId);

  if (!existCourse) {
    throw new NotFoundError("Course not found");
  }

  const checkTeacherId = userId === existCourse.user_teacher.toString();

  if (checkTeacherId) {
    throw new BadRequestError("Instructors cannot purchase their own courses");
  }

  process.env.TZ = "Asia/Ho_Chi_Minh";
  let date = new Date();
  let createDate = moment(date).format("YYYYMMDDHHmmss");

  let tmnCode = process.env.TMNCODE;
  let secretKey = process.env.SECRETKEY;
  let vnpUrl = process.env.VNPURL;
  let returnUrl = process.env.RETURNURL;
  let orderId = moment(date).format("DDHHmmss");

  let amount = await course.findOne({ _id: courseId });

  let currCode = "VND";
  let vnp_Params = {};
  vnp_Params["vnp_Version"] = "2.1.0";
  vnp_Params["vnp_Command"] = "pay";
  vnp_Params["vnp_TmnCode"] = tmnCode;
  vnp_Params["vnp_Locale"] = "vn";
  vnp_Params["vnp_CurrCode"] = currCode;
  vnp_Params["vnp_TxnRef"] = orderId;
  vnp_Params["vnp_OrderInfo"] = `${courseId} + ${userId}`;
  vnp_Params["vnp_OrderType"] = "orthe";
  vnp_Params["vnp_Amount"] = amount.course_price * 100;
  vnp_Params["vnp_ReturnUrl"] = returnUrl;
  vnp_Params["vnp_IpAddr"] = ipAddr;
  vnp_Params["vnp_CreateDate"] = createDate;

  vnp_Params = sortObject(vnp_Params);

  let signData = querystring.stringify(vnp_Params, { encode: false });
  let hmac = crypto.createHmac("sha512", secretKey);
  let signed = hmac.update(new Buffer(signData, "utf-8")).digest("hex");
  vnp_Params["vnp_SecureHash"] = signed;
  vnpUrl += "?" + querystring.stringify(vnp_Params, { encode: false });

  return vnpUrl;
};

const vnpayReturn = async (vnp_Params) => {
  let inforPayment = cutString(vnp_Params["vnp_OrderInfo"]);
  let secureHash = vnp_Params["vnp_SecureHash"];

  delete vnp_Params["vnp_SecureHash"];
  delete vnp_Params["vnp_SecureHashType"];

  vnp_Params = sortObject(vnp_Params);

  let secretKey = process.env.SECRETKEY;

  let signData = querystring.stringify(vnp_Params, { encode: false });

  let hmac = crypto.createHmac("sha512", secretKey);
  let signed = hmac.update(new Buffer(signData, "utf-8")).digest("hex");

  if (secureHash === signed) {
    if (vnp_Params["vnp_ResponseCode"] === "00") {
      return await createOder({
        courseId: inforPayment.courseId,
        userId: inforPayment.userId,
        deliveryCode: vnp_Params["vnp_TxnRef"],
      });
    } else {
      throw new BadRequestError("Payment is fail");
    }
  } else {
    return { code: "97" };
  }
};

module.exports = { createVnpay, vnpayReturn };
