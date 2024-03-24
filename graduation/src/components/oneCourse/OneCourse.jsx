import React, { useEffect, useState } from "react";
import { getOneCourse } from "../../api";
import { useStateValue } from "../../Context/StateProvider";
import { actionType } from "../../Context/reducer";
import ReactPlayer from "react-player";
import { convertToTime } from "../../utils/convertToTime";

import { useNavigate } from "react-router-dom";

export default function OneCourse() {
  const [{ oneCourse }, dispatch] = useStateValue();

  useEffect(() => {
    // if (!oneCourse) {
    getOneCourse("65d89f2602fed4ae3c6d5375").then((data) => {
      dispatch({
        type: actionType.SET_ONECOURSE,
        oneCourse: data.data,
      });
      // console.log(data);
    });
    // }
  }, []);
  // console.log(oneCourse);

  const [isOpenContentCourse, setisOpenContentCourse] = useState(false);
  const [selectedItemId, setselectedItemId] = useState(null);
  const handleButtonCCClick = (itemId) => {
    if (selectedItemId === itemId) {
      setisOpenContentCourse(!isOpenContentCourse);
    } else {
      setisOpenContentCourse(true);
    }
    setselectedItemId(itemId);
  };

  const [openSections, setOpenSections] = useState({});
  const handleSectionClick = (sectionId) => {
    setOpenSections((prevOpenSections) => ({
      ...prevOpenSections,
      [sectionId]: !prevOpenSections[sectionId],
    }));
  };

  const navigate = useNavigate();
  return (
    <div>
      <section>
        <div className="section-container-video">
          <div className="section-container-video-header">
            <div className="tutor-ratings-stars">
              <span className="tutor-icon-star-line">
                <i className="fa-regular fa-star"></i>
              </span>
              <span className="tutor-icon-star-line">
                <i className="fa-regular fa-star"></i>
              </span>
              <span className="tutor-icon-star-line">
                <i className="fa-regular fa-star"></i>
              </span>
              <span className="tutor-icon-star-line">
                <i className="fa-regular fa-star"></i>
              </span>
              <span className="tutor-icon-star-line">
                <i className="fa-regular fa-star"></i>
              </span>
            </div>
            <p className="section-container-video-header-dsa">
              {oneCourse?.course_name}
            </p>
            <div className="section-container-video-header-meta">
              <div className="section-container-video-header-meta-avatar">
                <a href=""></a>
              </div>
              <div>
                <span className="tutor-mr-16">
                  Khóa học của{" "}
                  <a className="tutor-mr-17" href="">
                    instructor
                  </a>
                </span>
                <span>Chưa được phân loại</span>
              </div>
            </div>
          </div>
          <div className="section-container-video-nodejs">
            <ReactPlayer
              width={848}
              height={536}
              controls={true}
              url={oneCourse?.course_demoVideo}
            />
          </div>
          <div className="section-container-video-footer">
            <div className="section-container-video-footer-header">
              <div className="section-container-video-footer-info boder">
                <a href="">Thông tin khóa học</a>
              </div>
              <div className="section-container-video-footer-review boder">
                <a href="">Reviews</a>
              </div>
            </div>
            <div className="section-container-video-footer-subheader">
              <h6>Về khóa học</h6>
              <p>{oneCourse?.course_description}</p>
              <h6>Bạn sẽ học gì?</h6>
              <ul>
                {oneCourse?.course_lessonContent.map((content, index) => (
                  <li key={index}>{content}</li>
                ))}
              </ul>
            </div>

            <div className="section-container-video-footer-course-content">
              <h6>Nội dung khóa học</h6>
              {/* card content course */}
              {oneCourse?.courseData.map((item) => (
                <div key={item?._id}>
                  <div
                    onClick={() => handleSectionClick(item?._id)}
                    className="section-container-video-footer-course-content-array"
                  >
                    {/* {console.log(item?._id)} */}
                    {item?.courseData_title}
                    <i
                      className={`fa-solid fa-chevron-${
                        isOpenContentCourse && selectedItemId === item?._id
                          ? "down"
                          : "right"
                      }`}
                    ></i>
                  </div>
                  {openSections[item?._id] && (
                    <div className="section-container-video-footer-course-second-content-array">
                      {item.courseDataVideo.map((content) => (
                        <div
                          key={content?._id}
                          className="section-container-video-footer-course-second-content-array-arrl"
                        >
                          {/* {console.log(content._id)} */}
                          <div className="section-container-video-footer-course-second-content-array-arrl-logo">
                            <i class="fa-brands fa-youtube"></i>
                            <a href="">{content.video_title}</a>
                            {/* {console.log(content.courseData_title)} */}
                          </div>
                          <div className="section-container-video-footer-course-second-content-array-arrl-eye">
                            <p>{convertToTime(content.video_length)}</p>
                            <i class="fa-regular fa-eye"></i>
                          </div>
                        </div>
                      ))}
                    </div>
                  )}
                </div>
              ))}
            </div>
          </div>
        </div>
        <div className="section-container-slide-box">
          <div className="section-container-slide">
            <div className="section-container-slide-header">
              <button
                onClick={() => navigate("/OneCourse/Learning")}
                className="section-container-slide-header-btn"
              >
                BẮT ĐẦU HỌC
              </button>
            </div>
            <div className="section-container-slide-subheader">
              <div className="section-container-slide-subheader-content">
                <ul>
                  <li>
                    <span className="section-container-slide-subheader-details-content">
                      <i className="fa-solid fa-ranking-star"></i>
                      <p>All Level</p>
                    </span>
                  </li>
                  <li>
                    <span className="section-container-slide-subheader-details-content">
                      <i className="fa-solid fa-graduation-cap"></i>
                      <p>1 Total Enrolled</p>
                    </span>
                  </li>
                  <li>
                    <span className="section-container-slide-subheader-details-content">
                      <i className="fa-solid fa-rotate-right"></i>
                      <p>February 8, 2024 Last Updated</p>
                    </span>
                  </li>
                </ul>
              </div>
            </div>
            <div className="section-container-slide-by">
              <div className="section-container-slide-by-header">
                <p>A course by</p>
              </div>
              <div className="section-container-slide-by-box">
                <div className="section-container-slide-by-box-avatar"></div>
                <div className="section-container-slide-by-box-name">
                  <a href="">Instructor</a>
                  <p>Desain grafis</p>
                </div>
              </div>
            </div>
            <div className="section-container-slide-footer">
              <ul>
                <li>
                  <h6>Material Includes</h6>
                  <p>szx</p>
                </li>
                <li>
                  <h6>Requirements</h6>
                  <p>dsa</p>
                </li>
                <li>
                  <h6>Tag</h6>
                  <button>Web development</button>
                </li>
                <li>
                  <h6>Audience</h6>
                  <p>không sao</p>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </section>
    </div>
  );
}
