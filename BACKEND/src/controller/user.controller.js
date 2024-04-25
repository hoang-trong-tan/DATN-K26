"use strict";
const { CreatedResponse, Ok } = require("../core/sucess.response");
const catchAsync = require("../helper/catchAsync");

const {
  processLearnUser,
  printInfoUser,
  updateProfileUser,
  printInfoTeacher,
  getAllCoursesByTeacher,
  updatePassWord,
  printDetailProcessUserCourse,
  printPurchasedCourses,
} = require("../service/user.service");

// cap nhat tien trinh hoc cu user
exports.updateProcessLearn = catchAsync(async (req, res, next) => {
  new Ok({
    message: "update process learn is sucess",
    data: await processLearnUser({
      userId: req.user.userId,
      courseId: req.params.id,
      videoId: req.body.video_shema,
    }),
  }).send(res);
});

// hien tien do hoc cua student
exports.printDetailProcessUserCourse = catchAsync(async (req, res, next) => {
  new Ok({
    message: "print process learn is sucess",
    data: await printDetailProcessUserCourse(
      req.user.userId,
      req.query.courseId
    ),
  }).send(res);
});

// hien tien tat ca khoa hoc ma student da mua
exports.printPurchasedCourses = catchAsync(async (req, res, next) => {
  new Ok({
    message: "print purchased course is sucess",
    data: await printPurchasedCourses(req.user.userId),
  }).send(res);
});

// in ra thong tin user
exports.printUser = catchAsync(async (req, res, next) => {
  new Ok({
    message: "print user is sucess",
    data: await printInfoUser(req.user.userId),
  }).send(res);
});

// in ra thong tin teacher
exports.printInforTeacher = catchAsync(async (req, res, next) => {
  new Ok({
    message: "print teacher is sucess",
    data: await printInfoTeacher(req.params.id),
  }).send(res);
});

// in ra cac khoa theo teacher
exports.getAllCoursesTeacher = catchAsync(async (req, res, next) => {
  new Ok({
    message: "get full course is sucess",
    data: await getAllCoursesByTeacher({
      teacherId: req.params.id,
      ...req.query,
    }),
  }).send(res);
});

// update thông tin giang viên
exports.updateProfileUser = catchAsync(async (req, res, next) => {
  new Ok({
    message: "update is sucess",
    data: await updateProfileUser(req.user.userId, req.body),
  }).send(res);
});

// update mật khẩu user
exports.updatePassWordUser = catchAsync(async (req, res, next) => {
  new Ok({
    message: "update is sucess",
    data: await updatePassWord({
      oldPassWord: req.body.old_passWord,
      newPassWord: req.body.new_passWord,
      userId: req.user.userId,
    }),
  }).send(res);
});
