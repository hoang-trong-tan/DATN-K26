const express = require("express");
const orderController = require("../../controller/order.controller");

const router = express.Router();

router.post("/payment/create_payment_url/:id", orderController.createVNPAY);
router.get("/payment/vnpay_return", orderController.vnpayReturn);

module.exports = router;
