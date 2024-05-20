import { ChangeEvent, useState } from "react";
import { styles } from "../../../styles/style";
import {
  useCreateCourseMutation,
  useGetCategoriesQuery,
} from "../../../redux/features/courses/coursesApi";
import { AiOutlinePlusCircle } from "react-icons/ai";
import ReactPlayer from "react-player";
import {
  useUploadImageMutation,
  useUploadVideoMutation,
} from "../../../redux/features/upload/uploadApi";
import Loader from "../../../components/Loader/Loader";
import toast from "react-hot-toast";
import { useNavigate } from "react-router-dom";

const CreateCourse = () => {
  const [createCourse, { isLoading: isLoadingCreateCourse }] =
    useCreateCourseMutation();
  const [loadingUploadFile, setLoadingUploadFile] = useState<
    "thumbnail" | "demoUrl" | ""
  >("");

  const navigate = useNavigate();
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
  const { data: categoriesRes } = useGetCategoriesQuery({});
  const [benefits, setBenefits] = useState<string[]>([""]);
  const [lessionContents, setLessionContents] = useState<string[]>([""]);
  const [uploadImage] = useUploadImageMutation();
  const [uploadVideo] = useUploadVideoMutation();
  const categories: CategoryType[] = categoriesRes?.data;

  const handleSubmit = async () => {
    try {
      const transferData = {
        course_name: courseInfo.name,
        course_type: courseInfo.category,
        course_description: courseInfo.description,
        course_thumnail: courseInfo.thumbnail,
        course_demoVideo: courseInfo.demoUrl,
        course_benefits: benefits,
        course_lessonContent: lessionContents,
        course_price: Number(courseInfo.price),
      };
      await createCourse(transferData);
      toast.success("create video successfully");
      navigate("/admin");
    } catch (error) {
      console.log({ error });
      toast.success("create video failed");
    }
  };

  const handleUploadSingleFile = async (
    file: File,
    name: "thumbnail" | "demoUrl" = "demoUrl"
  ) => {
    try {
      let result: string;
      if (name === "demoUrl") {
        setLoadingUploadFile("demoUrl");
        const formData = new FormData();
        formData.append("video", file);
        const rs: any = await uploadVideo(formData);
        result = rs?.data?.data;
      } else {
        setLoadingUploadFile("thumbnail");
        const formData = new FormData();
        formData.append("imgaes", file);
        const rs: any = await uploadImage(formData);
        result = rs?.data?.data;
      }
      setCourseInfo({ ...courseInfo, [name]: result as string });
      setLoadingUploadFile("");
    } catch (error) {
      toast.error("Error uploading file");
      setLoadingUploadFile("");
    }
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

  const onChangeCourseInfo = async (
    e: ChangeEvent<HTMLInputElement | HTMLTextAreaElement | HTMLSelectElement>
  ) => {
    const { name, value } = e.target;
    const { files } = (e as ChangeEvent<HTMLInputElement>).target;
    const file = files?.[0];
    if (file) {
      await handleUploadSingleFile(file, name as "thumbnail" | "demoUrl");
      return;
    }
    setCourseInfo({ ...courseInfo, [name]: value });
  };

  return isLoadingCreateCourse ? (
    <Loader />
  ) : (
    <div className="w-[80%] m-auto mt-24">
      <form onSubmit={handleSubmit} className={`${styles.label}`}>
        <div>
          <label htmlFor="">Tên khóa học</label>
          <input
            type="text"
            name="name"
            required
            value={courseInfo.name}
            onChange={(e) => onChangeCourseInfo(e)}
            id="name"
            placeholder="Nhập tên khóa học"
            className={`
            ${styles.input}`}
          />
        </div>
        <br />
        <div className="mb-5">
          <label className={`${styles.label}`}>Chi tiết khóa học</label>
          <textarea
            name="description"
            id="description"
            cols={30}
            rows={8}
            placeholder="Viết một cái gì đó tuyệt vời ..."
            className={`${styles.input} !h-min !py-2`}
            value={courseInfo.description}
            onChange={(e) => onChangeCourseInfo(e)}
          ></textarea>
        </div>
        <div className="w-full flex gap-3 justify-between">
          <div className="w-[45%]">
            <label className={`${styles.label}`}>Giá</label>
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
              Danh mục
            </label>
            <select
              name="category"
              id="category"
              className={`${styles.input}`}
              value={courseInfo.category}
              onChange={(e) => onChangeCourseInfo(e)}
            >
              <option className="text-black" value="">
                Chọn danh mục
              </option>
              {categories?.length &&
                categories.map((item: CategoryType) => (
                  <option
                    className="text-black"
                    value={item._id}
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
          <label className={`${styles.label} w-[50%]`}>Video giới thiệu</label>
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
            className={
              "w-full min-h-[10vh] dark:border-white border-[#00000026] p-3 border flex items-center justify-center bg-transparent"
            }
          >
            {loadingUploadFile === "demoUrl" ? (
              <div className="loader"></div>
            ) : courseInfo.demoUrl ? (
              <ReactPlayer
                url={courseInfo.demoUrl}
                controls
                width="100%"
                height="auto"
              />
            ) : (
              <span className="text-black dark:text-white">
                Kéo và thả video của bạn vào đây hoặc nhấp để duyệt
              </span>
            )}
          </label>
        </div>
        <br />
        <div className="w-full flex flex-col gap-2">
          <label className={`${styles.label} w-[50%]`}>Ảnh Khóa học</label>
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
            className={
              "w-full min-h-[10vh] dark:border-white border-[#00000026] p-3 border flex items-center justify-center bg-transparent"
            }
          >
            {loadingUploadFile === "thumbnail" ? (
              <div className="loader"></div>
            ) : courseInfo.thumbnail ? (
              <img
                src={courseInfo.thumbnail}
                alt="thumbnail"
                className="max-h-full w-full object-cover"
              />
            ) : (
              <span className="text-black dark:text-white">
                Kéo và thả video của bạn vào đây hoặc nhấp để duyệt
              </span>
            )}
          </label>
        </div>
        <br />
        <div>
          <label className={`${styles.label} text-[20px]`} htmlFor="email">
          Lợi ích gì đối với sinh viên trong khóa học này?
          </label>
          <br />
          {benefits.map((benefit: string, index: number) => (
            <input
              type="text"
              key={index}
              name="benefit"
              placeholder="Bạn sẽ có khả năng xây dựng một nền tảng LMS toàn diện..."
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
            Nội dung từng phân
          </label>
          <br />
          {lessionContents.map((item: string, index: number) => (
            <input
              type="text"
              key={index}
              name="lessionContent"
              placeholder="Vui lòng nhập nội dung"
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
            value="Gửi"
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
