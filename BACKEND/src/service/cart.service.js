"use strict";

const { BadRequestError } = require("../core/error.response");
const cartModel = require("../model/cart.model");
const { getCartByUser } = require("../model/repositories/cart.repo");

const addCart = async (coureId, userId) => {
  const existCourse = await cartModel.findOne({ courseShema: coureId });

  if (existCourse) {
    throw new BadRequestError("Course is exist in cart ");
  }

  const newCart = await cartModel.create({
    courseShema: coureId,
    userShema: userId,
  });

  return newCart;
};

const deleteCart = async (cartId) => {
  const coursesInCart = await cartModel.findOne({ _id: cartId });

  if (!coursesInCart) {
    throw new BadRequestError("Course is not exits in cart");
  }

  const deleteCourse = await cartModel.findByIdAndDelete({ _id: cartId });

  return null;
};

const getCart = async (userId, courseType) => {
  return getCartByUser({
    userId,
    unSlect: ["__v", "userShema", "createdAt", "updatedAt"],
    courseType,
  });
};

module.exports = { addCart, getCart, deleteCart };
