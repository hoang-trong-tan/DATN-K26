const express = require("express");
const feedbackController = require("../../controller/feedback.controller");
const { authentication } = require("../../auth/authUtils");

const router = express.Router();
router.get("/get-review/:id", feedbackController.getAllReviewByCourse);

router.use(authentication);

router.post("/review/:id", feedbackController.addReview);
router.post("/reply-review/:id", feedbackController.replyReview);

module.exports = router;
