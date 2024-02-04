"use strict";

const { NotFoundError } = require("../core/error.response");
const {
  course,
  courseData,
  courseDataVideo,
} = require("../model/course.model");
const { findOneCourseId } = require("../model/repositories/course.repo");

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

// lay ra mot khoa hoc

const findOneCourse = async (courseId) => {
  return await findOneCourseId(courseId);
};

module.exports = {
  createCourse,
  createCourseData,
  createCourseVideo,
  findOneCourse,
};
