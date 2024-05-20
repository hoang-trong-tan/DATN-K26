/* eslint-disable react-hooks/rules-of-hooks */
import { useNavigate, useParams } from "react-router-dom";
import {
  useGetCourseDetailsPurchaseQuery,
  useGetCourseDetailsQuery,
} from "../../redux/features/courses/coursesApi";
import Ratings from "../../components/ui/Ratings";
import { IoCheckmarkDoneOutline } from "react-icons/io5";
import { useEffect, useState } from "react";
import CourseContentList from "../courses/components/CourseContentList";
import { Button } from "../../components/ui/Button";
import Loader from "../../components/Loader/Loader";
import { useSelector } from "react-redux";
import { useCreateOrderMutation } from "../../redux/features/orders/ordersApi";

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
  const { course_bought } = useSelector((state: any) => state.auth);
  const navigate = useNavigate();
  const { data, isLoading } = userId
    ? useGetCourseDetailsPurchaseQuery(id as string)
    : useGetCourseDetailsQuery(id as string);
  const course: CourseType = data?.data;
  const [urlVideo, setUrlVideo] = useState("");
  useEffect(() => {
    if (course?.course_demoVideo) {
      setUrlVideo(course?.course_demoVideo);
    }
  }, [course?.course_demoVideo, urlVideo]);

  const [createOrder] = useCreateOrderMutation();
  const isCourseBought = course_bought?.includes(id);
  const firstLectureVideo =
    course?.course_data?.[0]?.course_data_video?.course_video?.[0]?._id;

  const handleCourseClick = async () => {
    if (isCourseBought && firstLectureVideo) {
      navigate(`/course/${id}/lecture/${firstLectureVideo}`);
    }
    try {
      const orderInfo: any = await createOrder(id);
      window.location = orderInfo?.data?.data;
    } catch (error) {
      console.log({ error });
    }
  };

  return isLoading ? (
    <Loader />
  ) : (
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
            <h5>{course?.course_purchased} Học Viên</h5>
          </div>
        </div>
        <div className="flex flex-col gap-3">
          <h1 className="font-semibold text-2xl font-Poppins">
            Từ những khóa học này, bạn sẽ học được những kỹ năng gì?
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
            Các điều kiện tiên quyết cho việc bắt đầu khóa học này là gì?
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
            Mô tả Khóa học
          </h1>
          <div>{course?.course_description}</div>
        </div>
        <div className="flex flex-col gap-3">
          <h1 className="font-semibold text-2xl font-Poppins">

            Tổng quan về Khóa học
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
        <Button
          className="w-[200px] py-3 bg-[#DC143C]"
          onClick={() => handleCourseClick()}
        >
          {isCourseBought ? "Học ngay" : `Mua ngay ${course?.course_price}$`}
        </Button>
      </div>
    </div>
  );
};

export default Course;
