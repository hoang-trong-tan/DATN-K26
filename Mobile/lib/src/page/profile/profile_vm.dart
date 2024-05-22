import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:kltn/src/base/base_vm.dart';
import 'package:kltn/src/model/user_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileVM extends BaseViewModel {
  UserModel userModel = UserModel();
  String avatar = '';
  String name = '';
  @override
  void onInit() {
    getUser();
  }

  void removeToken() {
    prefs.removeToken();
    prefs.removeUserName();
    prefs.removeUserID();
    prefs.removerRole();
    prefs.removeUpdate();
  }

  Future<void> getUser() async {
    // showLoading();
    // notifyListeners();

    try {
      final response = await api.apiServices
          .getUser({'x-atoken-id': prefs.token.toString()}, {'x-client-id': prefs.userID.toString()});
      if (response.status! >= 200 || response.status! < 400) {
        userModel = response.data ?? UserModel();
        name = response.data?.userName ?? '';
        avatar = response.data?.userAvatar ?? '';
        if (response.data?.userFcmToken == null || response.data?.userFcmToken != prefs.fcmToken) {
          updateFcm();
        }
      }
      // hideLoading();
      notifyListeners();
    } on DioException catch (e) {
      log(e.message ?? "");
    }
  }

  Future<void> updateFcm() async {
    try {
      final response = await api.apiServices.updateFcm(
        {'x-atoken-id': prefs.token.toString()},
        {'x-client-id': prefs.userID.toString()},
        {'user_fcm_token': prefs.fcmToken},
      );
      if (response.status! >= 200 || response.status! < 400) {}
      hideLoading();
      notifyListeners();
    } on DioException catch (e) {
      log(e.message ?? "");
    }
  }

  Future<void> launchUrlFace(String url) async {
    try {
      if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch');
      }
    } catch (e) {
      showError("Đã có lỗi xảy ra");
    }
  }

  void launchURLEmail() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'dangson130402@gmail.com',
    );
    String url = params.toString();
    if (await canLaunchUrl(params)) {
      await launchUrl(params);
    } else {
      showError("Đã có lỗi xảy ra");
      log('Could not launch $url');
    }
  }
}
