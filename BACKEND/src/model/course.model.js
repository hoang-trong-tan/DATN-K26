const { Schema, model } = require("mongoose");

const DOCUMENT_NAME = "Course";

const COLLECTION_NAME = "Courses";

const videoShema = new Schema(
  {
    video_title: String,
    video_url: {
      type: String,
      required: true,
    },
    video_length: {
      type: Number,
      required: true,
    },
    courseDataShema_id: {
      type: Schema.Types.ObjectId,
      ref: "CourseData",
    },
  },
  {
    collection: "CourseDataVideos",
    timestamps: true,
  }
);

const courseDataShema = new Schema(
  {
    courseData_title: {
      type: String,
      required: true,
    },
    courseShema_id: {
      type: Schema.Types.ObjectId,
      ref: "Course",
    },
  },
  {
    collection: "CourseDatas",
    timestamps: true,
  }
);

const courseShema = new Schema(
  {
    course_name: {
      type: String,
      required: true,
    },
    course_categories: {
      type: String,
      required: true,
    },
    course_description: {
      type: String,
      required: true,
    },
    course_thumnail: {
      type: String,
      required: true,
    },
    course_demoVideo: {
      type: String,
      required: true,
    },
    course_benefits: [String],
    course_lessonContent: [String],

    // course_rivews: {
    //   type: String,
    //   required: true,
    // },
    // course_ratings: {
    //   type: String,
    //   required: true,
    // },
    // course_purchased: {
    //   type: String,
    //   required: true,
    // },
  },
  {
    collection: COLLECTION_NAME,
    timestamps: true,
  }
);

module.exports = {
  course: model(DOCUMENT_NAME, courseShema),
  courseData: model("CourseData", courseDataShema),
  courseDataVideo: model("CourseDataVideo", videoShema),
};
