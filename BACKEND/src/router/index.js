// const app = require("../app");

const express = require("express");

const router = express.Router();

router.use("/v1/api/", require("./upload/index"));
router.use("/v1/api/course", require("../router/course/index"));

module.exports = router;
