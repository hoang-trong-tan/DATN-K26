const express = require("express");
const courseController = require("../../controller/course.controller");
const router = express.Router();

router.get("/:id", courseController.findOneCourse);

router.post("/create-course", courseController.createCourse);
router.post("/update-course-data/:id", courseController.createCourseData);
router.post("/update-course-video/:id", courseController.createCourseVideo);

module.exports = router;
