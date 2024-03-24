import React, { useState } from "react";
import Header from "../Header";
import Footer from "../Footer";
import { Link } from "react-router-dom";

export default function Learning() {
  const [openSections, setOpenSections] = useState({});

  const handleSectionClick = (sectionId) => {
    setOpenSections((prevOpenSections) => ({
      ...prevOpenSections,
      [sectionId]: !prevOpenSections[sectionId],
    }));
  };
  return (
    <div>
      <section className="arr1">
        <div className="arr1-course-content">
          <div className="arr1-course-contentbox">
            <h6 className="arr1-course-contentbox-heading">Course Content</h6>
          </div>
          <div className="arr1-course-subcontentbox">
            <div className="arr1-course-listcontentbox array">
              <p>array</p>
              <span className="arr1-course-listcontentbox-logo">
                <p className="arr1-course-listcontentbox-logo-p">0/3</p>
                <i class="fa-solid fa-chevron-right"></i>
              </span>
            </div>
            <div className="arr1-course-listcontentbox-detailsbox">
              <div className="arr1-course-listcontentbox-details">
                <div className="arr1-course-listcontentbox-detail-logo">
                  <i class="fa-brands fa-youtube"></i>
                  <p>arr1</p>
                </div>
                <div className="arr1-course-listcontentbox-detail-choosee">
                  <p>26:33</p>
                  <i class="fa-regular fa-circle"></i>
                </div>
              </div>
              <div className="arr1-course-listcontentbox-details">
                <div className="arr1-course-listcontentbox-detail-logo">
                  <i class="fa-regular fa-file"></i>
                  <p>Draft Lesson</p>
                </div>
                <div className="arr1-course-listcontentbox-detail-choosee">
                  <i class="fa-regular fa-circle"></i>
                </div>
              </div>
              <div className="arr1-course-listcontentbox-details">
                <div className="arr1-course-listcontentbox-detail-logo">
                  <i class="fa-solid fa-question"></i>
                  <p>11</p>
                </div>
                <div className="arr1-course-listcontentbox-detail-choosee">
                  <p>26:33</p>
                  <i class="fa-regular fa-circle"></i>
                </div>
              </div>
            </div>
            <div className="arr1-course-listcontentbox java">
              <p>javascrip</p>
              <div className="arr1-course-listcontentbox-logo">
                <p className="arr1-course-listcontentbox-logo-p">0/3</p>
                <i class="fa-solid fa-chevron-right"></i>
              </div>
            </div>
            {/* <div className='arr1-course-listcontentbox-details'>
                <div className='arr1-course-listcontentbox-detail-logo'>
                <i class="fa-regular fa-file"></i>
                  <p>Assignments</p>
                  </div>
                  <div className='arr1-course-listcontentbox-detail-choosee'>
                  <i class="fa-regular fa-circle"></i>
                  </div>
            </div> */}
            <div className="arr1-course-listcontentbox intro">
              <p>Introductoion</p>
              <span className="arr1-course-listcontentbox-logo">
                <i class="fa-solid fa-chevron-right"></i>
              </span>
            </div>
          </div>
        </div>
        <div className="arr1-video-content">
          <div className="arr1-video-content-header">
            <div className="arr1-video-content-header-zoom">
              <i class="fa-solid fa-angle-left"></i>
            </div>
            <h6>DSA</h6>
            <div className="arr1-video-content-header-back">
              {/* <Link to="/"> */}
              <i class="fa-solid fa-xmark"></i>
              {/* </Link> */}
            </div>
          </div>
          <div className="arr1-video-content-video"></div>
          <div className="arr1-video-content-forward">
            <div>
              <button className="arr1-video-content-forward-btn pre">
                <i class="fa-solid fa-arrow-left"></i>
                Previous
              </button>
            </div>
            <div>
              <button className="arr1-video-content-forward-btn next">
                Next
                <i class="fa-solid fa-arrow-right"></i>
              </button>
            </div>
          </div>
        </div>
      </section>
    </div>
  );
}
