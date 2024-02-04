"use strict";

const getUnSelect = require("../../util");
const { course, courseData, courseDataVideo } = require("../course.model");

exports.findOneCourseId = async (courseId) => {
  let getCourseData = await courseData
    .find({ courseShema_id: courseId })
    .populate("courseShema_id")
    .select(getUnSelect(["courseShema_id", "createdAt", "updatedAt", "__v"]))
    .lean();

  for (let data of getCourseData) {
    const getCourseDataVideo = await courseDataVideo
      .find({ courseDataShema_id: data._id })
      .select(getUnSelect(["createdAt", "updatedAt", "__v"]))
      .lean();
    data.getCourseDataVideo = getCourseDataVideo;
  }
  const fullCourse = await course.findOne({ _id: courseId }).lean();

  return { ...fullCourse, getCourseData };
};
