"use strict";
const { BadRequestError } = require("../core/error.response");
const { CreatedResponse } = require("../core/sucess.response");
const catchAsync = require("../helper/catchAsync");
const { uploadVideo, uploadImages } = require("../service/upload.service");

exports.uploadVideo = catchAsync(async (req, res, next) => {
  const { file } = req;
  if (!file) {
    throw new BadRequestError("File missing");
  }

  new CreatedResponse({
    message: "upload video successfully!!",
    data: await uploadVideo(file),
  }).send(res);
});

exports.uploadImages = catchAsync(async (req, res, next) => {
  const { file } = req;
  if (!file) {
    throw new BadRequestError("File missing");
  }

  new CreatedResponse({
    message: "upload images successfully!!",
    data: await uploadImages(file),
  }).send(res);
});
