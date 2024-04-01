"use strict";

const {
  NotFoundError,
  ConflictRequestError,
  BadRequestError,
} = require("../core/error.response");
const {
  course,
  courseData,
  courseDataVideo,
  courseType,
} = require("../model/course.model");
const {
  findOneCourseId,
  findAllCourseType,
  findAllCourses,
  queryCourseByType,
  search,
} = require("../model/repositories/course.repo");
const userModel = require("../model/user.model");

const { verifyJWT } = require("../auth/authUtils");

const createCourse = async (payload) => {
  const existingType = await courseType.findOne({ _id: payload.course_type });

  if (!existingType) {
    throw new NotFoundError("Not Found Course Type!!");
  }

  const newCourse = await course.create(payload);
  return newCourse;
};

// tao noi dung khoa hoc
const createCourseData = async (coureId, payload) => {
  const data = await course.findById(coureId);
  if (!data) {
    throw new NotFoundError("Not Found Data");
  }

  const newCourseData = await courseData.create({
    ...payload,
    courseShema: coureId,
  });

  return newCourseData;
};

// tao video khoa hoc
const createCourseVideo = async (coureId, payload) => {
  const data = await courseData.findById(coureId);
  if (!data) {
    throw new NotFoundError("Not Found Data");
  }

  const newCourseVideo = await courseDataVideo.create({
    ...payload,
    courseDataShema: coureId,
  });

  return newCourseVideo;
};

// tao the loai khoa học

const createCourseType = async (payload) => {
  const existingType = await courseType.findOne({
    type_name: payload.type_name,
  });

  if (existingType) {
    throw new ConflictRequestError("Type is Exist");
  }

  const data = await courseType.create(payload);

  if (!data) {
    throw new BadRequestError("Create course type is error!!");
  }
  return data;
};

// lay ra mot khoa hoc
const getCoursePurchased = async (courseId, userId) => {
  let fieldsToExclude = [
    "courseDataShema",
    "courseShema",
    "video_url",
    "__v",
    "createdAt",
    "updatedAt",
  ];

  const findUser = await userModel.findOne({ _id: userId });

  const existCourse = findUser.user_course.find(
    (course) => course._id.toString() === courseId
  );

  if (!existCourse) {
    return await findOneCourseId(courseId, fieldsToExclude);
  }

  fieldsToExclude = fieldsToExclude.filter((field) => field !== "video_url");

  return await findOneCourseId(courseId, fieldsToExclude);
};

const getOneCourse = async (courseId) => {
  return await findOneCourseId(courseId, [
    "courseDataShema",
    "courseShema",
    "video_url",
    "__v",
    "createdAt",
    "updatedAt",
  ]);
};

// lay ra toan bo khoa hoc
const getAllCourses = async ({ limit, sort = "ctime", page }) => {
  return await findAllCourses({
    limit,
    sort,
    page,
    select: [
      "course_name",
      "course_thumnail",
      "course_price",
      "course_ratingsAverage",
      "course_slug",
    ],
  });
};

// lay ra khoa hoc theo danh muc loai
const getCourseByType = async ({ limit, page, courseTypeId }) => {
  return await queryCourseByType({
    limit,
    page,
    courseTypeId,
    select: [
      "course_name",
      "course_thumnail",
      "course_price",
      "course_ratingsAverage",
      "course_slug",
    ],
  });
};

// lay ra toan bo danh muc
const getCourseType = async () => {
  return await findAllCourseType(["__v", "createdAt", "updatedAt"]);
};

// tim kiem khoa hoc

const getListSearchCourses = async ({ type, keySearch, limit, page }) => {
  return await search({
    type,
    keySearch,
    limit,
    page,
    select: [
      "course_name",
      "course_thumnail",
      "course_price",
      "course_ratingsAverage",
      "course_slug",
    ],
  });
};

module.exports = {
  createCourse,
  createCourseData,
  createCourseVideo,
  getCoursePurchased,
  createCourseType,
  getCourseType,
  getAllCourses,
  getCourseByType,
  getListSearchCourses,
  getOneCourse,
};
