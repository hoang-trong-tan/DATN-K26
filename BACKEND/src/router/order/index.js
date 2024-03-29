const express = require("express");
const orderController = require("../../controller/order.controller");
const { authentication } = require("../../auth/authUtils");

const router = express.Router();

router.use(authentication);

router.post("/payment/create_payment_url/:id", orderController.createVNPAY);
router.get("/payment/vnpay_return", orderController.vnpayReturn);

module.exports = router;
