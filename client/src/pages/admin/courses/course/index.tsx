import { useLocation, useNavigate, useParams } from "react-router-dom";
import {
  useCreateChaptersMutation,
  useDeleteChapterMutation,
  useGetCourseDetailsQuery,
  useListChaptersByCourseIdQuery,
} from "../../../../redux/features/courses/coursesApi";
import { CourseType } from "../../../course";
import { styles } from "../../../../styles/style";
import { AiOutlinePlusCircle, AiOutlineDelete } from "react-icons/ai";
import { useState } from "react";
import toast from "react-hot-toast";
import { Button } from "../../../../components/ui/Button";

const CourseByTeacher = () => {
  const { id } = useParams();
  const location = useLocation();

  const [courseChapters, setCourseChapters] = useState<string[]>([""]);
  const [addChapterError, setAddChapterError] = useState("");
  const { data: courseRes } = useGetCourseDetailsQuery(id as string);
  const course: CourseType = courseRes?.data;
  const navigate = useNavigate();
  const { data: listChaptersRes, refetch: refetchChapters } =
    useListChaptersByCourseIdQuery(id as string);
  const [deleteChapter] = useDeleteChapterMutation();
  const [createChapters] = useCreateChaptersMutation();
  const handleCreateChapterChange = (index: number, value: string) => {
    const updatedChapters = [...courseChapters];
    updatedChapters[index] = value;
    setCourseChapters(updatedChapters);
  };
  const handleAddBenefit = () => {
    if (courseChapters.includes("")) {
      setAddChapterError(
        "You need to fill blank field above before add new chapter"
      );
      return;
    }
    setAddChapterError("");
    setCourseChapters([...courseChapters, ""]);
  };
  const onSubmitCreateChapters = async () => {
    try {
      console.log({ id });
      const formatCreateChapterPayload = courseChapters.map((item) => ({
        courseData_title: item,
      }));
      await createChapters({
        id,
        payload: formatCreateChapterPayload,
      });
      await refetchChapters();
      setCourseChapters([""]);
      toast.success("Create chapters successfully");
    } catch (error) {
      toast.error("Error when create chapters");
    }
  };
  const handleDeleteChapter = async (id: string) => {
    try {
      await deleteChapter(id);
      await refetchChapters();
      toast.success("Success delete chapter");
    } catch (error) {
      toast.error("Error delete chapter");
    }
  };
  return (
    <div className="my-10 flex flex-col gap-5 mr-5">
      <h1 className="text-[40px] font-bold">{course?.course_name}</h1>
      <div className="flex gap-10">
        <div className="w-[50%]">
          <label className={`${styles.label} text-[25px] font-bold`}>
            Add Chapters
          </label>
          <br />
          {courseChapters.map((benefit: string, index: number) => (
            <input
              type="text"
              key={index}
              name="benefit"
              placeholder="You will be able to build a full stack LMS Platform..."
              required
              className={`${styles.input} my-2`}
              value={benefit}
              onChange={(e) => {
                setAddChapterError("");
                handleCreateChapterChange(index, e.target.value);
              }}
            />
          ))}
          <div className="flex justify-between mt-2">
            <div className="flex gap-5 items-center">
              <AiOutlinePlusCircle
                className="mt-[2px] cursor-pointer w-[30px] h-[30px]"
                onClick={handleAddBenefit}
              />
              {addChapterError && (
                <p className="text-red-400">{addChapterError}</p>
              )}
            </div>
            <Button className="w-[100px]" onClick={onSubmitCreateChapters}>
              Submit
            </Button>
          </div>
        </div>
        <div className="w-[50%]">
          <label className={`${styles.label} text-[25px] font-bold`}>
            List Chapters
          </label>
          <div className="flex flex-col gap-5 mt-3 ">
            {listChaptersRes?.data?.map((item: any, index: number) => (
              <div
                className="flex justify-between hover:cursor-pointer hover:opacity-80"
                onClick={() => {
                  navigate(`${location.pathname}/chapter/${item?._id}`);
                }}
              >
                <p>
                  - Chapter {index + 1}: {item?.courseData_title}
                </p>
                <AiOutlineDelete
                  className="w-[30px] h-[30px] cursor-pointer"
                  onClick={async (e) => {
                    e.stopPropagation();
                    await handleDeleteChapter(item?._id);
                  }}
                />
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
};

export default CourseByTeacher;
