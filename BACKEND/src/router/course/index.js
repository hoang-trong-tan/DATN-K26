const express = require("express");
const courseController = require("../../controller/course.controller");
const { authentication, authorizeRoles } = require("../../auth/authUtils");
const router = express.Router();

router.get("", courseController.findAllCourses);
router.get("/get-all-course-type", courseController.findAllCourseType);
router.get("/search", courseController.getListSearchCourses);
router.get("/get-one-course/:id", courseController.getOneCourse);
router.get("/get-course-by-type/:id", courseController.findCoursesByType);

router.use(authentication);

router.get(
  "/get-one-course/learn/:id",
  authorizeRoles("student", "teacher"),
  courseController.getCoursePurchased
);
router.post(
  "/create-course",
  authorizeRoles("teacher"),
  courseController.createCourse
);
router.post(
  "/update-course-data/:id",
  authorizeRoles("teacher"),
  courseController.createCourseData
);
router.post(
  "/update-course-video/:id",
  authorizeRoles("teacher"),
  courseController.createCourseVideo
);
router.post(
  "/create-type",
  authorizeRoles("admin"),
  courseController.createCourseType
);

module.exports = router;
