"use strict";

const { review, replyReview } = require("../feedback.model");

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

module.exports = { getAllReview };
