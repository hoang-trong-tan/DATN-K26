import { FC, useEffect, useState } from "react";
import { useFormik } from "formik";
import * as Yup from "yup";
import { AiOutlineEye, AiOutlineEyeInvisible } from "react-icons/ai";
import { toast } from "react-hot-toast";
import { useLoginMutation } from "../../../redux/features/auth/authApi";
import { styles } from "../../../styles/style";
import { useLoadUserQuery } from "../../../redux/features/api/apiSlice";

type Props = {
  switchToSignUp: () => void;
  onClose: () => void;
};

const schema = Yup.object().shape({
  email: Yup.string()
    .email("Email không hợp lệ!")
    .required("Vui lòng nhập email của bạn!"),
  password: Yup.string().required("Vui lòng nhập mật khẩu của bạn!").min(6),
});

const Login: FC<Props> = ({ switchToSignUp, onClose }) => {
  const [show, setShow] = useState(false);
  const [login, { isSuccess, error }] = useLoginMutation();
  const { refetch: refetchUserData } = useLoadUserQuery("");

  const formik = useFormik({
    initialValues: { email: "", password: "" },
    validationSchema: schema,
    onSubmit: async ({ email, password }) => {
      try {
        const dataRes: any = await login({
          user_email: email,
          user_password: password,
        });
        const accessToken = dataRes?.data?.data?.accessToken;
        const userId = dataRes?.data?.data?.metaData?._id;
        if (accessToken) {
          localStorage.setItem("access_token", accessToken);
        }
        if (userId) {
          localStorage.setItem("user_id", userId);
        }
        if (onClose) {
          onClose();
        }
        refetchUserData();
      } catch (error: any) {
        toast.error(error?.data?.message);
      }
    },
  });

  useEffect(() => {
    if (isSuccess) {
      toast.success("Đăng nhập thành công!");
      // setOpen(false);
      // refetch();
    }
    if (error) {
      if ("data" in error) {
        const errorData = error as any;
        toast.error(errorData.data.message);
      }
    }
  }, [isSuccess, error]);

  const { errors, touched, values, handleChange, handleSubmit } = formik;

  return (
    <div className="w-full">
      <h1 className={`${styles.title}`}>Đăng nhâp ngay</h1>
      <form onSubmit={handleSubmit}>
        <label className={`${styles.label}`} htmlFor="email">
          Nhập email
        </label>
        <input
          type="email"
          name=""
          value={values.email}
          onChange={handleChange}
          id="email"
          placeholder="loginmail@gmail.com"
          className={`${errors.email && touched.email && "border-red-500"} ${styles.input
            }`}
        />
        {errors.email && touched.email && (
          <span className="text-red-500 pt-2 block">{errors.email}</span>
        )}
        <div className="w-full mt-5 relative mb-1">
          <label className={`${styles.label}`} htmlFor="email">
            Nhập mật khẩu
          </label>
          <input
            type={!show ? "password" : "text"}
            name="password"
            value={values.password}
            onChange={handleChange}
            id="password"
            placeholder="password!@%"
            className={`${errors.password && touched.password && "border-red-500"
              } ${styles.input}`}
          />
          {!show ? (
            <AiOutlineEyeInvisible
              className="absolute bottom-3 right-2 z-1 cursor-pointer"
              size={20}
              onClick={() => setShow(true)}
            />
          ) : (
            <AiOutlineEye
              className="absolute bottom-3 right-2 z-1 cursor-pointer"
              size={20}
              onClick={() => setShow(false)}
            />
          )}
          {errors.password && touched.password && (
            <span className="text-red-500 pt-2 block">{errors.password}</span>
          )}
        </div>
        <div className="w-full mt-5">
          <input type="submit" value="Đăng nhập" className={`${styles.button}`} />
        </div>
        <br />
        <h5 className="text-center pt-4 font-Poppins text-[14px]">
          Bạn chưa có tài khoản?{" "}
          <span
            className="text-[#2190ff] pl-1 cursor-pointer"
            onClick={() => switchToSignUp()}
          >
            Đăng ký
          </span>
        </h5>
      </form>
      <br />
    </div>
  );
};

export default Login;
