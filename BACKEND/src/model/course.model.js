const { Schema, model } = require("mongoose");
const slugify = require("slugify");

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
    courseDataShema: {
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
    courseShema: {
      type: Schema.Types.ObjectId,
      ref: "Course",
    },
  },
  {
    collection: "CourseDatas",
    timestamps: true,
  }
);

const courseTypeShema = new Schema(
  {
    type_name: {
      type: String,
      required: true,
      unique: true,
    },
  },
  {
    collection: "CourseTypes",
    timestamps: true,
  }
);

const courseShema = new Schema(
  {
    course_name: {
      type: String,
      required: true,
    },
    course_type: {
      type: Schema.Types.ObjectId,
      ref: "CourseType",
      required: true,
    },
    course_description: {
      type: String,
      required: true,
    },
    course_slug: String,
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
    course_price: {
      type: Number,
      required: true,
    },
    course_purchased: {
      type: Number,
      default: 0,
    },
    course_ratingsAverage: {
      type: Number,
      default: 0,
    },
    user_teacher: {
      type: Schema.Types.ObjectId,
      ref: "User",
    },
  },
  {
    collection: COLLECTION_NAME,
    timestamps: true,
  }
);

// create index for search

courseShema.index({ course_name: "text" });

// tao slug
courseShema.pre("save", function (next) {
  this.course_slug = slugify(this.course_name, { lower: true });
  next();
});

module.exports = {
  course: model(DOCUMENT_NAME, courseShema),
  courseData: model("CourseData", courseDataShema),
  courseDataVideo: model("CourseDataVideo", videoShema),
  courseType: model("CourseType", courseTypeShema),
};
