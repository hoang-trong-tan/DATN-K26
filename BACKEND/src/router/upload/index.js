const express = require("express");
const uploadController = require("../../controller/upload.controller");
const upload = require("../../config/config.multer");
const { authentication, authorizeRoles } = require("../../auth/authUtils");
const router = express.Router();

router.use(authentication);

// router upload images
router.post(
  "/upload-images",
  authorizeRoles("teacher", "student", "admin"),
  upload.single("imgaes"),
  uploadController.uploadImages
);

// router upload video
router.post(
  "/upload-video",
  authorizeRoles("teacher"),
  upload.single("video"),
  uploadController.uploadVideo
);
module.exports = router;
