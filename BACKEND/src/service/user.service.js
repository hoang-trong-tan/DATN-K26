"use strict";

const { BadRequestError } = require("../core/error.response");
const {
  course,
  processLearn,
  courseData,
  courseDataVideo,
} = require("../model/course.model");
const {
  getCourseDataVideo,
  findOneCourseId,
} = require("../model/repositories/course.repo");
const {
  findOneUser,
  findOneTeacher,
  findAllCourseByTeacher,
  findDetailProcessUserCourse,
  getPurchasedCourses,
} = require("../model/repositories/user.repo");
const userModel = require("../model/user.model");
const bcrypt = require("bcrypt");

const processLearnUser = async ({ userId, courseId, videoId }) => {
  const newProcess = await processLearn.create({
    user_shema: userId,
    course_shema: courseId,
    video_shema: videoId,
  });

  const videosSeen = await printDetailProcessUserCourse(userId, courseId);
  const courses = await courseData.find({ courseShema: courseId });
  const courseIds = courses.map((item) => item._id);

  const videos = await courseDataVideo
    .find({
      courseDataShema: {
        $in: courseIds,
      },
    })
    .exec();

  await userModel.updateOne(
    {
      _id: userId,
      "user_course._id": courseId,
    },
    {
      $set: {
        "user_course.$.process_Course": videosSeen.length / videos.length,
      },
    }
  );

  return newProcess;
};

const printDetailProcessUserCourse = async (userId, courseId) => {
  return await findDetailProcessUserCourse({
    userId,
    courseId,
    select: ["video_shema"],
  });
};

const printPurchasedCourses = async (userId) => {
  return await getPurchasedCourses(userId);
};

// xem thông user
const printInfoUser = async (userId) => {
  return await findOneUser(userId, [
    "user_name",
    "user_experience",
    "user_about",
    "user_role",
    "user_avatar",
    "user_phone",
    "user_birthday",
    "user_university",
    "user_diploma",
    "user_course",
    "user_email",
  ]);
};

// update thông tin giảng viên
const updateProfileUser = async (userId, payload) => {
  return await userModel.findOneAndUpdate({ _id: userId }, payload, {
    new: true,
  });
};

// cập nhật password
const updatePassWord = async ({ oldPassWord, newPassWord, userId }) => {
  if (!oldPassWord || !newPassWord) {
    throw new BadRequestError("Please enter old and new password");
  }

  const user = await userModel.findById(userId);

  const isPassWord = await bcrypt.compare(oldPassWord, user.user_password);

  if (!isPassWord) {
    throw new BadRequestError("Invalid old password");
  }

  const passwordHash = await bcrypt.hash(newPassWord, 10);

  user.user_password = passwordHash;
  await user.save();
  return user;
};

// tìm lấy ra thông tin giảng viên theo id

const printInfoTeacher = async (teacherId) => {
  return await findOneTeacher(teacherId, [
    "user_name",
    "user_experience",
    "user_about",
    "user_role",
    "user_avatar",
    "user_phone",
    "user_birthday",
    "user_university",
    "user_diploma",
    "user_email",
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
  updateProfileUser,
  printInfoTeacher,
  getAllCoursesByTeacher,
  updatePassWord,
  printDetailProcessUserCourse,
  printPurchasedCourses,
};
