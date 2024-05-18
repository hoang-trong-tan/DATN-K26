import { FC } from "react";
import { Link } from "react-router-dom";
import Ratings from "../../../components/ui/Ratings";

export type CourseCardType = {
  _id: string;
  course_thumnail: string;
  course_name: string;
  course_purchased: number;
  course_ratingsAverage: number;
  course_price: number;
};
type Props = {
  item: CourseCardType;
  isOwn?: boolean;
};

const CourseCard: FC<Props> = ({ item, isOwn }) => {
  return (
    <Link to={isOwn ? `/admin/course/${item._id}` : `/course/${item._id}`}>
      <div className="w-full min-h-[35vh] flex flex-col justify-between h-full dark:bg-slate-500 dark:bg-opacity-20 backdrop-blur border dark:border-[#ffffff1d] border-[#00000015] dark:shadow-[bg-slate-700] rounded-lg p-3 shadow-sm dark:shadow-inner">
        <img
          src={item?.course_thumnail}
          alt=""
          className="w-full h-[250px] mb-5"
        />

        <h1 className="font-Poppins flex-1 text-[16px] text-black dark:text-[#fff]">
          {item.course_name}
        </h1>
        <div>
          <div className="w-full flex items-center justify-between pt-2">
            <Ratings rating={item.course_ratingsAverage} />
            <h5 className={`text-black dark:text-[#fff]`}>
              {item.course_purchased} Students
            </h5>
          </div>
          <div className="w-full flex items-center justify-end pt-3">
            <div className="flex">
              <h3 className="text-black dark:text-[#fff]">
                {item.course_price === 0
                  ? "Free"
                  : item.course_price.toLocaleString("it-IT", {
                      style: "currency",
                      currency: "VND",
                    })}
              </h3>
            </div>
          </div>
        </div>
      </div>
    </Link>
  );
};

export default CourseCard;
