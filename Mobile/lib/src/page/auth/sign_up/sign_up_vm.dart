import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kltn/src/base/base_vm.dart';
import 'package:kltn/src/remote/service/body/signup_body.dart';
import 'package:kltn/src/remote/service/respone/auth/signup_respone.dart';

import '../../../remote/service/respone/base_auth_response.dart';

class SignUpVM extends BaseViewModel {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String checkValidatePassword = '';
  String checkValidateConfirmPassword = '';
  String checkValidateEmail = '';
  String checkValidateName = '';
  bool checkName = false;
  bool checkEmail = false;
  bool checkPassword = false;
  bool checkConfirmPassword = false;
  bool checkUser = false;
  String token = '';
  Function(String)? callback;

  @override
  void onInit() {}
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future postSignup(BuildContext context) async {
    showLoading();
    final body = SignupBody()
      ..userEmail = emailController.text.trim()
      ..userName = nameController.text
      ..userRole = checkUser ? 'teacher' : 'student'
      ..userPassword = confirmPasswordController.text;
    BaseAuthResponse<SignupRespone> response = BaseAuthResponse();
    try {
      response = await api.authService.postSignup(body);
      if (response.status! >= 200 || response.status! < 400) {
        token = response.data?.activationToken ?? '';
        hideLoading();
        notifyListeners();
        callback?.call(token);
      } else {
        hideLoading();

        notifyListeners();
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        showError('Tài khoản đã tồn tại.');
      } else {
        showError('Đăng ký thất bại');
      }
      notifyListeners();
    }
  }
}
