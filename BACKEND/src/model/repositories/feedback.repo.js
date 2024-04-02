"use strict";

const {
  review,
  replyReview,
  questionReview,
  anwserReview,
} = require("../feedback.model");

const getAllReview = async ({ courseId, limit, page, select }) => {
  const skip = (page - 1) * limit;

  const findReview = await review
    .find({ courseId })
    .sort({ createdAt: -1 })
    .skip(skip)
    .limit(limit)
    .select(select)
    .populate("userId", "user_name user_avatar")
    .lean();

  for (const data of findReview) {
    const reply_comment = await getRelyReview(data._id, select);
    data.reply_comment = reply_comment;
  }

  return findReview;
};

const getRelyReview = async (reviewId, select) => {
  return await replyReview
    .find({ reviewId })
    .populate("userId", "user_name user_avatar")
    .select(select)
    .lean();
};

const getQuestionByVideo = async ({ videoId, limit, page, select }) => {
  const skip = (page - 1) * limit;
  const findQuestion = await questionReview
    .find({ videoId })
    .sort({ createdAt: -1 })
    .skip(skip)
    .limit(limit)
    .select(select)
    .populate("userId", "user_name user_avatar")
    .lean();

  for (const data of findQuestion) {
    const answser_comment = await getAnwser(data._id, select);
    data.answser_comment = answser_comment;
  }

  return findQuestion;
};

const getAnwser = async (questionId, select) => {
  return await anwserReview
    .find({ questionId })
    .populate("userId", "user_name user_avatar")
    .select(select)
    .lean();
};

module.exports = { getAllReview, getQuestionByVideo };
