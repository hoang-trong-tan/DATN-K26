import React from 'react';
import { HeartIcon, ShareIcon } from '@heroicons/react/outline';

const CourseDetails = () => {
  // Thông tin giả định cho khóa học, thay thế bằng dữ liệu thực từ API của bạn
  const course = {
    title: "The Science Behind Drawing",
    author: "Tony Hanna",
    categories: ["Art", "Illustration"],
    price: "14.99",
    level: "Intermediate",
    enrolled: "3",
    duration: "4 hours 10 minutes",
    lastUpdated: "March 14, 2022",
    certificate: "Certificate of completion",
    authorImage: "/path-to-author-image.jpg", // Thay thế bằng đường dẫn thực tế
    courseImage: "/path-to-course-image.jpg", // Thay thế bằng đường dẫn thực tế
  };

  return (
    <div className="bg-gray-100 p-8">
      <div className="max-w-5xl mx-auto bg-white shadow-lg rounded-lg overflow-hidden md:flex">
        <div className="md:flex-shrink-0">
          <img src="{course.courseImage}" alt="Course" className="w-full h-96 object-cover md:w-80" />
        </div>
        <div className="p-8">
          <div className="uppercase tracking-wide text-sm text-indigo-500 font-semibold">{course.categories.join(', ')}</div>
          <h1 className="block mt-1 text-lg leading-tight font-medium text-black hover:underline">{course.title}</h1>
          <p className="mt-2 text-gray-600">By {course.author}</p>
          <div className="mt-4">
            <div className="flex items-center">
              <HeartIcon className="h-6 w-6 text-gray-500 hover:text-red-500" />
              <ShareIcon className="h-6 w-6 text-gray-500 hover:text-blue-500 ml-4" />
            </div>
          </div>
          <div className="mt-4">
            <span className="text-3xl font-bold text-gray-900">${course.price}</span>
            <button className="ml-4 bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
              Add to cart
            </button>
          </div>
          <div className="mt-4">
            <div className="flex items-center text-sm text-gray-600">
              <p>{course.level}</p>
              <p className="ml-4">{course.enrolled} Total Enrolled</p>
              <p className="ml-4">{course.duration} Duration</p>
              <p className="ml-4">{course.lastUpdated} Last Updated</p>
            </div>
            <p className="text-sm text-gray-600 mt-2">{course.certificate}</p>
          </div>
          <div className="mt-4">
            <div className="flex items-center">
              <img className="h-10 w-10 rounded-full mr-4" src={course.authorImage} alt={`Avatar of ${course.author}`} />
              <div className="text-sm">
                <p className="text-gray-900 leading-none">{course.author}</p>
                <p className="text-gray-600">Author</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default CourseDetails;