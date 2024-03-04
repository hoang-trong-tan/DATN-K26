"use strict";

const { Schema, model } = require("mongoose");

const DOCUMENT_NAME = "Cart";

const COLLECTION_NAME = "Carts";

const cartShema = new Schema(
  {
    courseShema: {
      type: Schema.Types.ObjectId,
      ref: "Course",
    },
    userShema: {
      type: Schema.Types.ObjectId,
      ref: "User",
    },
  },
  {
    collection: COLLECTION_NAME,
    timestamps: true,
  }
);

module.exports = model(DOCUMENT_NAME, cartShema);
