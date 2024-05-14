import { BrowserRouter, Route, Routes } from "react-router-dom";
import DefaultLayout from "./layout/default";
import { lazy, Suspense } from "react";
import Loader from "./components/Loader/Loader";
import { ROUTE } from "./utils/constants";
import { Providers } from "./Provider";
import AdminLayout from "./layout/admin";

const Courses = lazy(() => import("./pages/courses"));
const HomePage = lazy(() => import("./pages/home"));
const Course = lazy(() => import("./pages/course"));
const Lecture = lazy(() => import("./pages/lecture"));
const About = lazy(() => import("./pages/about"));
const Policy = lazy(() => import("./pages/policy"));
const Admin = lazy(() => import("./pages/admin"));
function App() {
  return (
    <Providers>
      <BrowserRouter>
        <Routes>
          <Route element={<DefaultLayout />}>
            <Route
              index
              element={
                <Suspense fallback={<Loader />}>
                  <HomePage />
                </Suspense>
              }
            />
            <Route
              index
              path={ROUTE.COURSES}
              element={
                <Suspense fallback={<Loader />}>
                  <Courses />
                </Suspense>
              }
            />
            <Route
              index
              path={ROUTE.COURSE}
              element={
                <Suspense fallback={<Loader />}>
                  <Course />
                </Suspense>
              }
            />
            <Route
              index
              path={ROUTE.LECTURE}
              element={
                <Suspense fallback={<Loader />}>
                  <Lecture />
                </Suspense>
              }
            />
            <Route
              index
              path={ROUTE.ABOUT}
              element={
                <Suspense fallback={<Loader />}>
                  <About />
                </Suspense>
              }
            />
            <Route
              index
              path={ROUTE.POLICY}
              element={
                <Suspense fallback={<Loader />}>
                  <Policy />
                </Suspense>
              }
            />
          </Route>
          <Route element={<AdminLayout />}>
            <Route
              index
              path={ROUTE.ADMIN}
              element={
                <Suspense fallback={<Loader />}>
                  <Admin />
                </Suspense>
              }
            />
          </Route>
        </Routes>
      </BrowserRouter>
    </Providers>
  );
}

export default App;
