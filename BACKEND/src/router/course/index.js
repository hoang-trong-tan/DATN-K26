const express = require("express");
const courseController = require("../../controller/course.controller");
const router = express.Router();

router.get("/:id", courseController.findOneCourse);
router.get("/", courseController.findAllCourseType);

router.post("/create-course", courseController.createCourse);
router.post("/update-course-data/:id", courseController.createCourseData);
router.post("/update-course-video/:id", courseController.createCourseVideo);
router.post("/create-type", courseController.createCourseType);

module.exports = router;
