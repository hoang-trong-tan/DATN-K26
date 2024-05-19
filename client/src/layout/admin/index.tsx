import { Outlet } from "react-router-dom";
import Sidebar from "./sidebar";
import { useState } from "react";
import { useSelector } from "react-redux";

const AdminLayout = () => {
  const [isCollapsed, setIsCollapsed] = useState(false);
  const { role } = useSelector((state: any) => state.auth);
  const forbiddenAccess = role === "student";

  return forbiddenAccess ? (
    <div className="flex justify-center text-[50px]">NOT FOUND</div>
  ) : (
    <div>
      <div className="flex justify-between min-h-screen">
        <div className={isCollapsed ? "w-[5%]" : "w-[10%]"}>
          <Sidebar isCollapsed={isCollapsed} setIsCollapsed={setIsCollapsed} />
        </div>
        <div className={isCollapsed ? "w-[93%]" : "w-[80%]"}>
          <Outlet />
        </div>
      </div>
    </div>
  );
};

export default AdminLayout;
