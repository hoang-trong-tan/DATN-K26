"use strict";

const { BadRequestError } = require("../../core/error.response");
const { REQUESTED_RANGE_NOT_SATISFIABLE } = require("../../util/statusCode");
const { course } = require("../course.model");
const userModel = require("../user.model");

const findByEmail = async (
  email,
  select = {
    user_email: 1,
    user_password: 2,
    user_name: 1,
    user_isBlocked: 1,
    user_role: 1,
  }
) => {
  return await userModel.findOne({ user_email: email }).select(select).lean();
};

const findOneUser = async (userId, select) => {
  return await userModel.findOne({ _id: userId }).select(select).lean();
};

const findOneTeacher = async (teacherId, select) => {
  const findTeacher = await userModel
    .findOne({ _id: teacherId })
    .select(select);

  if (!findTeacher.user_role.includes("teacher")) {
    throw new BadRequestError("User is not teacher");
  }

  const numberCourseByTeacher = await course
    .find({ user_teacher: teacherId })
    .lean();
  const totalStuent = numberCourseByTeacher.reduce(
    (total, student) => total + student.course_purchased,
    0
  );

  return {
    total_stuent: totalStuent,
    number_course: numberCourseByTeacher.length,
    findTeacher,
  };
};

const findAllCourseByTeacher = async ({ teacherId, limit, page, select }) => {
  const skip = (page - 1) * limit;
  return await course
    .find({ user_teacher: teacherId })
    .sort({ course_purchased: -1 })
    .populate("user_teacher", "user_name user_avatar")
    .skip(skip)
    .limit(limit)
    .select(select)
    .lean();
};

module.exports = {
  findByEmail,
  findOneUser,
  findOneTeacher,
  findAllCourseByTeacher,
};
