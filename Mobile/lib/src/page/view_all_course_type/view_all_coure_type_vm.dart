import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:kltn/src/base/base_vm.dart';
import 'package:kltn/src/model/course_type_model.dart';

class ViewAllCourseTypeVM extends BaseViewModel {
  List<CourseTypeModel> listTypeModel = [];
  @override
  void onInit() {
    fetchTypeAll();
  }

  Future fetchTypeAll() async {
    showLoading();
    try {
      final response = await api.apiServices.getCourseType();
      if (response.status == 200) {
        listTypeModel.clear();
        listTypeModel.addAll(response.data ?? []);
        notifyListeners();
        hideLoading();
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      log(e.toString());
      hideLoading();
      showError('Không thể kết nối đến máy chủ.\nVui lòng thử lại.');
    }
  }
}
