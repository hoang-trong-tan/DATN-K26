import 'package:dio/dio.dart';

import '../base/base_vm.dart';
import '../model/music_model.dart';
import '../remote/service/respone/music_response.dart';


class HomeVM extends BaseViewModel {
  int counter = 0;
  MusicResponse? data;
  List<MusicModel> listData = [];

  @override
  void onInit() {
    print("HomeVM");
    fetchNewsAll();
  }

  Future fetchNewsAll() async {
    showLoading();
    try {
      final response = await api.apiServices.getMusic();
      data = response;
      listData.addAll(data?.dataList ?? []);
      notifyListeners();
      hideLoading();
    } on DioError catch (e) {
      print(e);
      hideLoading();
    }
  }

  void incrementCounter() {
    counter++;
    notifyListeners();
  }
}
