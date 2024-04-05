"use strict";
const { CreatedResponse, Ok } = require("../core/sucess.response");
const catchAsync = require("../helper/catchAsync");
const {
  addReview,
  getAllReviewByCourse,
  addReplyReview,
  addQuestion,
  getAllQuestionByVideo,
  addAnwser,
} = require("../service/feedback.service");

// them review
exports.addReview = catchAsync(async (req, res, next) => {
  new CreatedResponse({
    message: "add review is sucess",
    data: await addReview({
      userId: req.user.userId,
      courseId: req.params.id,
      rating: req.body.review_rating,
      comment: req.body.review_comment,
    }),
  }).send(res);
});

exports.replyReview = catchAsync(async (req, res, next) => {
  new CreatedResponse({
    message: "add reply review is sucess",
    data: await addReplyReview({
      reviewId: req.params.id,
      courseId: req.body.courseId,
      comment: req.body.reply_comment,
      userId: req.user.userId,
    }),
  }).send(res);
});

// tra ve tat ca review
exports.getAllReviewByCourse = catchAsync(async (req, res, next) => {
  new Ok({
    message: "get review is sucess",
    data: await getAllReviewByCourse({ courseId: req.params.id, ...req.query }),
  }).send(res);
});

// them cau hoi
exports.addQuestion = catchAsync(async (req, res, next) => {
  new CreatedResponse({
    message: "add question is sucess",
    data: await addQuestion({
      userId: req.user.userId,
      videoTime: req.body.video_time,
      courseId: req.body.courseId,
      videoId: req.params.id,
      question: req.body.question_comment,
    }),
  }).send(res);
});

// them cau tra loi
exports.addAnwser = catchAsync(async (req, res, next) => {
  new CreatedResponse({
    message: "add anwser is sucess",
    data: await addAnwser({
      questionId: req.params.id,
      userId: req.user.userId,
      anwser: req.body.answser_comment,
    }),
  }).send(res);
});

// tra ve tat ca cau hoi theo video
exports.getAllQuestionByVideo = catchAsync(async (req, res, next) => {
  new Ok({
    message: "get question is sucess",
    data: await getAllQuestionByVideo({ videoId: req.params.id, ...req.query }),
  }).send(res);
});
