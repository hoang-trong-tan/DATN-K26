"use strict";
const { CreatedResponse, Ok } = require("../core/sucess.response");
const catchAsync = require("../helper/catchAsync");
const {
  addReview,
  getAllReviewByCourse,
  addReplyReview,
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
    message: "add review is sucess",
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
