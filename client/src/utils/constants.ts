export enum ROUTE {
  COURSES = "/courses",
  COURSE = "/course/:id",
  LECTURE = "/course/:id/lecture/:lecture_id",
  ABOUT = "/about",
  POLICY = "/policy",
  ADMIN = "/admin",
  CREATE_COURSE = "/admin/create-course",
  LIST_COURSE_BY_TEACHER = "/admin/courses",
  COURSE_BY_TEACHER = "/admin/course/:id",
  COURSE_CHAPTER = "/admin/course/:id/chapter/:chapter_id",
}
