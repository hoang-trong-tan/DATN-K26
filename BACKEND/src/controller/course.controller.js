"use strict";
const { CreatedResponse, Ok } = require("../core/sucess.response");
const catchAsync = require("../helper/catchAsync");
const {
  createCourse,
  createCourseData,
  createCourseVideo,
  createCourseType,
  getCoursePurchased,
  getCourseType,
  getAllCourses,
  getCourseByType,
  getListSearchCourses,
  getOneCourse,
  printAllTeacher,
  printVideoById,
} = require("../service/course.service");

// tao khoa hoc
exports.createCourse = catchAsync(async (req, res, next) => {
  new CreatedResponse({
    message: "Create new course success",
    data: await createCourse(req.body, req.user.userId),
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

// xem chi tiet khoa hoc
exports.getOneCourse = catchAsync(async (req, res, next) => {
  new Ok({
    message: "find course is sucess",
    data: await getOneCourse(req.params.id),
  }).send(res);
});

// lay ra mot khoa hoc da mua
exports.getCoursePurchased = catchAsync(async (req, res, next) => {
  new Ok({
    message: "find course is sucess",
    data: await getCoursePurchased(req.params.id, req.user.userId),
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
    data: await getAllCourses({ ...req.query, userId: req.body.userId }),
  }).send(res);
});

// lay ra video theo id
exports.findOneVideo = catchAsync(async (req, res, next) => {
  new Ok({
    message: "find one video is sucess",
    data: await printVideoById(req.params.id),
  }).send(res);
});

// lay ra cac khoa hoc theo danh muc loai
exports.findCoursesByType = catchAsync(async (req, res, next) => {
  new Ok({
    message: "find courses by type is sucess",
    data: await getCourseByType({
      ...req.query,
      courseTypeId: req.params.id,
      userId: req.body.userId,
    }),
  }).send(res);
});

// tim kiem khoa hoc
exports.getListSearchCourses = catchAsync(async (req, res, next) => {
  new Ok({
    message: "Get List Search Course Success!!",
    data: await getListSearchCourses({
      type: req.query.type,
      keySearch: req.query.keySearch,
      ...req.query,
    }),
  }).send(res);
});

// in ra tat ca teacher
exports.printAllTeacher = catchAsync(async (req, res, next) => {
  const { limit, page } = req.query;
  new Ok({
    message: "print all teacher is sucess",
    data: await printAllTeacher(limit, page),
  }).send(res);
});
