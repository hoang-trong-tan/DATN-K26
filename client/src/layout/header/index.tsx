import { Link } from "react-router-dom";
import { HiOutlineUserCircle } from "react-icons/hi";
import NavItems from "./NavItems";
import { useState } from "react";
import CustomModal from "../../components/ui/Modal";
import Login from "./Auth/Login";
import Signup from "./Auth/SignUp";
import avatar from "../../assets/avatar.png";
import { useSelector, useDispatch } from "react-redux";
import { userLoggedIn } from "../../redux/features/auth/authSlice";
enum AuthModal {
  CLOSE = "CLOSE",
  LOGIN = "LOGIN",
  SIGNUP = "SIGNUP",
}
const Header = () => {
  const [open, setOpen] = useState<AuthModal>(AuthModal.CLOSE);
  const { avatar: userAvatar, user } = useSelector((state: any) => state.auth);
  const dispatch = useDispatch();
  return (
    <div className="w-[90%]  m-auto py-2 h-full">
      <div className="w-full h-[80px] flex items-center justify-between p-3">
        <div>
          <Link
            to={"/"}
            className={`text-[25px] font-Poppins font-[500] text-black dark:text-white`}
          >
            K26DEMY
          </Link>
        </div>
        <div className="flex items-center">
          <NavItems />
          {user ? (
            <div
              className="cursor-pointer"
              onClick={() => {
                localStorage.clear();
                dispatch(
                  userLoggedIn({
                    accessToken: "",
                    user: "",
                    avatar: "",
                    role: "",
                    course_bought: [""],
                  })
                );
              }}
            >
              <img
                className="rounded-full"
                src={userAvatar || avatar}
                width={50}
                height={50}
                alt="avatar"
              />
            </div>
          ) : (
            <HiOutlineUserCircle
              size={25}
              className="cursor-pointer dark:text-white text-black"
              onClick={() => setOpen(AuthModal.LOGIN)}
            />
          )}
        </div>
      </div>
      <CustomModal
        open={open === AuthModal.LOGIN}
        onClose={() => setOpen(AuthModal.CLOSE)}
      >
        <Login
          switchToSignUp={() => setOpen(AuthModal.SIGNUP)}
          onClose={() => setOpen(AuthModal.CLOSE)}
        />
      </CustomModal>
      <CustomModal
        open={open === AuthModal.SIGNUP}
        onClose={() => setOpen(AuthModal.CLOSE)}
      >
        <Signup switchToLogin={() => setOpen(AuthModal.LOGIN)} />
      </CustomModal>
    </div>
  );
};

export default Header;
