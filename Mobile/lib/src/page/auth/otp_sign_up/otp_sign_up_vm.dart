import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kltn/src/base/base_vm.dart';
import 'package:kltn/src/remote/service/body/otp_body.dart';

import '../../../remote/service/body/signup_body.dart';

class OtpSignUpVM extends BaseViewModel {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  bool checkOtp1 = false;
  bool checkOtp2 = false;
  bool checkOtp3 = false;
  bool checkOtp4 = false;
  String token = '';
  String email = '';
  String name = '';
  String passwork = '';

  int remainingSeconds = 90;
  String time = '1:30';
  Function(String)? callback;
  @override
  void onInit() {
    countDown();
  }

  Future postOtp(BuildContext context1) async {
    showLoading();
    String otp =
        "${controller1.text.trim()}${controller2.text.trim()}${controller3.text.trim()}${controller4.text.trim()}";
    final body = OtpBody()
      ..activationToken = token
      ..otpCode = otp;

    try {
      final response = await api.authService.postActivateUser(body);
      if (response.status! >= 200 || response.status! < 400) {
        hideLoading();
        notifyListeners();
        showSucces('Đăng ký thành công');
        callback?.call('');
      } else {
        hideLoading();
        notifyListeners();
        
        notifyListeners();
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      hideLoading();
      if (e.response?.statusCode == 400) {
        showError('Otp không chính xác.');
        notifyListeners();
      } else {
        showError('Otp đã hết hạn.');
        notifyListeners();
      }
      notifyListeners();
    }
  }

  Future reSendOtp(BuildContext context) async {
    showLoading();
    final body = SignupBody()
      ..userEmail = email
      ..userName = name
      ..userPassword = passwork;
    try {
      final response = await api.authService.postSignup(body);
      if (response.status! >= 200 || response.status! < 400) {
        token = response.data?.activationToken ?? '';
        hideLoading();
        notifyListeners();
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

  void countDown() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      remainingSeconds--;
      int minutes = remainingSeconds ~/ 60;
      int seconds = remainingSeconds % 60;

      time = '$minutes:$seconds';
      notifyListeners();

      if (remainingSeconds <= 0) {
        timer.cancel();
      }
    });
  }
}
