import { useParams } from "react-router-dom";
import { useGetCourseDetailsPurchaseQuery } from "../../redux/features/courses/coursesApi";
import { CourseType } from "../course";
import CourseContentList from "../courses/components/CourseContentList";
import { useState } from "react";

const CourseContentMedia = () => {
  const { id, lecture_id } = useParams();
  const [videoUrl, setVideoUrl] = useState("");

  const { data } = useGetCourseDetailsPurchaseQuery(id as string);

  if (!data) {
    return <div>Not found</div>;
  }

  const course: CourseType = data?.data;
  console.log({ course });
  return (
    <div className="flex mb-5 gap-10">
      <div className="w-[70%]">
        <video controls className="w-full h-auto">
          <source src={videoUrl} type="video/mp4" />
        </video>
      </div>
      <div>
        {course?.course_data && (
          <CourseContentList
            data={course.course_data}
            setVideoUrl={setVideoUrl}
            lecture_id={lecture_id}
          />
        )}
      </div>
    </div>
  );
};

export default CourseContentMedia;
