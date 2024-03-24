import React from 'react'
import { Sidebar } from 'flowbite-react';
import { HiArrowSmRight, HiChartPie, HiInbox, HiShoppingBag, HiTable, HiUser, HiViewBoards } from 'react-icons/hi';
import { IoMdAddCircle } from "react-icons/io";


const Nav = () => {
  return (
    
    <div className=" h-screen bg-white hidden md:block ">
      <Sidebar aria-label="Default sidebar example" >
      <Sidebar.Items>
        <Sidebar.ItemGroup>
        <Sidebar.Item href="#" icon={IoMdAddCircle }  labelColor="dark" className="border border-[#155e75] font-medium">
            Thêm khóa học
          </Sidebar.Item>
          <Sidebar.Item href="#" icon={HiChartPie}>
            Dashboard
          </Sidebar.Item>
          <Sidebar.Item href="#" icon={HiInbox} label="3">
            Inbox
          </Sidebar.Item>
          <Sidebar.Item href="#" icon={HiUser}>
            Users
          </Sidebar.Item>
          <Sidebar.Item href="#" icon={HiShoppingBag}>
            Products
          </Sidebar.Item>
          <Sidebar.Item href="#" icon={HiArrowSmRight}>
            Sign In
          </Sidebar.Item>
          <Sidebar.Item href="#" icon={HiTable}>
            Sign Up
          </Sidebar.Item>
        </Sidebar.ItemGroup>
      </Sidebar.Items>
    </Sidebar>       
    </div>
    
  )
}

export default Nav
