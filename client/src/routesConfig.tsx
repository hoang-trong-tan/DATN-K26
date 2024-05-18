/* eslint-disable react-refresh/only-export-components */
import { lazy, LazyExoticComponent, ReactNode, Suspense } from "react";
import Loader from "./components/Loader/Loader";
import DefaultLayout from "./layout/default";
import AdminLayout from "./layout/admin";
import { ROUTE } from "./utils/constants";
// import CoursesByTeacher from "./pages/admin/course";

const Courses = lazy(() => import("./pages/courses"));
const HomePage = lazy(() => import("./pages/home"));
const Course = lazy(() => import("./pages/course"));
const Lecture = lazy(() => import("./pages/lecture"));
const About = lazy(() => import("./pages/about"));
const Policy = lazy(() => import("./pages/policy"));
const Admin = lazy(() => import("./pages/admin"));
const CreateCourse = lazy(() => import("./pages/admin/CreateCourse"));
const CoursesByTeacher = lazy(() => import("./pages/admin/courses"));
const CourseByTeacher = lazy(() => import("./pages/admin/courses/course"));
const Chapter = lazy(() => import("./pages/admin/courses/course/chapter"));
const getSuspenseElement = (
  Component: LazyExoticComponent<() => JSX.Element>
) => {
  return (
    <Suspense fallback={<Loader />}>
      <Component />
    </Suspense>
  );
};
export type RouteConfigType = {
  path?: string;
  element: ReactNode;
  index?: boolean;
  children?: RouteConfigType[];
};

const routesConfig: RouteConfigType[] = [
  {
    path: "/",
    element: <DefaultLayout />,
    children: [
      {
        index: true,
        element: getSuspenseElement(HomePage),
      },
      {
        path: ROUTE.COURSES,
        element: getSuspenseElement(Courses),
      },
      {
        path: ROUTE.COURSE,
        element: getSuspenseElement(Course),
      },
      {
        path: ROUTE.LECTURE,
        element: getSuspenseElement(Lecture),
      },
      {
        path: ROUTE.ABOUT,
        element: getSuspenseElement(About),
      },
      {
        path: ROUTE.POLICY,
        element: getSuspenseElement(Policy),
      },
      {
        path: "*",
        element: <div>Not found</div>,
      },
    ],
  },
  {
    path: "/admin",
    element: <AdminLayout />,
    children: [
      {
        index: true,
        element: getSuspenseElement(Admin),
      },
      {
        path: ROUTE.CREATE_COURSE,
        element: getSuspenseElement(CreateCourse),
      },
      {
        path: ROUTE.LIST_COURSE_BY_TEACHER,
        element: getSuspenseElement(CoursesByTeacher),
      },
      {
        path: ROUTE.COURSE_BY_TEACHER,
        element: getSuspenseElement(CourseByTeacher),
      },
      {
        path: ROUTE.COURSE_BY_TEACHER,
        element: getSuspenseElement(CourseByTeacher),
      },
      {
        path: ROUTE.COURSE_CHAPTER,
        element: getSuspenseElement(Chapter),
      },
      {
        path: "*",
        element: <div>Not found</div>,
      },
    ],
  },
];

export default routesConfig;
