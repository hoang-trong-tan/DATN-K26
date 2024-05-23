import { ButtonHTMLAttributes, DetailedHTMLProps, FC } from "react";
import { twMerge } from "tailwind-merge";

type ButtonSize = "large" | "medium" | "small";

type Props = {
  className?: string;
  size?: ButtonSize;
};

const getSizeStyle = (size: ButtonSize) => {
  switch (size) {
    case "large":
      return "py-3";
    case "medium":
      return "py-2";
    case "small":
      return "py-1";
    default:
      break;
  }
};

export const Button: FC<
  Props &
    DetailedHTMLProps<
      ButtonHTMLAttributes<HTMLButtonElement>,
      HTMLButtonElement
    >
> = ({
  children,
  className,
  size = "medium",
  type = "button",
  ...restProps
}) => {
  return (
    <button
      type={type}
      className={twMerge(
        `w-full flex justify-center bg-[#2190ff] text-white font-bold rounded-3xl ${getSizeStyle(
          size
        )}`,
        className ?? ""
      )}
      {...restProps}
    >
      {children}
    </button>
  );
};
