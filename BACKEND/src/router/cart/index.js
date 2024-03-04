const express = require("express");
const cartController = require("../../controller/cart.controller");
const router = express.Router();

router.post("", cartController.addCart);
router.get("/:id", cartController.getCartByUser);
router.delete("/:id", cartController.deleteCartInCart);

module.exports = router;
