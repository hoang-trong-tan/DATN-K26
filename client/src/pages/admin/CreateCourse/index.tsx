import { useState } from "react";
import CourseInformation from "./CourseInformation";
import { styles } from "../../../styles/style";
import { useGetCategoriesQuery } from "../../../redux/features/courses/coursesApi";
import { AiOutlinePlusCircle } from "react-icons/ai";

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

  const [active, setActive] = useState(0);
  const [courseInfo, setCourseInfo] = useState({
    name: "",
    description: "",
    price: "",
    tags: "",
    level: "",
    category: "",
    demoUrl: "",
    thumbnail: "",
  });
  const [dragging, setDragging] = useState(false);
  const { data: categoriesRes } = useGetCategoriesQuery({});
  const [benefits, setBenefits] = useState([{ title: "" }]);
  const [prerequisites, setPrerequisites] = useState([{ title: "" }]);

  console.log({ categoryRes: categoriesRes });
  const categories: CategoryType[] = categoriesRes?.data;
  //   const { data } = useGetHeroDataQuery("Categories", {});
  //   const [categories, setCategories] = useState([]);

  //   useEffect(() => {
  //     if (data) {
  //       setCategories(data.layout?.categories);
  //     }
  //   }, [data]);
  console.log({ categories });
  const handleSubmit = (e: any) => {
    e.preventDefault();
    setActive(active + 1);
  };

  const handleFileChange = (e: any) => {
    const file = e.target.files?.[0];
    if (file) {
      const reader = new FileReader();

      reader.onload = () => {
        if (reader.readyState === 2) {
          setCourseInfo({ ...courseInfo, thumbnail: reader.result as string });
        }
      };
      reader.readAsDataURL(file);
    }
  };

  const handleDragOver = (e: any) => {
    e.preventDefault();
    setDragging(true);
  };

  const handleDragLeave = (e: any) => {
    e.preventDefault();
    setDragging(false);
  };

  const handleDrop = (e: any) => {
    e.preventDefault();
    setDragging(false);

    const file = e.dataTransfer.files?.[0];

    if (file) {
      const reader = new FileReader();

      reader.onload = () => {
        setCourseInfo({ ...courseInfo, thumbnail: reader.result as string });
      };
      reader.readAsDataURL(file);
    }
  };

  const handleBenefitChange = (index: number, value: any) => {
    const updatedBenefits = [...benefits];
    updatedBenefits[index].title = value;
    setBenefits(updatedBenefits);
  };
  const handleAddBenefit = () => {
    setBenefits([...benefits, { title: "" }]);
  };
  const handlePrerequisitesChange = (index: number, value: any) => {
    const updatedPrerequisites = [...prerequisites];
    updatedPrerequisites[index].title = value;
    setPrerequisites(updatedPrerequisites);
  };

  const handleAddPrerequisites = () => {
    setPrerequisites([...prerequisites, { title: "" }]);
  };

  return (
    <div className="w-[80%] m-auto mt-24">
      <form onSubmit={handleSubmit} className={`${styles.label}`}>
        <div>
          <label htmlFor="">Course Name</label>
          <input
            type="name"
            name=""
            required
            value={courseInfo.name}
            onChange={(e: any) =>
              setCourseInfo({ ...courseInfo, name: e.target.value })
            }
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
            name=""
            id=""
            cols={30}
            rows={8}
            placeholder="Write something amazing..."
            className={`${styles.input} !h-min !py-2`}
            value={courseInfo.description}
            onChange={(e: any) =>
              setCourseInfo({ ...courseInfo, description: e.target.value })
            }
          ></textarea>
        </div>
        <div className="w-full flex gap-3 justify-between">
          <div className="w-[45%]">
            <label className={`${styles.label}`}>Course Price</label>
            <input
              type="number"
              name=""
              required
              value={courseInfo.price}
              onChange={(e: any) =>
                setCourseInfo({ ...courseInfo, price: e.target.value })
              }
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
              name=""
              id=""
              className={`${styles.input}`}
              value={courseInfo.category}
              onChange={(e: any) =>
                setCourseInfo({ ...courseInfo, category: e.target.value })
              }
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
        <div className="w-full flex justify-between"></div>
        <div className="w-full justify-between">
          <label className={`${styles.label} w-[50%]`}>Demo Url</label>
          <input
            type="text"
            name=""
            required
            value={courseInfo.demoUrl}
            onChange={(e) =>
              setCourseInfo({ ...courseInfo, demoUrl: e.target.value })
            }
            id="demoUrl"
            placeholder="eer74fd"
            className={`
            ${styles.input}`}
          />
        </div>
        <br />
        <div className="w-full">
          <input
            type="file"
            accept="image/*"
            id="file"
            className="hidden"
            onChange={handleFileChange}
          />
          <label
            htmlFor="file"
            className={`w-full min-h-[10vh] dark:border-white border-[#00000026] p-3 border flex items-center justify-center ${
              dragging ? "bg-blue-500" : "bg-transparent"
            }`}
            onDragOver={handleDragOver}
            onDragLeave={handleDragLeave}
            onDrop={handleDrop}
          >
            {courseInfo.thumbnail ? (
              <img
                src={courseInfo.thumbnail}
                alt=""
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
          {benefits.map((benefit: any, index: number) => (
            <input
              type="text"
              key={index}
              name="Benefit"
              placeholder="You will be able to build a full stack LMS Platform..."
              required
              className={`${styles.input} my-2`}
              value={benefit.title}
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
            What are the prerequisites for starting this course?
          </label>
          <br />
          {prerequisites.map((prerequisites: any, index: number) => (
            <input
              type="text"
              key={index}
              name="prerequisites"
              placeholder="You need basic knowledge of MERN stack"
              required
              className={`${styles.input} my-2`}
              value={prerequisites.title}
              onChange={(e) => handlePrerequisitesChange(index, e.target.value)}
            />
          ))}
          <AiOutlinePlusCircle
            style={{ margin: "10px 0px", cursor: "pointer", width: "30px" }}
            onClick={handleAddPrerequisites}
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
