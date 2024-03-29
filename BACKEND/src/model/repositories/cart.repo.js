"use strict";

const { BadRequestError } = require("../../core/error.response");
const { getUnSelect } = require("../../util");
const cartModel = require("../cart.model");
const userModel = require("../user.model");

const getCartByUser = async ({ userId, unSlect, courseType }) => {
  const existUser = await userModel.findOne({ _id: userId });

  if (!existUser) {
    throw new BadRequestError("User is add cart");
  }

  const coursesInCart = await cartModel
    .find({ userShema: userId })
    .populate(
      "courseShema",
      "course_name course_type course_thumnail course_price course_purchased course_ratingsAverage"
    )
    .select(getUnSelect(unSlect))
    .lean();

  if (coursesInCart.length === 0) {
    return [];
  }

  if (courseType === undefined) {
    return coursesInCart;
  }

  const cartInType = coursesInCart.filter((item) => {
    return item.courseShema.course_type == courseType ? item : undefined;
  });

  return cartInType;
};

module.exports = { getCartByUser };
