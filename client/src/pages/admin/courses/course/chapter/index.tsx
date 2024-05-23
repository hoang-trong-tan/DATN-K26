/* eslint-disable react-hooks/rules-of-hooks */
import { ChangeEvent, useEffect, useRef, useState } from "react";
import { styles } from "../../../../../styles/style";
import ReactPlayer from "react-player";
import { useParams } from "react-router-dom";
// import getVideoDurationInSeconds from "get-video-duration";
import {
  useCreateQuizByChapterMutation,
  useCreateQuizTitleMutation,
  useCreateVideoByChapterMutation,
  useGetContentChapterQuery,
  useGetLectureVideoQuery,
  useGetListQuizsQuery,
  useGetQuestionsByChapterQuery,
} from "../../../../../redux/features/courses/coursesApi";
import { Button } from "../../../../../components/ui/Button";
import { MdOutlineOndemandVideo } from "react-icons/md";
import { convertNumberToTextTime } from "../../../../../utils";
import {
  useUploadDocumentMutation,
  useUploadVideoMutation,
} from "../../../../../redux/features/upload/uploadApi";
import toast from "react-hot-toast";
import CheckIcon from "@mui/icons-material/Check";
import ClearIcon from "@mui/icons-material/Clear";
import { AiOutlinePlusCircle } from "react-icons/ai";
type UploadFileType = "video" | "document" | "";
const Chapter = () => {
  const { id: courseId, chapter_id: chapterId } = useParams();
  if (!courseId || !chapterId) {
    return <div>Not found</div>;
  }
  const videoRef = useRef(null);
  const [loadingUploadFile, setLoadingUploadFile] =
    useState<UploadFileType>("");
  const [videoInfo, setVideoInfo] = useState({
    name: "",
    documentFileUrl: "",
    videoUrl: "",
    videoDuration: 0,
  });

  const [question, setQuestion] = useState({
    title: "",
    answers: ["", "", ""],
    correctAnswer: 0,
  });
  const [selectVideo, setSelectVideo] = useState<any>();
  const [selectQuizId, setSelectQuizId] = useState("");
  const [videos, setVideos] = useState<any>();
  const [addQuiz, setAddQuiz] = useState("");
  const { data: chapterContentRes, refetch: refetchChapterContent } =
    useGetContentChapterQuery(chapterId as string);
  const [uploadVideo] = useUploadVideoMutation();
  const [uploadDocument] = useUploadDocumentMutation();
  const [createVideoByChapter] = useCreateVideoByChapterMutation();
  const [createQuizTitle] = useCreateQuizTitleMutation();
  const [createQuizByChapter] = useCreateQuizByChapterMutation();

  const { data: quizsRes, refetch: refetchQuizsTitle } =
    useGetListQuizsQuery(chapterId);
  const { data: questionsRes, refetch: refetchQuestions } =
    useGetQuestionsByChapterQuery(selectQuizId);
  useEffect(() => {
    setSelectVideo(chapterContentRes?.data?.list_video?.[0]);
    setVideos(chapterContentRes?.data?.list_video);
  }, [chapterContentRes?.data?.list_video]);

  const { data: lectureRes, refetch: retechGetLecture } =
    useGetLectureVideoQuery(
      selectVideo?._id ||
        (chapterContentRes?.data?.list_video?.[0]?._id as string)
    );

  const handleUploadFile = async (
    e: ChangeEvent<HTMLInputElement>,
    type: UploadFileType = "video"
  ) => {
    setLoadingUploadFile(type);
    const { files } = e.target;
    const file = files?.[0];
    if (file) {
      let result: string;
      if (type === "video") {
        const formData = new FormData();
        formData.append("video", file);
        const rs: any = await uploadVideo(formData);
        result = rs?.data?.data;
        setVideoInfo({
          ...videoInfo,
          videoUrl: result as string,
        });
        setLoadingUploadFile("");
        return;
      }
      const formData = new FormData();
      formData.append("file", file);
      const rs: any = await uploadDocument({
        formData,
        videoId: selectVideo?._id,
      });
      result = rs?.data?.data;
      setVideoInfo({
        ...videoInfo,
        documentFileUrl: result as string,
      });
      setLoadingUploadFile("");
      retechGetLecture();
      return;
    }
  };
  const handleDuration = (duration: number) => {
    setVideoInfo({ ...videoInfo, videoDuration: duration });
  };

  const handleSubmitAddVideo = async () => {
    try {
      const payload = {
        video_title: videoInfo.name,
        video_url: videoInfo.videoUrl,
        video_length: videoInfo.videoDuration,
      };
      const rs: any = await createVideoByChapter({
        payload: [payload],
        chapterId,
      });
      if (rs?.error) {
        toast.error("Invalid fileds videos");
        return;
      }
      await refetchChapterContent();
      toast.success("Add video successfully");
    } catch (error) {
      toast.error("Add video failed");
    }
  };

  const handleSubmitQuestion = async () => {
    try {
      const payload = {
        quiz_questions: question.title,
        quiz_options: question.answers,
        quiz_correctAnswer: question.correctAnswer,
      };
      if (!selectQuizId) {
        toast.error("Bạn chưa chọn quiz");
        return;
      }
      await createQuizByChapter({ payload, quizId: selectQuizId });
      toast.success("Add question successfully");
      refetchQuestions();
    } catch (error) {
      toast.error("Add question failed");
    }
  };
  const handleAddAnswer = (e: ChangeEvent<HTMLInputElement>, index: number) => {
    const { answers } = question;
    answers[index] = e.target.value;
    setQuestion({ ...question, answers });
  };

  const handleCreateQuizTitle = async () => {
    const payload = {
      quiz_title: addQuiz,
    };
    await createQuizTitle({ payload, chapterId });
    await refetchQuizsTitle();
  };
  return (
    <div className="my-5 flex flex-col gap-5 mr-5">
      <h1 className="text-[35px] font-bold">
        {chapterContentRes?.data?.chapter?.courseData_title}
      </h1>
      <div className="flex gap-5">
        <div className="w-2/3 flex flex-col gap-3">
          <div>
            <ReactPlayer
              url={selectVideo?.video_url}
              controls
              width="100%"
              height="auto"
            />
          </div>
          <div className="flex flex-col gap-3 justify-center">
            <h1 className="text-[20px]">Tài liệu video</h1>
            {lectureRes?.data?.document?.length ? (
              <div>
                {lectureRes?.data?.document?.map((item: any, index: number) => (
                  <div className="ml-3" key={index}>
                    - {item}
                  </div>
                ))}
              </div>
            ) : (
              <div>Không có tài liệu</div>
            )}
            <div className="flex flex-col gap-2">
              <div className="w-full flex flex-col gap-2">
                <label className={`${styles.label} text-[20px] w-[50%]`}>
                  Thêm tài liệu
                </label>
                <input
                  type="file"
                  accept="*"
                  name="documentFileUrl"
                  id="documentFileUrl"
                  className="hidden"
                  onChange={(e) => handleUploadFile(e, "document")}
                />
                <label
                  htmlFor="documentFileUrl"
                  className={
                    "w-full min-h-[10vh] dark:border-white border-[#00000026] p-3 border flex items-center justify-center bg-transparent"
                  }
                >
                  {loadingUploadFile === "document" ? (
                    <div className="loader"></div>
                  ) : (
                    <span className="text-black dark:text-white">
                      Click vào đây để thêm...
                    </span>
                  )}
                </label>
              </div>
            </div>
          </div>
        </div>
        <div className="w-1/3 pr-5 max-w-[400px] overflow-auto">
          <div className="w-[350px]">
            {videos?.map((item: any) => {
              return (
                <div
                  className={`w-full ${
                    selectVideo?.video_url === item.video_url
                      ? "bg-slate-800"
                      : ""
                  } cursor-pointer transition-all p-2`}
                  key={item._id}
                  onClick={() => {
                    setSelectVideo(item);
                  }}
                >
                  <div className="flex items-start">
                    <div>
                      <MdOutlineOndemandVideo
                        size={25}
                        className="mr-2"
                        color="#1cdada"
                      />
                    </div>
                    <h1 className="text-[18px] inline-block break-words text-black dark:text-white">
                      {item.video_title}
                    </h1>
                  </div>
                  <h5 className="pl-8 text-black dark:text-white">
                    {convertNumberToTextTime(item?.video_length)}
                  </h5>
                </div>
              );
            })}
          </div>
        </div>
      </div>
      <div className="flex flex-col gap-3">
        <p className="text-[30px] font-bold">Thêm video</p>
        <div>
          <p className="text-[20px]">Tiêu đề</p>
          <input
            type="text"
            placeholder="Add video title"
            required
            className={`${styles.input} my-2`}
            onChange={(e) => {
              setVideoInfo({ ...videoInfo, name: e.target.value });
            }}
          />
        </div>
        <div className="w-full flex flex-col gap-2">
          <label className={`${styles.label} w-[50%] text-[20px]`}>
            Thêm video
          </label>
          <input
            type="file"
            accept="video/*"
            name="videoUrl"
            id="videoUrl"
            className="hidden"
            onChange={(e) => handleUploadFile(e, "video")}
          />
          <label
            htmlFor="videoUrl"
            className={
              "w-full min-h-[10vh] dark:border-white border-[#00000026] p-3 border flex items-center justify-center bg-transparent"
            }
          >
            {loadingUploadFile === "video" ? (
              <div className="loader"></div>
            ) : videoInfo.videoUrl ? (
              <ReactPlayer
                ref={videoRef}
                url={videoInfo.videoUrl}
                controls
                width="100%"
                height="auto"
                onDuration={handleDuration}
              />
            ) : (
              <span className="text-black dark:text-white">
                Click vào đây để thêm video...
              </span>
            )}
          </label>
        </div>
        <div className="flex justify-end">
          <Button className="w-[100px]" onClick={handleSubmitAddVideo}>
            Thêm
          </Button>
        </div>
        <div className="flex gap-5">
          <div className="w-[50%]">
            <label className={`${styles.label} text-[25px] font-bold`}>
              Tất cả bài kiểm tra
            </label>
            <div className="flex flex-col gap-3 mt-4">
              {quizsRes?.data?.map((item: any) => (
                <p
                  className={`cursor-pointer px-2 py-3 ${
                    selectQuizId === item?._id ? "bg-slate-800" : ""
                  }`}
                  onClick={() => {
                    setSelectQuizId(item?._id);
                    refetchQuestions();
                  }}
                >
                  {item.quiz_Tile}
                </p>
              ))}
            </div>
          </div>
          <div className="flex flex-col gap-3 w-[50%] ">
            <label className={`${styles.label} text-[25px] font-bold`}>
              Tiêu dề bài kiểm tra
            </label>
            <textarea
              placeholder="Thêm tiêu dề bài kiểm tra..."
              className={`${styles.input} min-h-[100px] my-2 py-2`}
              onChange={(event) => {
                setAddQuiz(event.target.value);
              }}
            />
            <div className="flex justify-end">
              <Button
                className="w-[100px]"
                onClick={() => handleCreateQuizTitle()}
              >
                Thêm
              </Button>
            </div>
          </div>
        </div>

        <div className="flex gap-5">
          <div className="flex flex-col gap-3 w-1/2">
            <label className={`${styles.label} w-[50%] text-[25px] font-bold`}>
              Thêm câu hỏi
            </label>
            <div>
              <label className={`${styles.label} w-[50%] text-[18px]`}>
                + Câu hỏi
              </label>
              <textarea
                name="question"
                placeholder="Thêm câu hỏi"
                className={`${styles.input} min-h-[200px] my-2 py-2`}
                onChange={(e) => {
                  setQuestion({ ...question, title: e.target.value });
                }}
              />
            </div>
            <div className="flex gap-5">
              <label className={`${styles.label} text-[18px]`}>+ Câu trả lời</label>
              <div>
                <AiOutlinePlusCircle
                  className="mt-[2px] cursor-pointer w-[30px] h-[30px]"
                  onClick={() => {
                    setQuestion({
                      ...question,
                      answers: [...question.answers, ""],
                    });
                  }}
                />
              </div>
            </div>

            {question.answers.map((_, index) => (
              <div className="flex gap-5 items-center" key={index}>
                <div className="w-[80px]">&#x2022; Trả lời {index + 1}: </div>
                <input
                  type="text"
                  placeholder="Thêm câu trả lời"
                  className={`${styles.input} my-2 w-[300px]`}
                  onChange={(e) => handleAddAnswer(e, index)}
                />
                <div
                  className="cursor-pointer"
                  onClick={() => {
                    setQuestion({ ...question, correctAnswer: index });
                  }}
                >
                  {index === question.correctAnswer ? (
                    <CheckIcon htmlColor="green" />
                  ) : (
                    <ClearIcon htmlColor="red" />
                  )}
                </div>
              </div>
            ))}
            <div>
              <Button
                className="w-[100px]"
                onClick={() => handleSubmitQuestion()}
              >
                Thêm
              </Button>
            </div>
          </div>
          <div>
            <label className={`${styles.label} w-[50%] text-[25px] font-bold`}>
              Tất cả câu trả lời
            </label>
            <div className="flex flex-col mt-4">
              {questionsRes?.data?.map((item: any, index: number) => (
                <div className="flex flex-col gap-3">
                  <p className="font-bold text-[20px]">
                    {index + 1}: {item?.quiz_questions}
                  </p>
                  <div>
                    {item?.quiz_options?.map((e: string) => (
                      <p> - {e}</p>
                    ))}
                  </div>
                  <div>
                    Câu trả lời đúng:{" "}
                    {item?.quiz_options?.[item?.quiz_correctAnswer]}
                  </div>
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Chapter;
