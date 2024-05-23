import { Link } from "react-router-dom";

const Footer = () => {
  return (
    <footer className="text-center">
      <div className="border border-[#0000000e] dark:border-[#ffffff1e]" />
      <br />
      <div className=" w-[95%] 800px:w-full 800px:max-w-[85%] mx-auto px-2 sm:px-6 lg:px-8">
        <div className="grid grid-cols-1 gap-8 sm:grid-cols-2 md:grid-cols-2 lg:gap-[400px]">
          <div>
            <h3 className="text-[20px] font-[600] text-black dark:text-white pb-3">
            Liên kết
            </h3>
            <ul className="space-y-4">
              <li>
                <Link
                  to="/courses"
                  className="text-base text-black dark:text-gray-300 dark:hover:text-white"
                >
                  Khóa học
                </Link>
              </li>
              {/* <li>
                <Link
                  to="/profile"
                  className="text-base text-black dark:text-gray-300 dark:hover:text-white"
                >
                  My Account
                </Link>
              </li> */}
              {/* <li>
                <Link
                  to="/course-dashboard"
                  className="text-base text-black dark:text-gray-300 dark:hover:text-white"
                >
                  Course Dashboard
                </Link>
              </li> */}
            </ul>
          </div>
          <div>
            <h3 className="text-[20px] font-[600] text-black dark:text-white pb-3">
              Thông tin liên lạc
            </h3>
            <p className="text-base text-black dark:text-gray-300 dark:hover:text-white pb-2">
              Gọi ngay: 0326598741
            </p>

            <p className="text-base text-black dark:text-gray-300 dark:hover:text-white pb-2">
              Địa chỉ: 128 Phan Thanh, Đà Nẵng
            </p>

            <p className="text-base text-black dark:text-gray-300 dark:hover:text-white  pb-2">
              Mail: hello@K26Demy.com
            </p>
          </div>
        </div>
        <br />
        <p className="text-center text-black dark:text-white">
          Copyright © 2024 K26Demy | All Rights Reserved
        </p>
      </div>
      <br />
    </footer>
  );
};


export default Footer;
