const express = require("express");
const accessController = require("../../controller/access.controller");
const router = express.Router();

router.post("/signup", accessController.signUp);
router.post("/activate-user", accessController.activateUser);
router.post("/login", accessController.login);

module.exports = router;
