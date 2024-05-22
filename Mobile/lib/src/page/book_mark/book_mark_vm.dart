import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kltn/src/base/base_vm.dart';
import 'package:kltn/src/model/course_type_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../remote/service/respone/cart/cart_response.dart';

class BookMarkVM extends BaseViewModel {
  List<CourseTypeModel> listTypeModel = [
    CourseTypeModel.fromJson({'_id': '', 'type_name': 'All'})
  ];
  int index = 0;

  bool isLoadingCatelory = true;
  bool isLoadingCourse = true;
  ScrollController scrollController = ScrollController();
  RefreshController refreshController = RefreshController();
  List<CartResponse> listCart = [];
  @override
  void onInit() {
    fetchTypeAll();
    getCart();
  }

  Future fetchTypeAll() async {
    // showLoading();
    try {
      final response = await api.apiServices.getCourseType();
      if (response.status! >= 200 && response.status! < 400) {
        // listTypeModel.clear();
        listTypeModel.addAll(response.data ?? []);
        isLoadingCatelory = false;
        notifyListeners();
        // hideLoading();
      } else {
        // showError('Không thể kết nối đến máy chủ.\nVui lòng thử lại.');
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      log(e.message.toString());
      // showError('Không thể kết nối đến máy chủ.\nVui lòng thử lại.');
    }
  }

  String filtter(String id) {
    if (id.isEmpty) {
      return '';
    }
    return '?courseType=$id';
  }

  Future getCart({String? id}) async {
    // showLoading();
    isLoadingCourse = true;
    notifyListeners();
    try {
      final response =
          await api.apiServices.getCart(filtter(id ?? ''), {'x-atoken-id': prefs.token}, {'x-client-id': prefs.userID});
      if (response.status! >= 200 && response.status! < 400) {
        listCart.clear();
        listCart.addAll(response.data ?? []);
        isLoadingCourse = false;
        refreshController.resetNoData();
        refreshController.refreshCompleted();
        notifyListeners();
        // hideLoading();
      } else {
        // showError('Không thể kết nối đến máy chủ.\nVui lòng thử lại.');
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      isLoadingCourse = false;
      notifyListeners();
      log(e.message.toString());
      // showError('Không thể kết nối đến máy chủ.\nVui lòng thử lại.');
    }
  }

  Future deleteCart(String? id, BuildContext context, int index) async {
    showLoading();
    try {
      final response =
          await api.apiServices.deleteCart(id, {'x-atoken-id': prefs.token}, {'x-client-id': prefs.userID});
      if (response.status! >= 200 && response.status! < 400) {
        hideLoading();
        showSucces('Xoá thành công.');
        listCart.removeAt(index);
        notifyListeners();
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } else {
        // showError('Không thể kết nối đến máy chủ.\nVui lòng thử lại.');
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      hideLoading();
      log(e.message.toString());
      showError('Xóa không thành công');
    }
  }

  String typeCourse(String id) {
    for (var element in listTypeModel) {
      if (element.id == id) {
        return element.typeName ?? '';
      }
    }
    return '';
  }
}
