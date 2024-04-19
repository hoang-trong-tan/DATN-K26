const express = require("express");
const orderController = require("../../controller/order.controller");
const { authentication, authorizeRoles } = require("../../auth/authUtils");
const router = express.Router();

router.get("/payment/vnpay_return", orderController.vnpayReturn);

router.use(authentication);

router.post(
  "/payment/create_payment_url/:id",
  authorizeRoles("student"),
  orderController.createVNPAY
);

module.exports = router;
