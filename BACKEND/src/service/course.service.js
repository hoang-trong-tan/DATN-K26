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
} = require("../model/repositories/course.repo");

const createCourse = async (payload) => {
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
    courseShema_id: coureId,
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
    courseDataShema_id: coureId,
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
    "courseDataShema_id",
    "courseShema_id",
    "__v",
    "createdAt",
    "updatedAt",
  ]);
};

// lay ra toan bo danh muc

const getCourseType = async () => {
  return await findAllCourseType(["__v", "createdAt", "updatedAt"]);
};

module.exports = {
  createCourse,
  createCourseData,
  createCourseVideo,
  findOneCourse,
  createCourseType,
  getCourseType,
};
