import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kltn/src/model/course_model.dart';
import 'package:kltn/src/remote/service/body/reply_body.dart';
import 'package:kltn/src/remote/service/body/review_body.dart';
import 'package:kltn/src/remote/service/respone/base_response.dart';
import 'package:kltn/src/remote/service/respone/mentor/mentor_response.dart';
import 'package:kltn/src/remote/service/respone/review/review_response.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../base/base_vm.dart';

class DetailCourseVM extends BaseViewModel {
  List<String> listTap = ['Mô tả', 'Bài giảng', 'Đánh giá'];
  int index = 0;
  bool checkPlay = true;
  bool checkReadMore = false;
  List<CourseModel> listData = [];
  String id = '';
  ScrollController scrollController = ScrollController();
  DeatilCouseRespone model = DeatilCouseRespone();
  TextEditingController reivewController = TextEditingController();
  TextEditingController replyCommentController = TextEditingController();
  RefreshController reviewRefreshControllrer = RefreshController();
  List<ReviewResponse> listComment = [];
  MentorResponse mentorModel = MentorResponse();
  bool isLoading = true;
  bool checkPay = false;
  bool checkBotomShow = true;
  double numberStar = 5;
  Function(String)? callback;
  Map<int, bool> listCheckReply = {};
  Map<int, bool> listCheckViewReply = {};
  int pageReview = 1;
  bool isLogin = true;

  @override
  Future<void> onInit() async {
    if (prefs.token == null) {
      isLogin = false;
    }
    if (id.isNotEmpty) {
      if (prefs.token == null) {
        await fetchCourseNoLogin();
      } else {
        await fetchCourse();
      }

      fetchAllReview(isRefresh: true);
      fetchMentor();
    }
  }

  ///
  /// lấy thông tin khóa học
  ///
  Future fetchCourse() async {
    isLoading = true;
    try {
      final response = await api.apiServices.getCourse(
        id,
        {'x-atoken-id': prefs.token},
        {'x-client-id': prefs.userID},
      );
      if (response.status! >= 200 || response.status! < 400) {
        listData.clear();
        listData.addAll(response.data?.getCourseData ?? []);
        model = response.data!;
        try {
          checkPay = response.data?.getCourseData![0].courseDataVideo?.courseVideo?[0].videoUrl?.isNotEmpty ?? false;
        } catch (e) {
          log(e.toString());
        }
        isLoading = false;
        notifyListeners();
        hideLoading();
      } else {
        showError('Không thể kết nối đến máy chủ.\nVui lòng thử lại.');
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      log(e.message.toString());
      showError('Không thể kết nối đến máy chủ.\nVui lòng thử lại.');
    }
  }

  ///
  /// lấy thông tin khóa học
  ///
  Future fetchCourseNoLogin() async {
    try {
      final response = await api.apiServices.getCourseNoLogin(
        id,
      );
      if (response.status! >= 200 || response.status! < 400) {
        listData.clear();
        listData.addAll(response.data?.getCourseData ?? []);
        model = response.data!;
        try {
          checkPay = response.data?.getCourseData![0].courseDataVideo?.courseVideo?[0].videoUrl?.isNotEmpty ?? false;
        } catch (e) {
          log(e.toString());
        }
        isLoading = false;
        notifyListeners();
        hideLoading();
      } else {
        showError('Không thể kết nối đến máy chủ.\nVui lòng thử lại.');
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      log(e.message.toString());
      showError('Không thể kết nối đến máy chủ.\nVui lòng thử lại.');
    }
  }

  void checkShowBottomShett() {
    checkBotomShow = !checkBotomShow;
    notifyListeners();
  }

  ///
  /// lấy thông tin giản viên
  ///
  Future fetchMentor() async {
    // showLoading();
    notifyListeners();
    try {
      final response = await api.apiServices.getInforMentor(model.userTeacher?.id ?? '');
      if (response.status! >= 200 || response.status! < 400) {
        mentorModel = response.data ?? MentorResponse();
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

  ///
  /// thêm chữ "đã xem"
  ///
  void setIsView(int index1, int index2) {
    listData[index1].courseDataVideo?.courseVideo?[index2].isSeen = true;
    notifyListeners();
  }

  ///
  /// lấy review
  ///
  Future fetchAllReview({required bool isRefresh}) async {
    // showLoading();
    if (isRefresh) {
      pageReview = 1;
    } else {
      pageReview++;
    }
    notifyListeners();
    try {
      final response = await api.apiServices.getReview(id, 10, pageReview);
      if (response.status! >= 200 || response.status! < 400) {
        listCheckReply = {};
        listCheckViewReply = {};
        if (isRefresh) {
          listComment.clear();
          listComment.addAll(response.data ?? []);
          reviewRefreshControllrer.resetNoData();
          reviewRefreshControllrer.refreshCompleted();
        } else {
          if (response.data!.isNotEmpty) {
            listComment.addAll(response.data ?? []);
            reviewRefreshControllrer.loadNoData();
            reviewRefreshControllrer.loadComplete();
          } else {
            reviewRefreshControllrer.loadNoData();
          }
        }
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

  ///
  /// mua khóa học
  ///
  Future payCourse(String id) async {
    showLoading();
    try {
      final respone = await api.apiServices.payCourse(id, {'x-atoken-id': prefs.token}, {'x-client-id': prefs.userID});
      if (respone.code! >= 200) {
        hideLoading();
        callback?.call(respone.url ?? '');
        notifyListeners();
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      log(e.message.toString());
      if (e.response?.statusCode == 400) {
        showError('Khóa học này đã được mua');
      }
      hideLoading();
    }
  }

  ///
  /// tạo review
  ///
  Future createReview(String id) async {
    showLoading();
    final body = ReviewBody()
      ..reviewComment = reivewController.text.trim()
      ..reviewRating = numberStar.toInt();
    try {
      final respone =
          await api.apiServices.createReview(id, {'x-atoken-id': prefs.token}, {'x-client-id': prefs.userID}, body);
      if (respone.status! >= 200) {
        hideLoading();
        fetchAllReview(isRefresh: true);
        model.isUserReview = true;
        showSucces('Đánh giá thành công');
        notifyListeners();
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      log(e.message.toString());
      if (e.response?.statusCode == 400) {
        showError('Khóa học này đã được đánh giá');
      }
      hideLoading();
    }
  }

  ///
  /// tạo reply
  ///
  Future createReply({required String idComment}) async {
    showLoading();
    final body = ReplyCommentBody()
      ..courseId = id
      ..replyComment = replyCommentController.text.trim();
    try {
      final respone = await api.apiServices
          .createReplyComent(idComment, {'x-atoken-id': prefs.token}, {'x-client-id': prefs.userID}, body);
      if (respone.status! >= 200) {
        fetchAllReview(isRefresh: true);
        hideLoading();
        showSucces('Phản hồi thành công');
        notifyListeners();
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      log(e.message.toString());
      if (e.response?.statusCode == 400) {
        showError('Bạn đã phản hồi đánh giá này');
      } else if (e.response?.statusCode == 403) {
        showError('Bạn không thể phản hồi đánh giá này');
      }
      hideLoading();
    }
  }

  bool? isListDetailVisible(int index) {
    return listCheckReply.containsKey(index) ? listCheckReply[index] : false;
  }

  void show(bool error, {int codeError = 1}) {
    if (error == true) {
      showSucces('Thanh toán thành công');
    } else {
      showError(errorVnpay(codeError));
    }
  }

  void showCompleted(String content) {
    showSucces(content);
  }

  bool checkVisibleReview() {
    if (prefs.userID == (mentorModel.findTeacher?.id ?? '')) {
      return false;
    }
    if ((model.getCourseData ?? []).isNotEmpty) {
      if (model.getCourseData?.first.courseDataVideo?.courseVideo?.first.videoUrl != null) {
        return !(model.isUserReview ?? false);
      }
    }
    return false;
  }

  String errorVnpay(int code) {
    switch (code) {
      case 07:
        return 'Trừ tiền thành công. Giao dịch bị nghi ngờ (liên quan tới lừa đảo, giao dịch bất thường).';
      case 09:
        return 'Giao dịch không thành công do: Thẻ/Tài khoản của bạn chưa đăng ký dịch vụ InternetBanking tại ngân hàng.';
      case 10:
        return 'Giao dịch không thành công do: Bạn đã xác thực thông tin thẻ/tài khoản không đúng quá 3 lần';
      case 11:
        return 'Giao dịch không thành công do: Đã hết hạn chờ thanh toán. Xin quý khách vui lòng thực hiện lại giao dịch.';
      case 12:
        return 'Giao dịch không thành công do: Thẻ/Tài khoản của khách hàng bị khóa.';
      case 13:
        return 'Giao dịch không thành công do Quý khách nhập sai mật khẩu xác thực giao dịch (OTP). Xin quý khách vui lòng thực hiện lại giao dịch.';
      case 24:
        return 'Giao dịch không thành công do: Bạn đã hủy giao dịch';
      case 51:
        return 'Giao dịch không thành công do: Tài khoản của quý khách không đủ số dư để thực hiện giao dịch.';
      case 65:
        return 'Giao dịch không thành công do: Tài khoản của Quý khách đã vượt quá hạn mức giao dịch trong ngày.';
      case 75:
        return 'Ngân hàng thanh toán đang bảo trì.';
      case 79:
        return 'Giao dịch không thành công do: Bạn nhập sai mật khẩu thanh toán quá số lần quy định. Xin quý khách vui lòng thực hiện lại giao dịch';
      default:
        return 'Thanh toán không thành công';
    }
  }

  String convertMillisecondsToSeconds(double value) {
    int seconds = value.floor();
    int sec = seconds % 60;
    int min = (seconds / 60).floor();
    String minute = min.toString().padLeft(2, '0');
    String second = sec.toString().padLeft(2, '0');
    return "$minute:$second";
  }

  String convertSecondsToMinute(int values) {
    int minutes = values ~/ 60; // Số phút
    int hours = minutes ~/ 60; // Số giờ
    int remainingMinutes = minutes % 60;
    return '$hours tiếng $remainingMinutes phút';
  }
}
