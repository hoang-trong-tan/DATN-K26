const crypto = require("crypto");

const {
  s3,
  PutObjectCommand,
  DeleteBucketCommand,
} = require("../config/config.awsS3");

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

module.exports = { uploadVideo, uploadImages };
