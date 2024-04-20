"use strict";

const { BadRequestError } = require("../core/error.response");
const { course } = require("../model/course.model");
const {
  findOneUser,
  findOneTeacher,
  findAllCourseByTeacher,
} = require("../model/repositories/user.repo");
const userModel = require("../model/user.model");

const processLearnUser = async ({ userId, courseId, process }) => {
  const isUser = await userModel.findById(userId);
  const isCourse = await course.findById(courseId);
  if (!isUser) {
    throw new BadRequestError("User is not exits");
  }

  if (!isCourse) {
    throw new BadRequestError("Course is not exits");
  }

  // tim cai vi tri cua khoa hoc trong truong user_course
  const userCourseIndex = isUser.user_course.findIndex(
    (course) => course._id.toString() === courseId
  );

  if (userCourseIndex === -1) {
    throw new BadRequestError("Course is not Purchased");
  }

  isUser.user_course[userCourseIndex].process_Course = process;

  await isUser.save();

  return isUser;
};
// xem thông user
const printInfoUser = async (userId) => {
  return await findOneUser(userId, [
    "user_name",
    "user_email",
    "user_avatar",
    "user_role",
    "user_experience",
    "user_about",
  ]);
};

// update thông tin giảng viên

const updateProfileTeacher = async (userId, payload) => {
  return await userModel.findOneAndUpdate({ _id: userId }, payload, {
    new: true,
  });
};

// tìm lấy ra thông tin giảng viên theo id

const printInfoTeacher = async (teacherId) => {
  return await findOneTeacher(teacherId, [
    "user_name",
    "user_name",
    "user_name",
    "user_experience",
    "user_about",
    "user_role",
    "user_avatar",
  ]);
};

const getAllCoursesByTeacher = async ({ teacherId, limit, page }) => {
  return await findAllCourseByTeacher({
    teacherId,
    limit,
    page,
    select: ["course_name", "course_thumnail", "course_price", "user_teacher"],
  });
};

module.exports = {
  processLearnUser,
  printInfoUser,
  updateProfileTeacher,
  printInfoTeacher,
  getAllCoursesByTeacher,
};
