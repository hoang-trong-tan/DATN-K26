"use strict";

const _ = require("lodash");

const getinFoData = (fileds = [], object = {}) => {
  return _.pick(object, fileds);
};

// ['a', 'b'] => {a:0, b: 0}
const getUnSelect = (select = []) => {
  const unSelect = {};
  select.map((el) => {
    unSelect[el] = 0;
  });
  return unSelect;
};

const sortObject = (obj) => {
  let sorted = {};
  let str = [];
  let key;
  for (key in obj) {
    if (obj.hasOwnProperty(key)) {
      str.push(encodeURIComponent(key));
    }
  }
  str.sort();
  for (key = 0; key < str.length; key++) {
    sorted[str[key]] = encodeURIComponent(obj[str[key]]).replace(/%20/g, "+");
  }
  return sorted;
};

const cutString = (string) => {
  let courseId = "";
  let userId = "";
  let foundPlus = false;

  for (let i = 0; i < string.length; i++) {
    let char = string[i];

    if (char === "+") {
      foundPlus = true;
      continue;
    }

    if (!foundPlus) {
      courseId = courseId + char;
    } else {
      userId = userId + char;
    }
  }

  return { courseId: courseId.trim(), userId: userId.trim() };
};

module.exports = { getUnSelect, getinFoData, sortObject, cutString };
