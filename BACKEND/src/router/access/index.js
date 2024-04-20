const express = require("express");
const accessController = require("../../controller/access.controller");
const userController = require("../../controller/user.controller");
const { authentication, authorizeRoles } = require("../../auth/authUtils");
const router = express.Router();

router.post("/signup", accessController.signUp);
router.post("/activate-user", accessController.activateUser);
router.post("/login", accessController.login);

router.get("/information-teacher/:id", userController.printInforTeacher);
router.get("/all-course-teacher/:id", userController.getAllCoursesTeacher);

router.use(authentication);

router.get(
  "/information",
  authorizeRoles("teacher", "admin", "student"),
  userController.printUser
);
router.patch(
  "/update-profile",
  authorizeRoles("teacher"),
  userController.updateProfileTeacher
);

module.exports = router;
