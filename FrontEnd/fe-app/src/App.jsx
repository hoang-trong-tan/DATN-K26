import { useState } from 'react'
import { Header } from './components'
import {CouserInfo,CourseUploadTips} from './components/Dashboard/NewCourse'
import Dashboard from './components/Dashboard/Dashboard'
import CourseDetails from './components/Courses/CourseDetails/CourseDetails'

function App() {
  return (
    <>
    <Header className="z-50"/>
    <Dashboard />
      {/* <CourseDetails/> */}
    </>
  )
}

export default App
