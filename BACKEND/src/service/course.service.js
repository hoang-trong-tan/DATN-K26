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
const JWT = require("jsonwebtoken");

const createCourse = async (payload, courseTypeId) => {
  const existingType = await courseType.findOne({ _id: courseTypeId });

  if (!existingType) {
    throw new NotFoundError("Not Found Course Type!!");
  }

  const newCourse = await course.create({
    ...payload,
    courseTypeId: existingType._id,
  });
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
const getCoursePurchased = async (courseId, accessToken) => {
  let fieldsToExclude = [
    "courseDataShema",
    "courseShema",
    "video_url",
    "__v",
    "createdAt",
    "updatedAt",
  ];

  if (!accessToken) {
    return await findOneCourseId(courseId, fieldsToExclude);
  }

  const decodeUser = JWT.verify(accessToken, process.env.PUBLICKEY);

  const findUser = await userModel.findOne({ _id: decodeUser.userId });

  const existCourse = findUser.user_course.find(
    (course) => course._id.toString() === courseId
  );

  if (existCourse) {
    // Nếu không tìm thấy khóa học trong user_course, loại bỏ trường "video_url" và trả về kết quả
    fieldsToExclude = fieldsToExclude.filter((field) => field !== "video_url");
  }

  return await findOneCourseId(courseId, fieldsToExclude);
};

// lay ra toan bo khoa hoc
const getAllCourses = async ({ limit, sort = "ctime", page }) => {
  return await findAllCourses({
    limit,
    sort,
    //filter,
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
};
