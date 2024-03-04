"use strict";

const { CreatedResponse, Ok } = require("../core/sucess.response");
const catchAsync = require("../helper/catchAsync");
const { addCart, getCart, deleteCart } = require("../service/cart.service");

exports.addCart = catchAsync(async (req, res, next) => {
  const { courseShema, userShema } = req.body;
  new CreatedResponse({
    message: `Add course in cart is sucess`,
    data: await addCart(courseShema, userShema),
  }).send(res);
});

exports.getCartByUser = catchAsync(async (req, res, next) => {
  new Ok({
    message: `Get cart is sucess`,
    data: await getCart(req.params.id, req.query.courseType),
  }).send(res);
});

exports.deleteCartInCart = catchAsync(async (req, res, next) => {
  new Ok({
    message: `Delete course in cart is sucess`,
    data: await deleteCart(req.params.id),
  }).send(res);
});
