import React from "react";

export default function Footer() {
  return (
    <div>
      <footer>
        <div className="footer-logo">
          <img
            src="https://demo.themeum.com/tutor/wp-content/uploads/2022/02/themeum.svg"
            alt=""
          />
          <p>&copy; All Rights Reserved. Themeum</p>
        </div>
        <div className="footer-menu">
          <ul className="footer-menu-items">
            <li>
              <a className="footer-menu-item" href="">
                Overview
              </a>
            </li>
            <li>
              <a className="footer-menu-item" href="">
                Course
              </a>
            </li>
            <li>
              <a className="footer-menu-item" href="">
                Course Details
              </a>
            </li>
            <li>
              <a className="footer-menu-item" href="">
                Instructor
              </a>
            </li>
          </ul>
        </div>
      </footer>
    </div>
  );
}
