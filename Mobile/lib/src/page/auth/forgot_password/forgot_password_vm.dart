import 'package:flutter/material.dart';

import '../../../base/base_vm.dart';

class ForgotPasswordVM extends BaseViewModel{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String checkValidatePassword = '';
  String checkValidateConfirmPassword = '';
  String checkValidateEmail = '';
  bool checkEmail = false;
  bool checkPassword = false;
  bool checkConfirmPassword = false;
  @override
  void onInit() {
  }

}