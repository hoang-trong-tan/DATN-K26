import axios from "axios";

const baseURL = "http://52.221.211.77:5000";

export const getOneCourse = async (idOneCourse) => {
    // console.log(idOneCourse);
  try {
    const req = await axios.get(
      `${baseURL}/v1/api/course/get-one-course/${idOneCourse}`
    );
    // console.log(req);
    return req.data
  } catch (error) {
    return null;
  }
  
};
export const getCourseType = async (idCourseType) => {
  try {
    const req = await axios.get(
      `${baseURL}/v1/api/course/get-one-course/${idCourseType}`
    );
    return req.data
  } catch (error) {
    return null;
  }
  
};
