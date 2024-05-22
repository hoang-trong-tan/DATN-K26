import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:kltn/src/base/base_vm.dart';
import 'package:kltn/src/model/user_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DetailTopMentorVM extends BaseViewModel {
  List<UserModel> listMentor = [];
  bool isLoading = true;
  int pageMentor = 1;
  RefreshController refreshMentorController = RefreshController();
  @override
  void onInit() {
    fetchAllMentor(isRefresh: true);
  }

  ///
  /// top mentor
  ///
  Future fetchAllMentor({required bool isRefresh}) async {
    if (isRefresh) {
      pageMentor = 1;
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
            notifyListeners();
            refreshMentorController.loadNoData();
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
}
