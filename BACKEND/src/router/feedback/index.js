const express = require("express");
const feedbackController = require("../../controller/feedback.controller");
const { authentication, authorizeRoles } = require("../../auth/authUtils");

const router = express.Router();
router.get("/get-review/:id", feedbackController.getAllReviewByCourse);

router.use(authentication);

router.post(
  "/review/:id",
  authorizeRoles("student"),
  feedbackController.addReview
);
router.post(
  "/reply-review/:id",
  authorizeRoles("teacher"),
  feedbackController.replyReview
);
router.post(
  "/add-question/:id",
  authorizeRoles("student", "teacher"),
  feedbackController.addQuestion
);
router.post(
  "/add-anwser/:id",
  authorizeRoles("student", "teacher"),
  feedbackController.addAnwser
);
router.get(
  "/get-question/:id",
  authorizeRoles("student", "teacher"),
  feedbackController.getAllQuestionByVideo
);

module.exports = router;
