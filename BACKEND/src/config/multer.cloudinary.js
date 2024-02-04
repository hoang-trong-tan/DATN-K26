"use strict";

const cloudinary = require("./config.cloudinary");
const multer = require("multer");
const { CloudinaryStorage } = require("multer-storage-cloudinary");

// Cấu hình multer-storage-cloudinary
// const storage = new CloudinaryStorage({
//   cloudinary: cloudinary,
//   params: {
//     format: "mp4",
//     resource_type: "video",
//   },
// });

const storage = new CloudinaryStorage({
  cloudinary: cloudinary,
  params: {
    resource_type: "auto",
    allowedFormats: ["jpg", "png", "gif", "mp4"],
  },
});

// Khởi tạo multer với storage của Cloudinary
const parser = multer({
  storage: storage,
});

module.exports = parser;
