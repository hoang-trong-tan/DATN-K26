"use strict";

const { getUnSelect } = require("../../util");
const {
  course,
  courseData,
  courseDataVideo,
  courseType,
} = require("../course.model");
const { quiz } = require("../quiz.model");
const userModel = require("../user.model");

const Types = { COURSE: "course", MENTOR: "mentor" };

// chi tiet khoa hoc
const findOneCourse = async (courseId, unSelect, videoIdsSeen) => {
  const courseData = await getCourseSections(courseId, unSelect, videoIdsSeen);

  const totalLength = await calculateTotalLength(courseData);

  const fullCourse = await getFullCourse(courseId, unSelect);
  fullCourse.total_length_video = totalLength;

  return { ...fullCourse, course_data: courseData };
};

// lay ra toan bo danh muc
const findAllCourseType = async (unSelect) => {
  return await courseType.find().select(getUnSelect(unSelect)).lean();
};

// lay ra toan bo khoa hoc
const findAllCourses = async ({ limit, page, select }) => {
  const skip = (page - 1) * limit;

  const courses = await course
    .find()
    .populate("user_teacher", "user_name user_avatar")
    .sort({ course_purchased: -1 })
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
    .populate("user_teacher", "user_name user_avatar")
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
    .find({ $text: { $search: regexSearch } })
    .populate("user_teacher", "user_name user_avatar")
    .skip(skip)
    .limit(limit)
    .select(select)
    .lean();

  const searchMentor = await userModel
    .find({ $text: { $search: regexSearch }, user_role: "teacher" })
    .skip(skip)
    .limit(limit)
    .select(select)
    .lean();

  if (type === Types.COURSE) {
    return searchCourse;
  } else if (type === Types.MENTOR) {
    return searchMentor;
  }
};

const getCourseSections = async (courseId, unSelect, videoIdsSeen) => {
  const course = await courseData
    .find({ courseShema: courseId })
    .populate("courseShema")
    .select(getUnSelect(unSelect))
    .lean();
  for (const data of course) {
    const courseDataVideo = await getCourseDataVideo(data._id, unSelect);
    const courseDataQuizs = await getCourseDataQuizs(data._id, unSelect);
    const sumLengthVideo = calculateTotalLengthSection(courseDataVideo);
    data.course_data_video = {
      course_video: courseDataVideo.map((item) => {
        const courseVideoItem = { ...item };
        if (videoIdsSeen) {
          courseVideoItem.isSeen = videoIdsSeen.includes(item._id.toString());
        }
        return courseVideoItem;
      }),
      total_video_section: sumLengthVideo,
    };
    data.course_data_quiz = courseDataQuizs;
  }

  return course;
};

const getCourseDataVideo = async (courseDataId, unSelect) => {
  return await courseDataVideo
    .find({ courseDataShema: courseDataId })
    .select(getUnSelect(unSelect))
    .lean();
};

const getCourseDataQuizs = async (courseDataId, unSelect) => {
  return await quiz
    .find({ courseData: courseDataId })
    .select(getUnSelect(unSelect))
    .lean();
};

const calculateTotalLength = async (courseData) => {
  const totalLengthVideo = courseData.reduce(
    (total, curr) => total + curr.course_data_video.total_video_section,
    0
  );
  return totalLengthVideo;
};

const calculateTotalLengthSection = (courseDataVideo) => {
  let totalLength = 0;
  for (const data of courseDataVideo) {
    totalLength += Math.round(data.video_length);
  }

  return totalLength;
};

const getFullCourse = async (courseId, unSelect) => {
  return await course
    .findOne({ _id: courseId })
    .populate("course_type", "type_name")
    .select(getUnSelect(unSelect))
    .lean();
};

const findAllTeacher = async (select) => {
  const teacher = await userModel.find({ user_role: "teacher" }).select(select);

  const teacherIds = teacher.map((item) => item._id);

  const courses = await course
    .find({ user_teacher: { $in: teacherIds } })
    .sort()
    .exec();

  console.log("data::", courses);

  return teacher;
};

module.exports = {
  findOneCourse,
  findAllCourseType,
  findAllCourses,
  queryCourseByType,
  search,
  getCourseDataVideo,
  findAllTeacher,
};
