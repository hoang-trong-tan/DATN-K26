const express = require("express");
const courseController = require("../../controller/course.controller");
const { authentication } = require("../../auth/authUtils");
const router = express.Router();

router.get("", courseController.findAllCourses);
router.get("/get-all-course-type", courseController.findAllCourseType);
router.get("/search", courseController.getListSearchCourses);
router.get("/get-one-course/:id", courseController.getOneCourse);
router.get("/get-course-by-type/:id", courseController.findCoursesByType);

router.use(authentication);

router.get("/get-one-course/learn/:id", courseController.getCoursePurchased);
router.post("/create-course", courseController.createCourse);
router.post("/update-course-data/:id", courseController.createCourseData);
router.post("/update-course-video/:id", courseController.createCourseVideo);
router.post("/create-type", courseController.createCourseType);

module.exports = router;
