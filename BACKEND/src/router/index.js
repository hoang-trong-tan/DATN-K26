// const app = require("../app");

const express = require("express");

const router = express.Router();

router.use("/v1/api/", require("./upload/index"));
router.use("/v1/api/course", require("../router/course/index"));
router.use("/v1/api/user", require("../router/access/index"));
router.use("/v1/api/cart", require("../router/cart/index"));
router.use("/v1/api/create-order", require("../router/order/index"));

module.exports = router;
