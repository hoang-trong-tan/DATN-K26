"use strict";
const { CreatedResponse, Ok } = require("../core/sucess.response");
const catchAsync = require("../helper/catchAsync");
const {
  createCourse,
  createCourseData,
  createCourseVideo,
  createCourseType,
  findOneCourse,
  getCourseType,
} = require("../service/course.service");

// tao khoa hoc
exports.createCourse = catchAsync(async (req, res, next) => {
  new CreatedResponse({
    message: "Create new course success",
    data: await createCourse(req.body),
  }).send(res);
});

// tao noi dung khoa học
exports.createCourseData = catchAsync(async (req, res, next) => {
  new CreatedResponse({
    message: "create course data success",
    data: await createCourseData(req.params.id, req.body),
  }).send(res);
});

// tao video khoa hoc
exports.createCourseVideo = catchAsync(async (req, res, next) => {
  new CreatedResponse({
    message: "create course video success",
    data: await createCourseVideo(req.params.id, req.body),
  }).send(res);
});

// tao the loai khoa hoc
exports.createCourseType = catchAsync(async (req, res, next) => {
  new CreatedResponse({
    message: "create course type success",
    data: await createCourseType(req.body),
  }).send(res);
});

// lay ra mot khoa hoc theo id
exports.findOneCourse = catchAsync(async (req, res, next) => {
  new Ok({
    message: "find course is sucess",
    data: await findOneCourse(req.params.id),
  }).send(res);
});

// lay ra toan bo the loai
exports.findAllCourseType = catchAsync(async (req, res, next) => {
  new Ok({
    message: "find course type is sucess",
    data: await getCourseType(),
  }).send(res);
});
