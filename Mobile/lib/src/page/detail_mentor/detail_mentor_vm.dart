import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kltn/src/base/base_vm.dart';
import 'package:kltn/src/model/course_intro_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../remote/service/respone/mentor/mentor_response.dart';

class DetailMentorVM extends BaseViewModel {
  int index = 0;
  ScrollController scrollController = ScrollController();
  bool checkReadMore = false;
  bool checkLoading = true;
  MentorResponse mentorModel = MentorResponse();
  List<CourseIntroModel> listCourse = [];
  String idMentor = '';
  int page = 1;
  RefreshController reviewRefreshControllrer = RefreshController();
  @override
  void onInit() {
    fetchMentor();
    fetchCourseMentor(isRefresh: true);
  }

  ///
  /// lấy thông tin giảng viên
  ///
  Future fetchMentor() async {
    try {
      final response = await api.apiServices.getInforMentor(idMentor);
      if (response.status! >= 200 || response.status! < 400) {
        mentorModel = response.data ?? MentorResponse();
      } else {
        showError('Không thể kết nối đến máy chủ.\nVui lòng thử lại.');
      }
      checkLoading = false;
      notifyListeners();
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      log(e.message.toString());
      showError('Không thể kết nối đến máy chủ.\nVui lòng thử lại.');
    }
  }

  ///
  /// lấy thông tin khóa học giảng viên
  ///
  Future fetchCourseMentor({required bool isRefresh}) async {
    if (isRefresh) {
      page = 1;
    } else {
      page++;
    }
    notifyListeners();
    try {
      final response = await api.apiServices.getCourseMentor(idMentor, 10, page);
      if (response.status! >= 200 || response.status! < 400) {
        if (isRefresh) {
          listCourse.clear();
          listCourse.addAll(response.data ?? []);
          reviewRefreshControllrer.resetNoData();
          reviewRefreshControllrer.refreshCompleted();
        } else {
          if (response.data!.isNotEmpty) {
            listCourse.addAll(response.data ?? []);
            reviewRefreshControllrer.loadNoData();
            reviewRefreshControllrer.loadComplete();
          } else {
            reviewRefreshControllrer.loadNoData();
          }
        }
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
