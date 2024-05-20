import { FC, useEffect, useState } from "react";
import { Link, useLocation } from "react-router-dom";
import { ROUTE } from "../../utils/constants";

export const navItemsData = [
  {
    name: "Trang chủ",
    url: "/",
  },
  {
    name: "Khóa học",
    url: ROUTE.COURSES,
  },
  // {
  //   name: "About",
  //   url: "/about",
  // },
  // {
  //   name: "Policy",
  //   url: "/policy",
  // },
  // {
  //   name: "FAQ",
  //   url: "/faq",
  // },
];

const NavItems = () => {
  const location = useLocation();
  const [currentPath, setCurrentPath] = useState(location.pathname);
  useEffect(() => {
    setCurrentPath(location.pathname);
  }, [location.pathname]);
  return (
    <>
      <div className="flex">
        {navItemsData &&
          navItemsData.map((i, index) => (
            <Link
              to={`${i.url}`}
              key={index}
              onClick={() => {
                setCurrentPath(i.url);
              }}
            >
              <span
                className={`${
                  currentPath === i.url
                    ? "dark:text-[#37a39a] text-[crimson]"
                    : "dark:text-white text-black"
                } text-[18px] px-6 font-Poppins font-[400]`}
              >
                {i.name}
              </span>
            </Link>
          ))}
      </div>
    </>
  );
};

export default NavItems;
