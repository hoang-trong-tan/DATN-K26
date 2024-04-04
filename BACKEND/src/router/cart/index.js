const express = require("express");
const cartController = require("../../controller/cart.controller");
const { authentication, authorizeRoles } = require("../../auth/authUtils");
const router = express.Router();

router.use(authentication);

router.post("/:id", authorizeRoles("student"), cartController.addCart);
router.get("", authorizeRoles("student"), cartController.getCartByUser);
router.delete(
  "/:id",
  authorizeRoles("student"),
  cartController.deleteCartInCart
);

module.exports = router;
