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
  getAllCourses,
  getCourseByType,
  getListSearchCourses,
} = require("../service/course.service");

// tao khoa hoc
exports.createCourse = catchAsync(async (req, res, next) => {
  new CreatedResponse({
    message: "Create new course success",
    data: await createCourse(req.body, req.body.course_type),
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

// lay ra toan bo khoa hoc
exports.findAllCourses = catchAsync(async (req, res, next) => {
  new Ok({
    message: "find courses is sucess",
    data: await getAllCourses(req.query),
  }).send(res);
});

// lay ra cac khoa hoc theo danh muc loai
exports.findCoursesByType = catchAsync(async (req, res, next) => {
  new Ok({
    message: "find courses by type is sucess",
    data: await getCourseByType({ ...req.query, courseTypeId: req.params.id }),
  }).send(res);
});

// tim kiem khoa hoc
exports.getListSearchCourses = catchAsync(async (req, res, next) => {
  console.log("type::", req.query.type);
  new Ok({
    message: "Get List Search Course Success!!",
    data: await getListSearchCourses(req.query.type, req.query.keySearch),
  }).send(res);
});
