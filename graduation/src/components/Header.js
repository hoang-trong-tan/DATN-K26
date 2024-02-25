import React from 'react'

export default function Header() {
  return (
    <div>
      <header>
        <nav>
          <div className="header-nav-logo">
            <a href="">
              <img src="https://demo.themeum.com/tutor/wp-content/uploads/2022/02/tutor-live-demo-logo.svg" alt="" />
            </a>
          </div>
          <div className="header-nav-menu">
            <ul className='header-nav-menu-items'>
              <li className='header-nav-menu-details-items'>
                <a href="">Overview</a>
              </li>
              <li className='header-nav-menu-details-items'>
                <a href="">Course</a>
              </li>
              <li className='header-nav-menu-details-items'>
                <a href="">Course Details</a>
              </li>
              <li className='header-nav-menu-details-items'>
                <a href="">Instructor</a>
              </li>
            </ul>
          </div>
          <div className='header-nav-login'>
            <p className='header-nav-login-wte' href="">Want to Explore! <a className='header-nav-login-il' href=''>Instant Login</a></p>
            
          </div>
        </nav>
      </header>
    </div>
  )
}
