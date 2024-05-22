import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kltn/src/model/course_intro_model.dart';
import 'package:kltn/src/model/user_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../base/base_vm.dart';
import '../../base/di/locator.dart';
import '../../remote/local/shared_prefs.dart';

class SearchVM extends BaseViewModel {
  bool checkSearch = false;
  bool checkViewSearch = false;
  TextEditingController controller = TextEditingController();
  List<String> listRecent = [];
  final getListRecent = locator<SharedPrefs>().searchRecent;
  // final setListRecent = locator<SharedPrefs>().searchRecent;
  final removeListRecent = locator<SharedPrefs>().removeSearchRecent();
  Timer? debounce;
  int index = 0;
  int page = 1;
  String typeSearch = 'course';
  RefreshController refreshController = RefreshController();
  List<CourseIntroModel> listSearch = [];
  List<UserModel> listSearchUser = [];
  bool checkloadingsearch = true;
  bool enablePullUp = true;
  @override
  void onInit() {
    listRecent = getListRecent ?? [];
    notifyListeners();
  }

  Future<void> setPrefRecentSearch(String values) async {
    listRecent.add(values);
    prefs.searchRecent = listRecent;
  }

  Future<void> setPrefRecentSearchList() async {
    prefs.searchRecent = listRecent;
  }

  Future fetchSearchByType({required bool refresh}) async {
    if (checkloadingsearch) {
      showLoading();
    }
    if (refresh) {
      page = 1;
    } else {
      page = page + 1;
    }
    try {
      final response = await api.apiServices.getSearch(controller.text, 'course', 10, page);
      if (response.status! >= 200 || response.status! < 400) {
        if (refresh) {
          listSearch.clear();
          listSearch.addAll(response.data ?? []);
          enablePullUp = true;
          refreshController.resetNoData();
          refreshController.refreshCompleted();
        } else {
          if (response.data!.isNotEmpty) {
            listSearch.addAll(response.data ?? []);
            enablePullUp = true;
            refreshController.loadNoData();
            refreshController.loadComplete();
          } else {
            enablePullUp = false;
            refreshController.loadNoData();
          }
        }

        hideLoading();
        notifyListeners();
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      debugger(when: true, message: e.message);
      hideLoading();
      showError('Không thể kết nối đến máy chủ.\nVui lòng thử lại.');
    }
  }

  Future fetchSearchUser({required bool refresh}) async {
    if (checkloadingsearch) {
      showLoading();
    }
    if (refresh) {
      page = 1;
    } else {
      page = page + 1;
    }
    try {
      final response = await api.apiServices.getSearchUser(controller.text, 'mentor', 10, page);
      if (response.status! >= 200 || response.status! < 400) {
        if (refresh) {
          listSearchUser.clear();
          listSearchUser.addAll(response.data ?? []);
          enablePullUp = true;
          refreshController.resetNoData();
          refreshController.refreshCompleted();
        } else {
          if (response.data!.isNotEmpty) {
            listSearchUser.addAll(response.data ?? []);
            enablePullUp = true;
            refreshController.loadNoData();
            refreshController.loadComplete();
          } else {
            enablePullUp = false;
            refreshController.loadNoData();
          }
        }

        hideLoading();
        notifyListeners();
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      debugger(when: true, message: e.message);
      hideLoading();
      showError('Không thể kết nối đến máy chủ.\nVui lòng thử lại.');
    }
  }
}
