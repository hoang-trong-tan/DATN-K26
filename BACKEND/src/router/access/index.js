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

router.get("/information", userController.printUser);
router.get("/get-process-course", userController.printDetailProcessUserCourse);
router.get("/get-purchased-course", userController.printPurchasedCourses);
router.patch("/update-profile", userController.updateProfileUser);
router.patch("/update-password", userController.updatePassWordUser);

module.exports = router;
