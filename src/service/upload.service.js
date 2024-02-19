const cloudinary = require("../config/config.cloudinary");
const uploadImages = async ({ path, folderName = "course/8409" }) => {
  try {
    const result = await cloudinary.uploader.upload(path, {
      resource_type: "image",
      folder: folderName,
    });

    console.log("a::", result.secure_url);
    return {
      images_id: result.public_id,
      images_url: result.secure_url,
    };
  } catch (error) {
    console.log("Error update images::", error);
  }
};

// Hàm upload video
const uploadVideo = async ({ path, folderName = "videos/" }) => {
  try {
    const result = await cloudinary.uploader.upload(path, {
      resource_type: "video",
      folder: folderName,
      eager: [
        { width: 300, height: 300, crop: "pad", audio_codec: "none" },
        {
          width: 160,
          height: 100,
          crop: "crop",
          gravity: "south",
          audio_codec: "none",
        },
      ],
      eager_async: true,
      format: "mp4",
    });

    // lấy thông tin video
    const videoInfo = await cloudinary.api.resource(result.public_id, {
      resource_type: "video",
      image_metadata: true,
    });
    console.log("infor::", result);
    // Trả về URL của video
    return {
      video_url: result.secure_url,
      video_duration: videoInfo.video_duration,
    };
  } catch (error) {
    console.error("Error uploading video:", error);
    throw error; // Ném ra lỗi để xử lý ở nơi gọi hàm
  }
};

module.exports = { uploadVideo, uploadImages };
