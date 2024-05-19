"use strict";
const { CreatedResponse, Ok } = require("../core/sucess.response");
const catchAsync = require("../helper/catchAsync");
const {
  createQuiz,
  createQuestionQuiz,
  printQuizQuestion,
  createAnswerQuiz,
  printResultQuestion,
  getQuizBySectionId,
} = require("../service/quiz.service");

// tao bai quizz
exports.createQuiz = catchAsync(async (req, res, next) => {
  new CreatedResponse({
    message: "Create quizz is success",
    data: await createQuiz(req.body.quiz_title, req.params.id),
  }).send(res);
});

// tao cau hoi
exports.createQuestionQuiz = catchAsync(async (req, res, next) => {
  new CreatedResponse({
    message: "Create question is success",
    data: await createQuestionQuiz({
      question: req.body.quiz_questions,
      options: req.body.quiz_options,
      correctAnswer: req.body.quiz_correctAnswer,
      quizId: req.params.id,
    }),
  }).send(res);
});

// tao cau lua chon
exports.createAnswerQuiz = catchAsync(async (req, res, next) => {
  new CreatedResponse({
    message: "Create answer is success",
    data: await createAnswerQuiz(req.body, req.params.id, req.user.userId),
  }).send(res);
});

exports.getQuestionQuiz = catchAsync(async (req, res, next) => {
  new Ok({
    message: "get quiz question is success",
    data: await printQuizQuestion(req.params.id, req.user.userId),
  }).send(res);
});

exports.getResultQuiz = catchAsync(async (req, res, next) => {
  new Ok({
    message: "get result question is success",
    data: await printResultQuestion(req.params.id, req.user.userId),
  }).send(res);
});

exports.getQuizBySectionId = catchAsync(async (req, res, next) => {
  new Ok({
    message: "get quizz is success",
    data: await getQuizBySectionId(req.params.id),
  }).send(res);
});
