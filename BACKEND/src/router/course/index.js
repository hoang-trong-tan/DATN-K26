const express = require("express");
const courseController = require("../../controller/course.controller");
const userController = require("../../controller/user.controller");
const { authentication, authorizeRoles } = require("../../auth/authUtils");
const router = express.Router();

router.get("/get-all-course", courseController.findAllCourses);
router.get("/get-all-course-type", courseController.findAllCourseType);
router.get("/search", courseController.getListSearchCourses);
router.get("/get-one-course/:id", courseController.getOneCourse);
router.get("/get-course-by-type/:id", courseController.findCoursesByType);
router.get("/get-all-teacher", courseController.printAllTeacher);

router.use(authentication);

router.get("/get-one-course/learn/:id", courseController.getCoursePurchased);
router.get("/get-one-video/:id", courseController.findOneVideo);

router.post(
  "/update-process-learn/:id",
  authorizeRoles("student"),
  userController.updateProcessLearn
);

router.post(
  "/create-course",
  authorizeRoles("teacher"),
  courseController.createCourse
);
router.post(
  "/create-course-data/:id",
  authorizeRoles("teacher"),
  courseController.createCourseData
);
router.post(
  "/create-course-video/:id",
  authorizeRoles("teacher"),
  courseController.createCourseVideo
);
router.post(
  "/create-type",
  authorizeRoles("admin"),
  courseController.createCourseType
);

router.get(
  "/get-all-course-data/:id",
  authorizeRoles("teacher"),
  courseController.printAllCourseData
);

router.delete(
  "/delete-course-data/:id",
  authorizeRoles("teacher"),
  courseController.deleteCourseData
);

module.exports = router;
