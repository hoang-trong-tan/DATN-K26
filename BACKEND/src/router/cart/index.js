const express = require("express");
const cartController = require("../../controller/cart.controller");
const { authentication } = require("../../auth/authUtils");
const router = express.Router();

router.use(authentication);

router.post("/:id", cartController.addCart);
router.get("", cartController.getCartByUser);
router.delete("/:id", cartController.deleteCartInCart);

module.exports = router;
