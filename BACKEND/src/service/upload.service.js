const crypto = require("crypto");

const {
  s3,
  PutObjectCommand,
  DeleteBucketCommand,
  ListObjectsCommand,
  GetObjectCommand,
} = require("../config/config.awsS3");
const path = require("path");
const fs = require("fs");

// upload file use S3client ///

const uploadImages = async (file) => {
  try {
    const randomImageName = `${crypto.randomBytes(16).toString("hex")}.png`;
    const urlName = `${process.env.AWS_CLOUDFRONT_LINK}Images/${randomImageName}`;
    const command = new PutObjectCommand({
      Bucket: process.env.AWS_BUCKET_NAME,
      Key: "Images/" + randomImageName,
      Body: file.buffer,
      ContentType: "image/jpeg",
    });

    await s3.send(command);

    return urlName;
  } catch (error) {
    throw error; // Ném ra lỗi để xử lý ở nơi gọi hàm
  }
};

//// END S3 Service///

// Hàm upload video
const uploadVideo = async (file) => {
  try {
    const randomVideoName = `${crypto.randomBytes(16).toString("hex")}.mp4`;
    const urlName = `${process.env.AWS_CLOUDFRONT_LINK}Video/${randomVideoName}`;
    const command = new PutObjectCommand({
      Bucket: process.env.AWS_BUCKET_NAME,
      Key: "Video/" + randomVideoName,
      Body: file.buffer,
      ContentType: "video/mp4",
    });

    await s3.send(command);

    return urlName;
  } catch (error) {
    throw error; // Ném ra lỗi để xử lý ở nơi gọi hàm
  }
};

const uploadDocument = async (file, videoId) => {
  try {
    const documentPath = `Document/${videoId}/${file.originalname}`;
    const urlName = `${process.env.AWS_CLOUDFRONT_LINK}${documentPath}`;
    const command = new PutObjectCommand({
      Bucket: process.env.AWS_BUCKET_NAME,
      Key: documentPath,
      Body: file.buffer,
      ContentType: file.mimetype,
    });

    await s3.send(command);

    return urlName;
  } catch (error) {
    throw error; // Ném ra lỗi để xử lý ở nơi gọi hàm
  }
};

const getDocumentByVideoId = async (videoId) => {
  try {
    const documentPath = `Document/${videoId}/`;
    const command = new ListObjectsCommand({
      Bucket: process.env.AWS_BUCKET_NAME,
      Delimiter: "/",
      Prefix: documentPath,
    });

    const data = await s3.send(command);

    const document = data.Contents?.map((item) => item.Key);

    if (!document) {
      return [];
    }

    let fileNames = document.map((item) => path.basename(item));

    return fileNames;
  } catch (error) {
    throw error; // Ném ra lỗi để xử lý ở nơi gọi hàm
  }
};

const downLoadDocByVideoId = async (videoId, fileName) => {
  try {
    const documentPath = `Document/${videoId}/${fileName}`;
    const command = new GetObjectCommand({
      Bucket: process.env.AWS_BUCKET_NAME,
      Key: documentPath,
    });

    const data = await s3.send(command);

    return data;
  } catch (error) {
    throw error; // Ném ra lỗi để xử lý ở nơi gọi hàm
  }
};

module.exports = {
  uploadVideo,
  uploadImages,
  uploadDocument,
  getDocumentByVideoId,
  downLoadDocByVideoId,
};
