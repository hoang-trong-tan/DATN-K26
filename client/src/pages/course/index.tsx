import { useParams } from "react-router-dom";
import {
  useGetCourseDetailsPurchaseQuery,
  useGetCourseDetailsQuery,
} from "../../redux/features/courses/coursesApi";
import Ratings from "../../components/ui/Ratings";
import { IoCheckmarkDoneOutline } from "react-icons/io5";
import { useEffect, useState } from "react";
import CourseContentList from "../courses/components/CourseContentList";
import { Button } from "../../components/ui/Button";

export type CourseType = {
  course_benefits: string[];
  course_data: CourseDataType[];
  course_demoVideo: string;
  course_description: string;
  course_lessonContent: string[];
  course_name: string;
  course_price: number;
  course_purchased: number;
  course_ratingsAverage: number;
  course_thumnail: string;
};
export type CourseDataType = {
  _id: string;
  courseData_title: string;
  course_data_video: CourseDataVideo;
  course_data_quiz: CourseDataQuiz[];
};

export type CourseDataVideo = {
  course_video: CourseVideo[];
  total_video_section: number;
};

type CourseVideo = {
  _id: string;
  video_title: string;
  video_length: number;
  video_url?: string;
  isSeen?: boolean;
};

type CourseDataQuiz = {
  _id: string;
  quiz_Tile: string;
};

const Course = () => {
  const { id } = useParams();
  const userId = localStorage.getItem("user_id");
  const { data } = userId
    ? useGetCourseDetailsPurchaseQuery(id as string)
    : useGetCourseDetailsQuery(id as string);

  const course: CourseType = data?.data;
  const [urlVideo, setUrlVideo] = useState("");
  useEffect(() => {
    if (course?.course_demoVideo) {
      setUrlVideo(course?.course_demoVideo);
    }
  }, [course?.course_demoVideo, urlVideo]);

  return (
    <div className="flex my-4 gap-5">
      <div className="flex flex-col gap-8 w-[60%]">
        <div className="flex flex-col gap-3">
          <h1 className="font-semibold text-3xl font-Poppins">
            {course?.course_name}
          </h1>
          <div className="flex justify-between">
            <div className="flex gap-3 items-center">
              <Ratings rating={course?.course_ratingsAverage} />
              <p className="text-[20px]">
                {course?.course_ratingsAverage} ratings / 5
              </p>
            </div>
            <h5>{course?.course_purchased} Students</h5>
          </div>
        </div>
        <div className="flex flex-col gap-3">
          <h1 className="font-semibold text-2xl font-Poppins">
            What will you learn from this courses
          </h1>
          {course?.course_benefits.map((item, index) => (
            <div className="flex items-center gap-2" key={index}>
              <IoCheckmarkDoneOutline
                size={20}
                className="text-black dark:text-white"
              />
              {item}
            </div>
          ))}
        </div>
        <div className="flex flex-col gap-3">
          <h1 className="font-semibold text-2xl font-Poppins">
            What are the prerequisites for starting this course?
          </h1>
          {course?.course_lessonContent?.map((item, index) => (
            <div className="flex items-center gap-2" key={index}>
              <IoCheckmarkDoneOutline
                size={20}
                className="text-black dark:text-white"
              />
              {item}
            </div>
          ))}
        </div>
        <div className="flex flex-col gap-3">
          <h1 className="font-semibold text-2xl font-Poppins">
            Course Description
          </h1>
          <div>{course?.course_description}</div>
        </div>
        <div className="flex flex-col gap-3">
          <h1 className="font-semibold text-2xl font-Poppins">
            Course Overview
          </h1>

          <div>
            {course?.course_data && (
              <CourseContentList data={course.course_data} />
            )}
          </div>
        </div>
      </div>
      <div className="flex flex-col gap-3 flex-1 items-center">
        {urlVideo && (
          <video
            controls
            poster={course.course_thumnail}
            className="w-[500px] h-auto"
          >
            <source src={urlVideo} type="video/mp4" />
          </video>
        )}
        <Button className="w-[200px] py-3 bg-[#DC143C]">
          Pay now {course?.course_price}$
        </Button>
      </div>
    </div>
  );
};

export default Course;
