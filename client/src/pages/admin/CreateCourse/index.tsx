import { ChangeEvent, useState, DragEvent } from "react";
import { styles } from "../../../styles/style";
import { useGetCategoriesQuery } from "../../../redux/features/courses/coursesApi";
import { AiOutlinePlusCircle } from "react-icons/ai";
import ReactPlayer from "react-player";

// import { useCreateCourseMutation } from "../../../../redux/features/courses/coursesApi";
// import { toast } from "react-hot-toast";
// import { redirect } from "react-router-dom";

const CreateCourse = () => {
  //   const [createCourse, { isLoading, isSuccess, error }] =
  //     useCreateCourseMutation();

  //   useEffect(() => {
  //     if (isSuccess) {
  //       toast.success("Course created successfully");
  //       redirect("/admin/courses");
  //     }
  //     if (error) {
  //       if ("data" in error) {
  //         const errorMessage = error as any;
  //         toast.error(errorMessage.data.message);
  //       }
  //     }
  //   }, [isSuccess, error]);
  type CategoryType = {
    _id: string;
    type_name: string;
  };

  const [courseInfo, setCourseInfo] = useState({
    name: "",
    description: "",
    price: "",
    category: "",
    demoUrl: "",
    thumbnail: "",
  });
  const [dragging, setDragging] = useState<"demoUrl" | "thumbnail" | "">("");
  const { data: categoriesRes } = useGetCategoriesQuery({});
  const [benefits, setBenefits] = useState<string[]>([""]);
  const [lessionContents, setLessionContents] = useState<string[]>([""]);

  const categories: CategoryType[] = categoriesRes?.data;
  //   const { data } = useGetHeroDataQuery("Categories", {});
  //   const [categories, setCategories] = useState([]);

  //   useEffect(() => {
  //     if (data) {
  //       setCategories(data.layout?.categories);
  //     }
  //   }, [data]);

  const handleDragOver = (e: DragEvent<HTMLLabelElement>) => {
    e.preventDefault();
    const name = (e.target as any)?.htmlFor;
    setDragging(name);
  };
  const handleDragLeave = (e: DragEvent<HTMLLabelElement>) => {
    e.preventDefault();
    setDragging("");
  };
  const handleDrop = (e: DragEvent<HTMLLabelElement>) => {
    e.preventDefault();
    setDragging("");
    const name = (e.target as any)?.htmlFor;
    const file = e.dataTransfer.files?.[0];
    if (file) {
      handleUploadSingleFile(file, name);
    }
  };

  const handleSubmit = () => {};

  const handleUploadSingleFile = (file: File, name = "") => {
    const reader = new FileReader();

    reader.onload = () => {
      console.log({ name, result: reader.result });
      setCourseInfo({ ...courseInfo, [name]: reader.result as string });
    };
    reader.readAsDataURL(file);
  };

  const handleBenefitChange = (index: number, value: string) => {
    const updatedBenefits = [...benefits];
    updatedBenefits[index] = value;
    setBenefits(updatedBenefits);
  };
  const handleAddBenefit = () => {
    setBenefits([...benefits, ""]);
  };
  const handleLessionContentsChange = (index: number, value: string) => {
    const updatedLessionContents = [...lessionContents];
    updatedLessionContents[index] = value;
    setLessionContents(updatedLessionContents);
  };

  const handleAddLessionContents = () => {
    setLessionContents([...lessionContents, ""]);
  };

  const onChangeCourseInfo = (
    e: ChangeEvent<HTMLInputElement | HTMLTextAreaElement | HTMLSelectElement>
  ) => {
    const { name, value } = e.target;
    const { files } = (e as ChangeEvent<HTMLInputElement>).target;
    const file = files?.[0];
    if (file) {
      handleUploadSingleFile(file, name);
      return;
    }
    setCourseInfo({ ...courseInfo, [name]: value });
  };

  return (
    <div className="w-[80%] m-auto mt-24">
      <form onSubmit={handleSubmit} className={`${styles.label}`}>
        <div>
          <label htmlFor="">Course Name</label>
          <input
            type="text"
            name="name"
            required
            value={courseInfo.name}
            onChange={(e) => onChangeCourseInfo(e)}
            id="name"
            placeholder="Enter course name"
            className={`
            ${styles.input}`}
          />
        </div>
        <br />
        <div className="mb-5">
          <label className={`${styles.label}`}>Course Description</label>
          <textarea
            name="description"
            id="description"
            cols={30}
            rows={8}
            placeholder="Write something amazing..."
            className={`${styles.input} !h-min !py-2`}
            value={courseInfo.description}
            onChange={(e) => onChangeCourseInfo(e)}
          ></textarea>
        </div>
        <div className="w-full flex gap-3 justify-between">
          <div className="w-[45%]">
            <label className={`${styles.label}`}>Course Price</label>
            <input
              type="number"
              name="price"
              required
              value={courseInfo.price}
              onChange={(e) => onChangeCourseInfo(e)}
              id="price"
              placeholder="29"
              className={`
            ${styles.input}`}
            />
          </div>
          <div className="w-[50%]">
            <label className={`${styles.label} w-[50%]`}>
              Course Categories
            </label>
            <select
              name="category"
              id="category"
              className={`${styles.input}`}
              value={courseInfo.category}
              onChange={(e) => onChangeCourseInfo(e)}
            >
              <option className="text-black" value="">
                Select Category
              </option>
              {categories?.length &&
                categories.map((item: CategoryType) => (
                  <option
                    className="text-black"
                    value={item.type_name}
                    key={item._id}
                  >
                    {item.type_name}
                  </option>
                ))}
            </select>
          </div>
        </div>
        <br />
        <div className="w-full flex flex-col gap-2">
          <label className={`${styles.label} w-[50%]`}>Demo Url</label>
          <input
            type="file"
            accept="video/*"
            name="demoUrl"
            id="demoUrl"
            className="hidden"
            onChange={(e) => onChangeCourseInfo(e)}
          />
          <label
            htmlFor="demoUrl"
            className={`w-full min-h-[10vh] dark:border-white border-[#00000026] p-3 border flex items-center justify-center ${
              dragging === "demoUrl" ? "bg-blue-500" : "bg-transparent"
            }`}
            onDragOver={handleDragOver}
            onDragLeave={handleDragLeave}
            onDrop={handleDrop}
          >
            {courseInfo.demoUrl ? (
              <ReactPlayer
                url={courseInfo.demoUrl}
                controls
                width="100%"
                height="auto"
              />
            ) : (
              <span className="text-black dark:text-white">
                Drag and drop your video here or click to browse
              </span>
            )}
          </label>
        </div>
        <br />
        <div className="w-full flex flex-col gap-2">
          <label className={`${styles.label} w-[50%]`}>Thumbnail</label>
          <input
            type="file"
            accept="image/*"
            name="thumbnail"
            id="thumbnail"
            className="hidden"
            onChange={(e) => onChangeCourseInfo(e)}
          />
          <label
            htmlFor="thumbnail"
            className={`w-full min-h-[10vh] dark:border-white border-[#00000026] p-3 border flex items-center justify-center ${
              dragging === "thumbnail" ? "bg-blue-500" : "bg-transparent"
            }`}
            onDragOver={handleDragOver}
            onDragLeave={handleDragLeave}
            onDrop={handleDrop}
          >
            {courseInfo.thumbnail ? (
              <img
                src={courseInfo.thumbnail}
                alt="thumbnail"
                className="max-h-full w-full object-cover"
              />
            ) : (
              <span className="text-black dark:text-white">
                Drag and drop your thumbnail here or click to browse
              </span>
            )}
          </label>
        </div>
        <br />
        <div>
          <label className={`${styles.label} text-[20px]`} htmlFor="email">
            What are the benefits for students in this course?
          </label>
          <br />
          {benefits.map((benefit: string, index: number) => (
            <input
              type="text"
              key={index}
              name="benefit"
              placeholder="You will be able to build a full stack LMS Platform..."
              required
              className={`${styles.input} my-2`}
              value={benefit}
              onChange={(e) => handleBenefitChange(index, e.target.value)}
            />
          ))}
          <AiOutlinePlusCircle
            style={{ margin: "10px 0px", cursor: "pointer", width: "30px" }}
            onClick={handleAddBenefit}
          />
        </div>
        <div>
          <label className={`${styles.label} text-[20px]`} htmlFor="email">
            Lession contents
          </label>
          <br />
          {lessionContents.map((item: string, index: number) => (
            <input
              type="text"
              key={index}
              name="lessionContent"
              placeholder="Fill lession content here"
              required
              className={`${styles.input} my-2`}
              value={item}
              onChange={(e) =>
                handleLessionContentsChange(index, e.target.value)
              }
            />
          ))}
          <AiOutlinePlusCircle
            style={{ margin: "10px 0px", cursor: "pointer", width: "30px" }}
            onClick={handleAddLessionContents}
          />
        </div>
        <div className="w-full flex items-center justify-end">
          <input
            type="submit"
            value="Submit"
            className="w-full 800px:w-[180px] h-[40px] bg-[#37a39a] text-center text-[#fff] rounded mt-8 cursor-pointer"
          />
        </div>
        <br />
        <br />
      </form>
    </div>
  );
};

export default CreateCourse;
