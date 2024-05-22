import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:kltn/src/model/detail_notification_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../base/base_vm.dart';

class NotificationVM extends BaseViewModel {
  List<DetailNotificationModel> listNotifation = [];
  int page = 1;
  bool isLoading = true;
  int count = 0;
  bool checkNotifi = false;
  RefreshController refreshController = RefreshController();
  @override
  void onInit() {
    fetchAllNotification(isRefresh: true);
  }

  Future fetchAllNotification({required bool isRefresh}) async {
    notifyListeners();
    if (isRefresh) {
      page = 1;
    } else {
      page++;
    }
    try {
      final response = await api.apiServices.getNotification(
        '?limit=10&page=$page',
        {'x-atoken-id': prefs.token},
        {'x-client-id': prefs.userID},
      );
      if (response.status! >= 200 && response.status! < 400) {
        count = response.data?.numberNotification ?? 0;
        if (isRefresh) {
          listNotifation.clear();
          listNotifation.addAll(response.data?.notifications ?? []);
          refreshController.resetNoData();
          refreshController.refreshCompleted();
        } else {
          if ((response.data?.notifications ?? []).isNotEmpty) {
            listNotifation.addAll(response.data?.notifications ?? []);
            refreshController.loadNoData();
            refreshController.loadComplete();
          } else {
            notifyListeners();
            refreshController.loadNoData();
          }
        }
        isLoading = false;
        notifyListeners();
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      log(e.message.toString());
    }
  }

  Future<void> readNotify(String idNotifi, int index) async {
    try {
      final response = await api.apiServices.readNotication(
        idNotifi,
        {'x-atoken-id': prefs.token},
        {'x-client-id': prefs.userID},
      );
      if (response.status! >= 200 && response.status! < 400) {
        listNotifation[index].status = true;
        checkNotifi = true;
        notifyListeners();
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      log(e.message.toString());
    }
  }
}
