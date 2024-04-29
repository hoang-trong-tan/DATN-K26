"use strict";

const { BadRequestError } = require("../../core/error.response");
const { Types } = require("mongoose");
const { course, processLearn } = require("../course.model");
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
    .findOne({ _id: teacherId, user_role: "teacher" })
    .select(select);

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

const findDetailProcessUserCourse = async ({ userId, courseId, select }) => {
  return await processLearn
    .find({ user_shema: userId, course_shema: courseId })
    .populate("video_shema", "video_title")
    .select(select)
    .lean();
};

const getPurchasedCourses = async (userId) => {
  const user_info = "user_course._id";
  const user = await userModel
    .findOne({ _id: userId })
    .populate({
      path: user_info,
      model: "Course",
      select: "course_name course_thumnail user_teacher course_type",
      populate: [
        {
          path: "course_type",
          model: "CourseType",
          select: "type_name",
        },
        {
          path: "user_teacher",
          model: "User",
          select: "user_name user_avatar",
        },
      ],
    })
    .select("user_course");

  return user;
};

module.exports = {
  findByEmail,
  findOneUser,
  findOneTeacher,
  findAllCourseByTeacher,
  findDetailProcessUserCourse,
  getPurchasedCourses,
};
