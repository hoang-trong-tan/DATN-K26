"use strict";

const { Schema, model } = require("mongoose");

const DOCUMENT_NAME = "User";

const COLLECTION_NAME = "Users";

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
      unique: true,
    },
    user_password: {
      type: String,
      required: true,
    },
    user_avatar: {
      type: String,
      required: true,
    },
    user_role: {
      type: String,
    },
    user_isVerified: {
      type: Boolean,
      default: false,
    },
  },
  {
    collection: COLLECTION_NAME,
    timestamps: true,
  }
);

//Export the model
module.exports = model(DOCUMENT_NAME, userSchema);
