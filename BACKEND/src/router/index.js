// const app = require("../app");

const express = require("express");

const router = express.Router();

router.use("/course", require("./upload/index"));
router.use("/course", require("../router/course/index"));

module.exports = router;
