import { FC, useState } from "react";
import { BsChevronDown, BsChevronUp } from "react-icons/bs";
import { MdOutlineOndemandVideo } from "react-icons/md";
import { CourseDataType } from "../../course";
import { convertNumberToTextTime } from "../../../utils";
import { useLocation, useNavigate, useParams } from "react-router-dom";

type Props = {
  data: CourseDataType[];
  setVideoUrl?: React.Dispatch<React.SetStateAction<string>>;
  lecture_id?: string;
};

const CourseContentList: FC<Props> = (props) => {
  const navigate = useNavigate();
  const location = useLocation();
  const { id } = useParams();

  const [visibleSections, setVisibleSections] = useState<Set<string>>(
    new Set<string>()
  );

  // Find unique video sections
  const videoSections: string[] = [
    ...new Set<string>(props.data?.map((item) => item.courseData_title)),
  ];

  let totalCount: number = 0; // Total count of videos from previous sections

  const toggleSection = (section: string) => {
    const newVisibleSections = new Set(visibleSections);
    if (newVisibleSections.has(section)) {
      newVisibleSections.delete(section);
    } else {
      newVisibleSections.add(section);
    }
    setVisibleSections(newVisibleSections);
  };

  return (
    <div className={`w-full flex flex-col gap-8`}>
      {videoSections.map((section: string) => {
        const isSectionVisible = visibleSections.has(section);

        // Filter videos by section
        const sectionVideos = props.data.find(
          (item) => item.courseData_title === section
        )?.course_data_video;

        const sectionVideoCount: number =
          sectionVideos?.course_video?.length || 0; // Number of videos in the current section
        const sectionVideoLength: number =
          sectionVideos?.total_video_section || 0;
        const sectionStartIndex: number = totalCount; // Start index of videos within the current section
        totalCount += sectionVideoCount; // Update the total count of videos

        return (
          <div
            className={
              "border-b border-[#0000001c] dark:border-[#ffffff8e] pb-2"
            }
            key={section}
          >
            <div className="w-full flex">
              <div className="w-full flex justify-between items-center">
                <h2 className="text-[22px] text-black dark:text-white">
                  {section}
                </h2>
                <button
                  className="mr-4 cursor-pointer text-black dark:text-white"
                  onClick={() => toggleSection(section)}
                >
                  {isSectionVisible ? (
                    <BsChevronUp size={20} />
                  ) : (
                    <BsChevronDown size={20} />
                  )}
                </button>
              </div>
            </div>
            <h5 className="text-black dark:text-white">
              {sectionVideoCount} Lessons ·{" "}
              {convertNumberToTextTime(sectionVideoLength)}
            </h5>
            {isSectionVisible && (
              <div className="w-full mt-3">
                {sectionVideos?.course_video?.map((item) => {
                  return (
                    <div
                      className={`w-full ${
                        props.lecture_id === item._id ? "bg-slate-800" : ""
                      } cursor-pointer transition-all p-2`}
                      key={item._id}
                      onClick={() => {
                        if (!item?.video_url) {
                          return;
                        }
                        if (!location.pathname.includes("lecture")) {
                          navigate(`${location.pathname}/lecture/${item._id}`);
                          return;
                        }
                        navigate(`/course/${id}/lecture/${item._id}`);
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
            )}
          </div>
        );
      })}
    </div>
  );
};

export default CourseContentList;
