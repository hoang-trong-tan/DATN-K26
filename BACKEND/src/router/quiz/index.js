"use strict";

const express = require("express");
const quizController = require("../../controller/quiz.controller");

const { authentication, authorizeRoles } = require("../../auth/authUtils");
const router = express.Router();

router.use(authentication);

router.post(
  "/create-quiz/:id",
  authorizeRoles("teacher"),
  quizController.createQuiz
);
router.post(
  "/create-question-quiz/:id",
  authorizeRoles("teacher"),
  quizController.createQuestionQuiz
);
router.post("/submit-quiz/:id", quizController.createAnswerQuiz);
router.get("/get-question-quiz/:id", quizController.getQuestionQuiz);
router.get("/show-answer-quiz/:id", quizController.getResultQuiz);
router.get("/get-quiz/:id", quizController.getQuizBySectionId);

module.exports = router;
