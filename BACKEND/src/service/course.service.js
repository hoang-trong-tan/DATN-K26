"use strict";

const { find } = require("lodash");
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
  findOneCourse,
  findAllCourseType,
  findAllCourses,
  queryCourseByType,
  search,
  findAllTeacher,
  findAllCoursesWithCart,
  queryCourseByTypeWithCart,
} = require("../model/repositories/course.repo");
const userModel = require("../model/user.model");
const { checkUserReview } = require("./feedback.service");
const { printDetailProcessUserCourse } = require("./user.service");

const createCourse = async (payload, teacherId) => {
  const existingType = await courseType.findOne({ _id: payload.course_type });

  if (!existingType) {
    throw new NotFoundError("Not Found Course Type!!");
  }

  const newCourse = await course.create({
    ...payload,
    user_teacher: teacherId,
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
const getCoursePurchased = async (courseId, userId) => {
  let fieldsToExclude = [
    "courseDataShema",
    "courseShema",
    "courseData",
    "video_url",
    "__v",
    "createdAt",
    "updatedAt",
  ];

  const isUserReview = await checkUserReview(userId, courseId);

  const findUser = await userModel.findOne({ _id: userId });

  const existCourse = findUser.user_course.find(
    (course) => course._id.toString() === courseId
  );

  const videosSeen = await printDetailProcessUserCourse(userId, courseId);

  const videoIdsSeen = videosSeen.map((item) =>
    item.video_shema._id.toString()
  );

  if (!existCourse) {
    return await findOneCourse(courseId, fieldsToExclude, videoIdsSeen);
  }

  fieldsToExclude = fieldsToExclude.filter((field) => field !== "video_url");

  const course = await findOneCourse(courseId, fieldsToExclude, videoIdsSeen);

  return {
    is_user_review: isUserReview,
    ...course,
  };
};

const getOneCourse = async (courseId) => {
  return await findOneCourse(courseId, [
    "courseDataShema",
    "courseShema",
    "courseData",
    "video_url",
    "__v",
    "createdAt",
    "updatedAt",
  ]);
};

// lay ra toan bo khoa hoc
const getAllCourses = async ({ limit, page, userId }) => {
  let courses;

  const select = [
    "course_name",
    "course_thumnail",
    "course_price",
    "course_ratingsAverage",
    "course_slug",
    "course_purchased",
  ];

  if (userId) {
    courses = await findAllCoursesWithCart({ limit, page, select, userId });
  } else {
    courses = await findAllCourses({ limit, page, select });
  }

  return courses;
};

// lay ra khoa hoc theo danh muc loai
const getCourseByType = async ({ limit, page, courseTypeId, userId }) => {
  let courses;
  const select = [
    "course_name",
    "course_thumnail",
    "course_price",
    "course_ratingsAverage",
    "course_slug",
  ];
  if (userId) {
    courses = await queryCourseByTypeWithCart({
      limit,
      page,
      courseTypeId,
      select,
      userId,
    });
  } else {
    courses = await queryCourseByType({
      limit,
      page,
      courseTypeId,
      select,
    });
  }

  return courses;
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
      "user_name",
      "user_avatar",
    ],
  });
};

const printAllTeacher = async (limit, page) => {
  return await findAllTeacher({
    select: ["user_name", "user_avatar"],
    page,
    limit,
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
  printAllTeacher,
};
