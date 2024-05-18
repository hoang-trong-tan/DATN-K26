import { Outlet } from "react-router-dom";
import Sidebar from "./sidebar";
import { useState } from "react";

const AdminLayout = () => {
  const [isCollapsed, setIsCollapsed] = useState(false);

  return (
    <div className="flex justify-between min-h-screen">
      <div className={isCollapsed ? "w-[5%]" : "w-[10%]"}>
        <Sidebar isCollapsed={isCollapsed} setIsCollapsed={setIsCollapsed} />
      </div>
      <div className={isCollapsed ? "w-[93%]" : "w-[80%]"}>
        <Outlet />
      </div>
    </div>
  );
};

export default AdminLayout;
