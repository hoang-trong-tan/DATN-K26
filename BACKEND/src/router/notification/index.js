"use strict";

const express = require("express");
const notificationController = require("../../controller/notification.controller");
const { authentication } = require("../../auth/authUtils");

const router = express.Router();

router.use(authentication);

router.get("/get-notifications", notificationController.getNotifications);
router.patch(
  "/update-notification/:id",
  notificationController.updateNotification
);

module.exports = router;
