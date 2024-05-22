import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kltn/src/base/base_vm.dart';

import '../../model/course_model.dart';

class CourseVM extends BaseViewModel {
  bool checkPlay = true;
  ScrollController scrollController = ScrollController();
  List<CourseModel>? getCourseData = [];
  String idCourse = '';
  @override
  void onInit() {
    fetchCourse();
  }

  ///
  /// lấy thông tin khóa học
  ///
  Future fetchCourse() async {
    showLoading();
    try {
      final response = await api.apiServices.getCourse(
        idCourse,
        {'x-atoken-id': prefs.token},
        {'x-client-id': prefs.userID},
      );
      if (response.status! >= 200 || response.status! < 400) {
        getCourseData = response.data?.getCourseData ?? [];

        hideLoading();
        notifyListeners();
      } else {
        showError('Không thể kết nối đến máy chủ.\nVui lòng thử lại.');
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      log(e.message.toString());
      showError('Không thể kết nối đến máy chủ.\nVui lòng thử lại.');
    }
  }

  String convertMillisecondsToSeconds(double value) {
    int seconds = value.floor();
    int sec = seconds % 60;
    int min = (seconds / 60).floor();
    String minute = min.toString().padLeft(2, '0');
    String second = sec.toString().padLeft(2, '0');
    return "$minute:$second";
  }
}
