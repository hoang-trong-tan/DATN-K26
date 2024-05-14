import { useParams } from "react-router-dom";
import {
  useGetCourseDetailsPurchaseQuery,
  useGetLectureVideoQuery,
} from "../../redux/features/courses/coursesApi";
import { CourseType } from "../course";
import CourseContentList from "../courses/components/CourseContentList";
import Loader from "../../components/Loader/Loader";
import ReactPlayer from "react-player";

const CourseContentMedia = () => {
  const { id, lecture_id } = useParams();

  const { data: courseRes, isLoading: isLoadingCourse } =
    useGetCourseDetailsPurchaseQuery(id as string);
  const { data: lectureRes } = useGetLectureVideoQuery(lecture_id as string);
  if (!courseRes || !lectureRes) {
    return <div>Not found</div>;
  }

  const course: CourseType = courseRes?.data;
  const videoUrl: string = lectureRes?.data?.video_url || "";
  return isLoadingCourse ? (
    <Loader />
  ) : (
    <div className="flex mb-5 gap-10 my-10">
      <div className="w-[70%]">
        <ReactPlayer url={videoUrl} controls width="100%" height="auto" />
      </div>
      <div>
        {course?.course_data && <CourseContentList data={course.course_data} />}
      </div>
    </div>
  );
};

export default CourseContentMedia;
