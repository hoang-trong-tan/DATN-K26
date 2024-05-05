"use strict";
const { BadRequestError } = require("../core/error.response");
const { CreatedResponse, Ok } = require("../core/sucess.response");
const catchAsync = require("../helper/catchAsync");
const {
  uploadVideo,
  uploadImages,
  uploadDocument,
  getDocumentByVideoId,
  downLoadDocByVideoId,
} = require("../service/upload.service");

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

exports.uploadDocument = catchAsync(async (req, res, next) => {
  const { file } = req;
  if (!file) {
    throw new BadRequestError("File missing");
  }

  new CreatedResponse({
    message: "upload document successfully!!",
    data: await uploadDocument(file, req.params.id),
  }).send(res);
});

exports.getDocumentByVideoId = catchAsync(async (req, res, next) => {
  new Ok({
    message: "get document successfully!!",
    data: await getDocumentByVideoId(req.params.id),
  }).send(res);
});

exports.downLoadDocumentByVideoId = catchAsync(async (req, res, next) => {
  try {
    const response = await downLoadDocByVideoId(
      req.params.id,
      req.query.fileName
    );

    // Set appropriate headers for file download
    res.setHeader(
      "Content-Disposition",
      `attachment; filename=${req.query.fileName}`
    );
    res.setHeader("Content-Length", response.ContentLength); // Set content length if available
    res.setHeader("Content-Type", response.ContentType); // Set content type

    // Pipe the response body (stream) directly to the response object
    response.Body.pipe(res);
  } catch (error) {
    // Handle the error appropriately
    res.status(500).json({ error: "Internal Server Error" });
  }
});
