import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kltn/src/base/base_vm.dart';
import 'package:kltn/src/model/user_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../model/course_shema_model.dart';
import '../../model/course_type_model.dart';
import '../../model/process_model.dart';
import '../../remote/service/respone/course_process/course_process_response.dart';

class HomeVM extends BaseViewModel {
  ScrollController scrollController = ScrollController();
  List<CourseTypeModel> listTypeModel = [];
  List<CourseShemaModel> listPopularCourse = [];
  RefreshController refreshPopularController = RefreshController();
  RefreshController refreshMentorController = RefreshController();
  RefreshController refreshALlController = RefreshController();
  bool isLoadingCatelory = true;
  bool isLoadingCourse = true;
  bool isLoadingTopMentor = true;
  bool isLoadingContinue = true;
  bool isLoadingUser = true;
  String userName = '';
  bool isLogIn = true;
  int pagePopular = 1;
  int pageMentor = 1;
  bool isEnablePullUpPopular = true;
  bool isEnablePullUpMentor = true;
  List<UserModel> listMentor = [];
  CourseProcessResponse modelProcess = CourseProcessResponse();
  List<ProcessModel> modelProcessOngoing = [];
  int countNews = 0;
  @override
  Future<void> onInit() async {
    await fetchTypeAll();
    fetchPopularCourse(isRefresh: true);
    checkUser();
    fetchCourse();
    fetchAllMentor(isRefresh: true);
    if (prefs.token == null) {
      isLogIn = false;
      notifyListeners();
    }
    newsNotification();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        permissionNotifi();
      },
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void refeshAll() {
    isLoadingUser = true;
    isLoadingCatelory = true;
    isLoadingCourse = true;
    isLoadingTopMentor = true;
    isLoadingContinue = true;
    checkUser();
    fetchTypeAll();
    fetchPopularCourse(isRefresh: true);
    fetchCourse();
    fetchAllMentor(isRefresh: true);
    newsNotification();
    refreshALlController.resetNoData();
    refreshALlController.refreshCompleted();
  }

  Future fetchTypeAll() async {
    try {
      final response = await api.apiServices.getCourseType();
      if (response.status == 200) {
        listTypeModel.clear();
        listTypeModel.addAll(response.data ?? []);
        isLoadingCatelory = false;
        notifyListeners();
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      log(e.message.toString());
      showError('Không thể kết nối đến máy chủ.\nVui lòng thử lại.');
    }
  }

  ///
  /// lấy khóa học phổ biến
  ///
  Future fetchPopularCourse({required bool isRefresh}) async {
    if (isRefresh) {
      pagePopular = 1;
      isEnablePullUpPopular = true;
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
            isEnablePullUpPopular = false;
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

  void checkUser() {
    if ((prefs.userName ?? '').isNotEmpty) {
      userName = prefs.userName ?? '';
    } else {
      userName = 'K26-Demy';
    }
    isLoadingUser = false;
    notifyListeners();
  }

  ///
  /// lấy thông tin khóa học đang học
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
        for (var element in modelProcess.userCourse ?? []) {
          if (element.processCourse < 1) {
            modelProcessOngoing.add(element);
          }
        }
        isLoadingContinue = false;
        notifyListeners();
        hideLoading();
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      log(e.message.toString());
    }
  }

  Future newsNotification() async {
    try {
      final response = await api.apiServices.getNotification(
        '?type=false&limit=1&page=1',
        {'x-atoken-id': prefs.token},
        {'x-client-id': prefs.userID},
      );
      if (response.status! >= 200 || response.status! < 400) {
        countNews = response.data?.numberNotification ?? 0;
        notifyListeners();
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      log(e.message.toString());
    }
  }

  ///
  /// top mentor
  ///
  Future fetchAllMentor({required bool isRefresh}) async {
    if (isRefresh) {
      pageMentor = 1;
      isEnablePullUpMentor = true;
    } else {
      pageMentor++;
    }
    try {
      final response = await api.apiServices.getAllTearcher(10, pageMentor);
      if (response.status == 200) {
        if (isRefresh) {
          listMentor.clear();
          listMentor.addAll(response.data ?? []);
          refreshMentorController.resetNoData();
          refreshMentorController.refreshCompleted();
        } else {
          if (response.data!.isNotEmpty) {
            listMentor.addAll(response.data ?? []);
            refreshMentorController.loadNoData();
            refreshMentorController.loadComplete();
          } else {
            isEnablePullUpMentor = false;
            notifyListeners();
            refreshMentorController.loadNoData();
          }
        }
        isLoadingTopMentor = false;
        notifyListeners();
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      log(e.message.toString());
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

  Future<void> permissionNotifi() async {
    final PermissionStatus status = await Permission.notification.status;
    if (status != PermissionStatus.granted) {
      // await FcmService().requestPermission();
      await Permission.notification.request();
      //    var isStorage2 = await Permission.storage.status;
      //   if (!isStorage2.isGranted) {
      //     // ignore: use_build_context_synchronously
      //     showDialog(
      //       context: context,
      //       builder: (context) => const DialogPermision(title: 'Vui lòng cấp quyền thông báo'),
      //     );
    }
  }
}
