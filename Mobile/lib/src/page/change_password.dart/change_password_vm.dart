import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:kltn/src/base/base_vm.dart';
import 'package:kltn/src/remote/service/body/update_password_body.dart';

class ChangePasswordVM extends BaseViewModel {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  String checkCurentpassword = '';
  String checknewpassword = '';
  String checkconfirmpassword = '';
  bool checkCurenPassword = false;
  bool checkNewPassword = false;
  bool checkConfirmPassword = false;
  Function(bool)? callback;
  @override
  void onInit() {}
  String check(String p0) {
    if (p0.isEmpty) {
      notifyListeners();
      return 'Vui lòng nhập mật khẩu';
    } else if (p0.length < 6) {
      notifyListeners();
      return 'Vui lòng nhập mật khẩu lớn hơn 6 ký tự';
    }
    notifyListeners();
    return '';
  }

  Future<void> changePassword() async {
    showLoading();
    final body = UpdatePasswordBody()
      ..oldPassWord = currentPasswordController.text
      ..newPassword = confirmNewPasswordController.text;
    try {
      final response =
          await api.apiServices.updatePassword({'x-atoken-id': prefs.token}, {'x-client-id': prefs.userID}, body);
      if (response.status! >= 200 || response.status! < 400) {
        showSucces('Đổi mật khẩu thành công');
        callback?.call(true);
      }
      hideLoading();
      notifyListeners();
    // ignore: deprecated_member_use
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        showError('Mật khẩu không chính xác');
      }
      hideLoading();
      notifyListeners();
      log(e.message.toString());
      // showError('Không thể kết nối đến máy chủ.\nVui lòng thử lại.');
    }
  }
}
