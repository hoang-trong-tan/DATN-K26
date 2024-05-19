"use strict";

const { Schema, model } = require("mongoose");

const DOCUMENT_NAME = "Notification";

const COLLECTION_NAME = "Notifications";

// Declare the Schema of the Mongo model
const notificationSchema = new Schema(
  {
    title: {
      type: String,
      required: true,
    },
    message: {
      type: String,
      required: true,
    },
    userId: {
      type: Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    status: {
      type: Boolean,
      default: false,
    },
    courseId: {
      type: Schema.Types.ObjectId,
      ref: "Course",
    },
    videoId: {
      type: Schema.Types.ObjectId,
      ref: "CourseDataVideo",
    },
  },
  {
    collection: COLLECTION_NAME,
    timestamps: true,
  }
);

//Export the model
module.exports = model(DOCUMENT_NAME, notificationSchema);
