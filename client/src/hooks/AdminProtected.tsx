import { ReactNode } from "react";
import { useSelector } from "react-redux";
import { redirect } from "react-router-dom";

type Props = {
  children: ReactNode;
};

export default function AdminProtected({ children }: Props) {
  const { role } = useSelector((state: any) => state.auth);
  if (role) {
    const isAdmin = role === "admin";
    return isAdmin ? children : redirect("/");
  }
}
