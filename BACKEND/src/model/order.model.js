"use strict";

const { Schema, model } = require("mongoose");

const DOCUMENT_NAME = "Oder";

const COLLECTION_NAME = "Oders";

// Declare the Schema of the Mongo model
const orderSchema = new Schema(
  {
    courseId: {
      type: Schema.Types.ObjectId,
      ref: "Course",
      required: true,
    },
    userId: {
      type: Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    payment_info: {
      type: String,
      required: true,
    },
  },
  {
    collection: COLLECTION_NAME,
    timestamps: true,
  }
);

//Export the model
module.exports = model(DOCUMENT_NAME, orderSchema);
