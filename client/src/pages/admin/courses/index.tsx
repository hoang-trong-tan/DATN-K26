import { useSelector } from "react-redux";
import { useGetAllCoursesByTeacherQuery } from "../../../redux/features/courses/coursesApi";
import CourseCard, {
  CourseCardType,
} from "../../courses/components/CourseCard";
import Loader from "../../../components/Loader/Loader";

const CoursesByTeacher = () => {
  const { user: userId } = useSelector((state: any) => state.auth);

  const { isLoading, data } = useGetAllCoursesByTeacherQuery(userId, {
    refetchOnMountOrArgChange: true,
  });
  const courses: CourseCardType[] = data?.data;
  return isLoading ? (
    <Loader />
  ) : (
    <div className="grid grid-cols-1 gap-[20px] px-10 md:grid-cols-2 md:gap-[25px] lg:grid-cols-3 lg:gap-[25px] 1500px:grid-cols-4 1500px:gap-[35px] my-12 border-0">
      {courses &&
        courses.map((item: CourseCardType, index: number) => (
          <CourseCard item={item} key={index} isOwn/>
        ))}
    </div>
  );
};

export default CoursesByTeacher;
