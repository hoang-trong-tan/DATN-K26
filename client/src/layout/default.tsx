import { Outlet } from "react-router-dom";
import Header from "./header";
import Footer from "./footer";

function DefaultLayout() {
  return (
    <div className="w-full h-full min-h-screen flex flex-col justify-between items-center">
      <div className="w-full border-b border-[#ffffff1c]">
        <Header />
      </div>
      <div className="w-full flex-1 max-w-[1300px] flex justify-center"> {/* Thêm lớp flex và justify-center */}
        <Outlet />
      </div>
      <Footer />
    </div>
  );
}

export default DefaultLayout;
