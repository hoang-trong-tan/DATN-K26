"use strict";

const getUnSelect = require("../../util");
const {
  course,
  courseData,
  courseDataVideo,
  courseType,
} = require("../course.model");

const Types = { COURSE: "course", MENTOR: "mentor" };

// chi tiet khoa hoc
const findOneCourseId = async (courseId, unSelect) => {
  const courseData = await getCourseData(courseId, unSelect);
  const totalLength = await calculateTotalLength(courseData, unSelect);
  const fullCourse = await getFullCourse(courseId, unSelect);

  fullCourse.totalLength = totalLength;

  return { ...fullCourse, courseData };
};

// lay ra toan bo danh muc
const findAllCourseType = async (unSelect) => {
  return await courseType.find().select(getUnSelect(unSelect)).lean();
};

// lay ra toan bo khoa hoc
const findAllCourses = async ({ sort, limit, page, select }) => {
  const skip = (page - 1) * limit;
  const sortBy = sort === "ctime" ? { _id: -1 } : { _id: 1 };

  const courses = await course
    .find()
    .sort(sortBy)
    .skip(skip)
    .limit(limit)
    .select(select)
    .lean();

  return courses;
};

// lấy ra toàn bộ khóa học theo danh mục loại
const queryCourseByType = async ({ courseTypeId, limit, page, select }) => {
  const skip = (page - 1) * limit;
  return await course
    .find({ course_type: courseTypeId })
    .sort({ updateAt: -1 })
    .skip(skip)
    .limit(limit)
    .select(select)
    .lean()
    .exec();
};

// tim kiem san pham theo ten
const search = async ({ type, keySearch, select, limit, page }) => {
  const regexSearch = new RegExp(keySearch);

  const skip = (page - 1) * limit;

  const searchCourse = await course
    .find(
      { $text: { $search: regexSearch } }
      // { score: { $meta: "textScore" } }
    )
    .skip(skip)
    .limit(limit)
    // .sort({ score: { $meta: "textScore" } })
    .select(select)
    .lean();

  if (type === Types.COURSE) {
    return searchCourse;
  } else if (type === Types.MENTOR) {
    return [];
  }
};

const getCourseData = async (courseId, unSelect) => {
  const getcourseData = await courseData
    .find({ courseShema: courseId })
    .populate("courseShema")
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

module.exports = {
  findOneCourseId,
  findAllCourseType,
  findAllCourses,
  queryCourseByType,
  search,
};
