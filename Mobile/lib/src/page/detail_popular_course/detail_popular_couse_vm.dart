import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:kltn/src/base/base_vm.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../model/course_shema_model.dart';

class DetailPopularCourseVM extends BaseViewModel {
  RefreshController refreshPopularController = RefreshController();
  int pagePopular = 1;
  List<CourseShemaModel> listPopularCourse = [];
  bool isLoadingCourse = true;
  @override
  void onInit() {
    fetchPopularCourse(isRefresh: true);
  }

  ///
  /// lấy khóa học phổ biến
  ///
  Future fetchPopularCourse({required bool isRefresh}) async {
    if (isRefresh) {
      pagePopular = 1;
    } else {
      pagePopular++;
    }
    try {
      final response = await api.apiServices.getpopularCourse(10, pagePopular, {'userId': prefs.userID ?? ''});
      if (response.status == 200) {
        if (isRefresh) {
          listPopularCourse.clear();
          listPopularCourse.addAll(response.data ?? []);
          refreshPopularController.resetNoData();
          refreshPopularController.refreshCompleted();
        } else {
          if (response.data!.isNotEmpty) {
            listPopularCourse.addAll(response.data ?? []);
            refreshPopularController.loadNoData();
            refreshPopularController.loadComplete();
          } else {
            notifyListeners();
            refreshPopularController.loadNoData();
          }
        }
        isLoadingCourse = false;
        notifyListeners();
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      log(e.message.toString());
      showError('Không thể kết nối đến máy chủ.\nVui lòng thử lại.');
    }
  }

  ///
  /// theem gior hang
  ///
  Future addCart(String? idCourse) async {
    showLoading();
    try {
      final response =
          await api.apiServices.postCart(idCourse, {'x-atoken-id': prefs.token}, {'x-client-id': prefs.userID});
      if (response.status! >= 200 || response.status! < 400) {
        showSucces('Thêm vào danh sách yêu thích thành công');
        hideLoading();
      } else {
        showError('Không thể kết nối đến máy chủ.\nVui lòng thử lại.');
      }
      notifyListeners();
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      log(e.message.toString());
      if (e.response?.statusCode == 400) {
        showError('Khóa học đã tồn tại.');
      }
      hideLoading();
    }
  }
}
