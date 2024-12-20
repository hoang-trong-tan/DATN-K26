"use strict";

const {
  S3Client,
  PutObjectCommand,
  DeleteBucketCommand,
  ListObjectsCommand,
  GetObjectCommand,
} = require("@aws-sdk/client-s3");

const S3Config = {
  region: process.env.AWS_BUCKET_REGION,
  credentials: {
    accessKeyId: process.env.AWS_BUCKET_ACCESS_KEY,
    secretAccessKey: process.env.AWS_BUCKET_SECRET_KEY,
  },
};

const s3 = new S3Client(S3Config);

module.exports = {
  s3,
  PutObjectCommand,
  DeleteBucketCommand,
  ListObjectsCommand,
  GetObjectCommand,
};
