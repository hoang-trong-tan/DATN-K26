"use strict";

const { Types } = require("mongoose");
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
const { query } = require("express");

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
  const existingType = await courseType.findOne({ name: payload.type_name });

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
const findOneCourse = async (courseId) => {
  return await findOneCourseId(courseId, [
    "courseDataShema",
    "courseShema",
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

const getListSearchCourses = async (type, keySearch) => {
  return await search(type, keySearch);
};

module.exports = {
  createCourse,
  createCourseData,
  createCourseVideo,
  findOneCourse,
  createCourseType,
  getCourseType,
  getAllCourses,
  getCourseByType,
  getListSearchCourses,
};
