import Loader from "../../components/Loader/Loader";
import { useGetAllCoursesQuery } from "../../redux/features/courses/coursesApi";
import CourseCard, { CourseCardType } from "./components/CourseCard";

const Courses = () => {
  const { isLoading, data } = useGetAllCoursesQuery(
    {},
    { refetchOnMountOrArgChange: true }
  );
  const courses: CourseCardType[] = data?.data;
  return isLoading ? (
    <Loader />
  ) : (
    <div className="grid grid-cols-1 gap-[20px] md:grid-cols-2 md:gap-[25px] lg:grid-cols-3 lg:gap-[25px] 1500px:grid-cols-4 1500px:gap-[35px] my-12 border-0">
      {courses &&
        courses.map((item: CourseCardType, index: number) => (
          <CourseCard item={item} key={index} />
        ))}
    </div>
  );
};

export default Courses;
