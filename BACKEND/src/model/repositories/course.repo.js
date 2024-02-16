"use strict";

const getUnSelect = require("../../util");
const {
  course,
  courseData,
  courseDataVideo,
  courseType,
} = require("../course.model");

const findOneCourseId = async (courseId, unSelect) => {
  const courseData = await getCourseData(courseId, unSelect);
  const totalLength = await calculateTotalLength(courseData, unSelect);
  const fullCourse = await getFullCourse(courseId, unSelect);

  fullCourse.totalLength = totalLength;

  return { ...fullCourse, courseData };
};

const findAllCourseType = async (unSelect) => {
  return await courseType.find().select(getUnSelect(unSelect)).lean();
};

const getCourseData = async (courseId, unSelect) => {
  const getcourseData = await courseData
    .find({ courseShema: courseId })
    .populate("courseShema_id")
    .select(getUnSelect(unSelect))
    .lean();
  for (const data of getcourseData) {
    const courseDataVideo = await getCourseDataVideo(data._id, unSelect);
    data.courseDataVideo = courseDataVideo;
  }
  return getcourseData;
};

const getCourseDataVideo = async (courseDataId, unSelect) => {
  return await courseDataVideo
    .find({ courseDataShema: courseDataId })
    .select(getUnSelect(unSelect))
    .lean();
};

const calculateTotalLength = async (courseData, unSelect) => {
  let totalLength = 0;
  for (const data of courseData) {
    const courseDataVideos = await getCourseDataVideo(data._id, unSelect);
    for (const video of courseDataVideos) {
      totalLength += Math.round(video.video_length);
    }
  }
  return totalLength;
};

const getFullCourse = async (courseId, unSelect) => {
  return await course
    .findOne({ _id: courseId })
    .select(getUnSelect(unSelect))
    .lean();
};

module.exports = { findOneCourseId, findAllCourseType };
