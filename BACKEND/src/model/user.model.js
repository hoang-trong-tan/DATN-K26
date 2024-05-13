"use strict";

const { Schema, model } = require("mongoose");

const DOCUMENT_NAME = "User";

const COLLECTION_NAME = "Users";

const emailRegexPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
// Declare the Schema of the Mongo model
const userSchema = new Schema(
  {
    user_name: {
      type: String,
      required: true,
    },
    user_email: {
      type: String,
      required: true,
      validate: {
        validator: function (value) {
          return emailRegexPattern.test(value);
        },
        message: "please enter a valid email",
      },
      unique: true,
    },
    user_password: {
      type: String,
      required: true,
      minlength: 6,
    },
    user_avatar: {
      type: String,
      default: "",
    },
    user_role: {
      type: String,
      enum: ["student", "teacher", "admin"],
    },
    user_isBlocked: {
      type: Boolean,
      default: false,
    },
    user_course: [
      {
        courseId: {
          type: Schema.Types.ObjectId,
          ref: "Course",
        },
        process_Course: {
          type: Number,
          default: 0,
        },
      },
    ],
    user_about: {
      type: String,
      default: "",
    },
    user_experience: [
      {
        company: String,
        title: String,
        description: String,
      },
    ],
    user_phone: {
      type: String,
      maxlength: 10,
      default: null,
    },
    user_birthday: {
      type: Date,
      default: null,
    },
    user_university: {
      type: String,
      default: null,
    },
    user_major: {
      type: String,
      default: null,
    },
    course_type: {
      type: Schema.Types.ObjectId,
      ref: "CourseType",
      default: null,
    },
    user_diploma: {
      type: String,
      default: null,
    },
    user_fcm_token: {
      type: String,
      default: null,
    },
  },
  {
    collection: COLLECTION_NAME,
    timestamps: true,
  }
);

// create index for search

userSchema.index({ user_name: "text" });

//Export the model
module.exports = model(DOCUMENT_NAME, userSchema);
