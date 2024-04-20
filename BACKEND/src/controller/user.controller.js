"use strict";
const { CreatedResponse, Ok } = require("../core/sucess.response");
const catchAsync = require("../helper/catchAsync");

const {
  processLearnUser,
  printInfoUser,
  updateProfileTeacher,
  printInfoTeacher,
  getAllCoursesByTeacher,
} = require("../service/user.service");

// cap nhat tien trinh hoc cu user
exports.updateProcessLearn = catchAsync(async (req, res, next) => {
  new Ok({
    message: "update process learn is sucess",
    data: await processLearnUser({
      userId: req.user.userId,
      courseId: req.params.id,
      process: req.body.process_Course,
    }),
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
exports.updateProfileTeacher = catchAsync(async (req, res, next) => {
  new Ok({
    message: "update is sucess",
    data: await updateProfileTeacher(req.user.userId, req.body),
  }).send(res);
});
