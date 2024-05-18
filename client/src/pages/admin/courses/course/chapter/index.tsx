import { useState } from "react";
import { styles } from "../../../../../styles/style";
import ReactPlayer from "react-player";

const Chapter = () => {
  const [videoInfo, setCourseInfo] = useState({
    name: "",
    description: "",
    documentFileUrl: "",
    videoUrl: "",
  });
  return (
    <div className="my-10 flex flex-col gap-5 mr-5">
      <h1 className="text-[30px] font-bold">Chapter</h1>
      <div className="flex gap-5">
        <div className="w-1/2">Video</div>
        <div className="w-1/2">List videos</div>
      </div>
      <div className="flex flex-col gap-5">
        <p className="text-[20px] font-bold">Add video</p>
        <div>
          <p className="text-[20px]">Title</p>
          <input
            type="text"
            name="benefit"
            placeholder="You will be able to build a full stack LMS Platform..."
            required
            className={`${styles.input} my-2`}
          />
        </div>
        <div className="w-full flex flex-col gap-2">
          <label className={`${styles.label} w-[50%] text-[20px]`}>
            Video Url
          </label>
          <input
            type="file"
            accept="video/*"
            name="videoUrl"
            id="videoUrl"
            className="hidden"
            onChange={(e) => {}}
          />
          <label
            htmlFor="videoUrl"
            className={
              "w-full min-h-[10vh] dark:border-white border-[#00000026] p-3 border flex items-center justify-center bg-transparent"
            }
          >
            {videoInfo.videoUrl ? (
              <ReactPlayer
                url={videoInfo.videoUrl}
                controls
                width="100%"
                height="auto"
              />
            ) : (
              <span className="text-black dark:text-white">
                click here to upload your video
              </span>
            )}
          </label>
        </div>
        <div className="w-full flex flex-col gap-2">
          <label className={`${styles.label} text-[20px] w-[50%]`}>Document File</label>
          <input
            type="file"
            accept="*"
            name="documentFileUrl"
            id="documentFileUrl"
            className="hidden"
            onChange={(e) => {}}
          />
          <label
            htmlFor="documentFileUrl"
            className={
              "w-full min-h-[10vh] dark:border-white border-[#00000026] p-3 border flex items-center justify-center bg-transparent"
            }
          >
            {videoInfo.documentFileUrl ? (
              <div>video url</div>
            ) : (
              <span className="text-black dark:text-white">
                click here to upload your file
              </span>
            )}
          </label>
        </div>
      </div>
    </div>
  );
};

export default Chapter;
