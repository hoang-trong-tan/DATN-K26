import Select from 'react-select';
import React, { useState } from "react";
import { Label, Radio,FileInput } from 'flowbite-react';


const CouserInfo = () => {
  const options = [
    { value: 'film_video', label: 'Film & Video' },
    { value: 'illustration', label: 'Illustration' },
    { value: 'music', label: 'Music' },
    { value: 'photography', label: 'Photography' },
  ];
    // State để lưu trữ các lựa chọn đã chọn
    const [selectedOptions, setSelectedOptions] = useState([]);
  
    // Hàm xử lý khi có sự thay đổi lựa chọn
    const handleChange = (value) => {
      setSelectedOptions(value);
    };
  
  // State để lưu trữ URL xem trước ảnh
  const [imagePreviewUrl, setImagePreviewUrl] = useState(null);

  // Hàm xử lý khi tệp ảnh được chọn
  const handleImageChange = (e) => {
    const file = e.target.files[0];
    if (file && file.type.startsWith('image/')) {
      const reader = new FileReader();
      reader.onloadend = () => {
        setImagePreviewUrl(reader.result);
      };
      reader.readAsDataURL(file);
    } else {
      setImagePreviewUrl(null);
    }
  };

  return (
    <div className="flex flex-1 min-h-screen "> 
      <div className="flex-1 bg-white p-8">
        {/* title */}
        <div className="mb-4">
          <label htmlFor="courseTitle" className="block text-gray-700 text-sm font-bold mb-2">
            Tiêu đề khóa học
          </label>
          <input type="text" id="courseTitle" name="courseTitle" placeholder="Lập trình c++" className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" />
        </div>
        {/* about */}
        <div className="mb-4">
          <label htmlFor="aboutCourse" className="block text-gray-700 text-sm font-bold mb-2">
            Mô tả khóa học
          </label>
          <textarea id="aboutCourse" name="aboutCourse" rows="4" className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"></textarea>
        </div>
        {/* select category */}
        <div className="mb-4">
        <label htmlFor="courseCategory" className="block text-gray-700 text-sm font-bold mb-2">
            Chọn danh mục
          </label>
          <Select
            defaultValue={""}
            isMulti
            value={selectedOptions}
            onChange={handleChange}
            name="colors"
            options={options}
            className="basic-multi-select shadow appearance-none border rounded w-full text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
            classNamePrefix="select"
          />
        </div>
        {/* price */}
        <div className="mb-4">
        <label htmlFor="courseCategory" className="block text-gray-700 text-sm font-bold mb-2">
            Giá khóa học
          </label>
          <fieldset className="flex max-w-md flex-col gap-4">
            <div className="flex items-center gap-2">
        <Radio id="free" name="price" value="free" defaultChecked />
        <Label htmlFor="free">Miễn phí</Label>
      </div>

      <div className="flex items-center gap-2">
        <Radio id="paid" name="price" value="paid" />
        <Label htmlFor="paid">Có phí</Label>
      </div>
          </fieldset>
          
        </div>
        {/* thumbnail */}
        <div className="mb-4">
        <label htmlFor="courseThumbnail" className="block text-gray-700 text-sm font-bold mb-2">
          Course Thumbnail
        </label>
        <div className="flex items-center">
          <div className="flex w-64 h-32 bg-gray-200 items-center justify-center overflow-hidden mr-4">
            {imagePreviewUrl ? (
              <img src={imagePreviewUrl} alt="Preview" className="w-full h-full object-cover" />
            ) : (
              <div className="text-gray-500">Your image preview will appear here...</div>
            )}
          </div>
          <div>
            <div className="text-sm mb-1">Size: 700x430 pixels</div>
            <div className="text-sm mb-2">File Support: JPG, PNG, etc.</div>
            <Label htmlFor="dropzone-file" className="btn cursor-pointer bg-blue-600 text-white rounded px-4 py-2">
              Upload Image
            </Label>
          </div>
        </div>
        <FileInput
          id="dropzone-file"
          type="file"
          accept="image/*"
          onChange={handleImageChange}
          className="hidden"
        />
      </div>
        {/* Add more form fields as needed */}
      </div>
    </div>
  );
};

export default CouserInfo;
