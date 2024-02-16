const express = require("express");
const uploadController = require("../../controller/upload.controller");
const parser = require("../../config/multer.cloudinary");

const router = express.Router();

// router upload images
router.post(
  "/upload-images",
  parser.single("imgaes"),
  uploadController.uploadImages
);

// router upload video
router.post(
  "/upload-video/",
  parser.single("video"),
  uploadController.uploadVideo
);
module.exports = router;
