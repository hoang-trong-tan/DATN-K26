import { useNavigate } from "react-router-dom";
import BannerSrc from "../../assets/banner.svg";
import { Button } from "../../components/ui/Button";
import { ROUTE } from "../../utils/constants";
import Reviews from "./Reviews";
const HomePage = () => {
  const navigate = useNavigate();
  return (
    <div className="my-10 flex flex-col gap-10">
      <div className="flex">
        <div className="w-[50%] flex flex-col gap-3">
          <h1 className="font-medium text-left py-2 text-5xl leading-[60px]">
            Start your
            <span className="text-gradient text-gradient_light">
              {" "}
              programming
            </span>
            <br />
            <span className="text-gradient_light"> Journey </span>
            with our
            <br />
            Dedicated community!
          </h1>
          <p className=" w-[90%] font-poppins text-[22px] leading-[32px] font-normal text-[#A3B3BC] mb-5 text-left">
            Begin your coding adventure in our community, where learning is
            always appreciated and valued.
          </p>
          <Button className="w-[200px]" onClick={() => navigate(ROUTE.COURSES)}>
            Explore Courses
          </Button>
        </div>
        <div>
          <img
            alt=""
            loading="eager"
            width="650"
            height="650"
            decoding="async"
            data-nimg="1"
            className="mr-8"
            src={BannerSrc}
          />
        </div>
      </div>
      <div className="border-b border-[#ffffff1c]" />
      <div className="flex flex-col gap-5">
        <h1 className="text-center text-5xl font-medium">Reviews</h1>
        <Reviews />
      </div>
    </div>
  );
};

export default HomePage;
