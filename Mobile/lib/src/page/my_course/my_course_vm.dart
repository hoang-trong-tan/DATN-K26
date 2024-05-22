import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:kltn/src/base/base_vm.dart';
import 'package:kltn/src/remote/service/respone/course_process/course_process_response.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../model/process_model.dart';

class MyCourseVM extends BaseViewModel {
  List<String> item = ['Đang học', 'Hoàn thành'];
  int index = 0;
  ScrollController ongoingControler = ScrollController();
  ScrollController completedController = ScrollController();
  RefreshController refreshController = RefreshController();
  RefreshController refreshCompletedController = RefreshController();
  bool isLoadingCompleted = true;
  bool isLoadingOnging = true;
  CourseProcessResponse modelProcess = CourseProcessResponse();
  List<ProcessModel> modelProcessCompleted = [];
  List<ProcessModel> modelProcessOngoing = [];
  @override
  void onInit() {
    fetchCourse();
  }

  ///
  /// lấy thông tin khóa học
  ///
  Future fetchCourse() async {
    try {
      final response = await api.apiServices.getCourseProcess(
        {'x-atoken-id': prefs.token},
        {'x-client-id': prefs.userID},
      );
      if (response.status! >= 200 || response.status! < 400) {
        modelProcess = response.data ?? CourseProcessResponse();
        modelProcessOngoing.clear();
        modelProcessCompleted.clear();
        for (var element in modelProcess.userCourse ?? []) {
          if (element.processCourse < 1) {
            modelProcessOngoing.add(element);
          } else {
            modelProcessCompleted.add(element);
          }
        }
        refreshController.resetNoData();
        refreshController.refreshCompleted();
        refreshCompletedController.resetNoData();
        refreshCompletedController.refreshCompleted();

        isLoadingCompleted = false;
        isLoadingOnging = false;
        notifyListeners();
        hideLoading();
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      log(e.message.toString());
    }
  }
}
