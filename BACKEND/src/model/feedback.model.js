"use strict";

const { Schema, model } = require("mongoose");

const DOCUMENT_NAME = "Review";

const COLLECTION_NAME = "Reviews";

// Declare the Schema of the Mongo model
const reviewSchema = new Schema(
  {
    userId: {
      type: Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    courseId: {
      type: Schema.Types.ObjectId,
      ref: "Course",
      required: true,
    },
    review_rating: {
      type: Number,
      default: 0,
      required: true,
    },
    review_comment: {
      type: String,
      required: true,
    },
  },
  {
    collection: COLLECTION_NAME,
    timestamps: true,
  }
);

const replyReviewSchema = new Schema(
  {
    reviewId: {
      type: Schema.Types.ObjectId,
      ref: "Review",
      required: true,
    },

    userId: {
      type: Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },

    courseId: {
      type: Schema.Types.ObjectId,
      ref: "Course",
      required: true,
    },
    reply_comment: {
      type: String,
      required: true,
    },
  },
  {
    collection: "ReplyReviews",
    timestamps: true,
  }
);

//Export the model
module.exports = {
  review: model(DOCUMENT_NAME, reviewSchema),
  replyReview: model("ReplyReview", replyReviewSchema),
};
