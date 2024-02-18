const express = require("express");
const courseController = require("../../controller/course.controller");
const router = express.Router();

router.get("/get-one-course/:id", courseController.findOneCourse);
router.get("/get-all-course-type", courseController.findAllCourseType);
router.get("", courseController.findAllCourses);
router.get("/get-course-by-type/:id", courseController.findCoursesByType);
router.get("/search/:keySearch", courseController.getListSearchCourses);

router.post("/create-course", courseController.createCourse);
router.post("/update-course-data/:id", courseController.createCourseData);
router.post("/update-course-video/:id", courseController.createCourseVideo);
router.post("/create-type", courseController.createCourseType);

module.exports = router;
