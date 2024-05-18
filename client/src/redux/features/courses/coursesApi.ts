import { apiSlice } from "../api/apiSlice";

export const coursesApi = apiSlice.injectEndpoints({
  endpoints: (builder) => ({
    createCourse: builder.mutation({
      query: (data) => ({
        url: "course/create-course",
        method: "POST",
        body: data,
        // credentials: "include" as const,
      }),
    }),
    getAllCourses: builder.query({
      query: () => ({
        url: "course/get-all-course",
        method: "GET",
      }),
    }),
    getAllCoursesByTeacher: builder.query({
      query: (id: string) => ({
        url: "user/all-course-teacher/" + id,
        method: "GET",
      }),
    }),
    getCourseDetails: builder.query({
      query: (id: string) => ({
        url: `course/get-one-course/${id}`,
        method: "GET",
      }),
    }),
    getCourseDetailsPurchase: builder.query({
      query: (id: string) => ({
        url: `course/get-one-course/learn/${id}`,
        method: "GET",
        headers: {
          "x-client-id": localStorage.getItem("user_id") || "",
          "x-atoken-id": localStorage.getItem("access_token") || "",
        },
      }),
    }),
    getLectureVideo: builder.query({
      query: (id: string) => ({
        url: `course/get-one-video/${id}`,
        method: "GET",
      }),
    }),
    getCategories: builder.query({
      query: () => ({
        url: "course/get-all-course-type",
        method: "GET",
      }),
    }),
    createChapters: builder.mutation({
      query: (data) => {
        console.log({ data });
        return {
          url: "course/create-course-data/" + data.id,
          method: "POST",
          body: data.payload,
        };
      },
    }),
    listChaptersByCourseId: builder.query({
      query: (id) => {
        return {
          url: "course/get-all-course-data/" + id,
          method: "GET",
          headers: {
            "x-client-id": localStorage.getItem("user_id") || "",
            "x-atoken-id": localStorage.getItem("access_token") || "",
          },
        };
      },
    }),
    getChapterContents: builder.query({
      query: (id) => {
        return {
          url: "course/get-all-course-data/" + id,
          method: "GET",
          headers: {
            "x-client-id": localStorage.getItem("user_id") || "",
            "x-atoken-id": localStorage.getItem("access_token") || "",
          },
        };
      },
    }),
    deleteChapter: builder.mutation({
      query: (id) => {
        return {
          url: "course/delete-course-data/" + id,
          method: "DELETE",
          headers: {
            "x-client-id": localStorage.getItem("user_id") || "",
            "x-atoken-id": localStorage.getItem("access_token") || "",
          },
        };
      },
    }),
  }),
});

export const {
  useCreateCourseMutation,
  useGetAllCoursesQuery,
  useGetCourseDetailsQuery,
  useGetCourseDetailsPurchaseQuery,
  useGetLectureVideoQuery,
  useGetCategoriesQuery,
  useGetAllCoursesByTeacherQuery,
  useCreateChaptersMutation,
  useListChaptersByCourseIdQuery,
  useDeleteChapterMutation,
  useGetChapterContentsQuery,
} = coursesApi;
