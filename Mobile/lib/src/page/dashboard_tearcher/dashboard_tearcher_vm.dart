import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:kltn/src/base/base_vm.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../model/course_intro_model.dart';

class DashboardTearcherVM extends BaseViewModel {
  List<CourseIntroModel> listCourse = [];
  Map<String, double> listPurchased = {};
  int count = 0;
  bool isLoading = true;
  RefreshController refreshController = RefreshController();
  @override
  void onInit() {
    fetchCourseMentor();
  }

  ///
  /// lấy thông tin khóa học giảng viên
  ///
  Future fetchCourseMentor() async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await api.apiServices.getCourseMentor(prefs.userID, 100, 1);
      if (response.status! >= 200 || response.status! < 400) {
        listCourse.clear();
        listCourse.addAll(response.data ?? []);
        listPurchased.clear();
        for (var element in listCourse) {
          listPurchased.addAll({element.courseName ?? '': (element.coursePurchased ?? 0) * 1.0});
          count = count + (element.coursePurchased ?? 0);
        }
        refreshController.resetNoData();
        refreshController.refreshCompleted();
        isLoading = false;
        notifyListeners();
        // hideLoading();
      } else {
        showError('Không thể kết nối đến máy chủ.\nVui lòng thử lại.');
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      log(e.message.toString());
      showError('Không thể kết nối đến máy chủ.\nVui lòng thử lại.');
    }
  }
}
