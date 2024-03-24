import React from 'react'
import { Nav } from './SideBar'
import { CouserInfo } from './NewCourse'

const Dashboard = () => {
  return (
    <div className='flex'>
        <Nav/>
        <CouserInfo/>
    </div>
  )
}

export default Dashboard
