import 'dart:developer';
import 'package:chewie/chewie.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kltn/src/base/base_vm.dart';
import 'package:kltn/src/model/quiz_title_model.dart';
import 'package:kltn/src/page/video/widget/dialog_permission.dart';
import 'package:kltn/src/remote/service/body/answer_body.dart';
import 'package:kltn/src/remote/service/body/question_body.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:video_player/video_player.dart';
import '../../model/course_detail_model.dart';
import '../../remote/service/respone/answer_and_question/answer_and_question_response.dart';
import 'widget/dir.dart';

class VideoVM extends BaseViewModel {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  // late Future<void> initVideoPlayerFuture;
  Map<int, bool> listCheckReply = {};
  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();
  RefreshController refreshController = RefreshController();
  List<AnswerAndQuestionRespone> listAnswerAndQuestion = [];
  CourseDetailModel modelVideo = CourseDetailModel();
  String idCourse = '';
  String idVideo = '';
  int index = 0;
  bool isLoading = true;
  int pageReview = 1;
  bool checkProcess = false;
  List<QuizTitleModel> quizTitleModel = [];
  List<String> listDocument = [];
  bool dowloading = false;
  bool fileExists = false;
  double progress = 0;
  String fileName = "";
  late String filePath;
  String url = '';
  bool isView = true;
  late CancelToken cancelToken;
  var getPathFile = DirectoryPath();
  bool checkView = true;
  @override
  Future<void> onInit() async {
    if (idVideo.isNotEmpty) {
      await fetchVideo();
      Future.delayed(
        const Duration(seconds: 1),
        () {
          checkView = false;
          notifyListeners();
        },
      );
    }

    fetchAllQuestionAndAnwser(isRefresh: true);
    fetchDocument();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  bool? isListDetailVisible(int index) {
    return listCheckReply.containsKey(index) ? listCheckReply[index] : false;
  }

  Duration getCurrentPosition() {
    return videoPlayerController.value.position;
  }

  void playFromSeconds(int seconds) {
    videoPlayerController.seekTo(Duration(seconds: seconds));
    videoPlayerController.play();
  }

  ///
  /// gửi tiến trình
  ///
  Future createProcess() async {
    try {
      final respone = await api.apiServices.postVideoView(
          idCourse, {'x-atoken-id': prefs.token}, {'x-client-id': prefs.userID}, {'video_shema': idVideo});
      if (respone.status! >= 200) {
        notifyListeners();
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      log(e.message.toString());
    }
  }

  ///
  /// tạo question
  ///
  Future createQuestion() async {
    showLoading();
    if (questionController.text.trim().isEmpty) {
      showError('Vui lòng đặt câu hỏi');
    } else {
      final body = QuestionBody()
        ..courseId = idCourse
        ..questionComment = questionController.text
        ..videoTime = getCurrentPosition().inSeconds;
      try {
        final respone = await api.apiServices
            .createQuestion(idVideo, {'x-atoken-id': prefs.token}, {'x-client-id': prefs.userID}, body);
        if (respone.status! >= 200) {
          fetchAllQuestionAndAnwser(isRefresh: true);
          hideLoading();
          answerController.text = '';
          questionController.text = '';
          showSucces('Tạo câu hỏi thành công');
          notifyListeners();
        }
        // ignore: deprecated_member_use
      } on DioError catch (e) {
        log(e.message.toString());
        if (e.response?.statusCode == 400) {
          showError('Bạn đã phản hồi đánh giá này');
        }
        hideLoading();
      }
    }
  }

  ///
  /// tạo anwser
  ///
  Future createAnwser({required String idQuestion}) async {
    showLoading();
    if (answerController.text.trim().isEmpty) {
      showError('Vui lòng nhập câu trả lời');
    } else {
      final body = AnwserBody()..answserComment = answerController.text;
      try {
        final respone = await api.apiServices
            .createAnwser(idQuestion, {'x-atoken-id': prefs.token}, {'x-client-id': prefs.userID}, body);
        if (respone.status! >= 200) {
          fetchAllQuestionAndAnwser(isRefresh: true);
          hideLoading();
          answerController.text = '';
          questionController.text = '';
          showSucces('Trả lời thành công');
          notifyListeners();
        }
        // ignore: deprecated_member_use
      } on DioError catch (e) {
        log(e.message.toString());
        if (e.response?.statusCode == 400) {
          showError('Bạn đã phản hồi đánh giá này');
        }
        hideLoading();
      }
    }
  }

  ///
  /// lấy câu hỏi và trả lời
  ///
  Future fetchAllQuestionAndAnwser({required bool isRefresh}) async {
    if (isRefresh) {
      pageReview = 1;
    } else {
      pageReview++;
    }
    notifyListeners();
    try {
      final response = await api.apiServices
          .getQuestionAndAnwser(idVideo, {'x-atoken-id': prefs.token}, {'x-client-id': prefs.userID}, 10, pageReview);
      if (response.status == 200) {
        listCheckReply = {};
        if (isRefresh) {
          listAnswerAndQuestion.clear();
          listAnswerAndQuestion.addAll(response.data ?? []);
          refreshController.resetNoData();
          refreshController.refreshCompleted();
        } else {
          if (response.data!.isNotEmpty) {
            listAnswerAndQuestion.addAll(response.data ?? []);
            refreshController.loadNoData();
            refreshController.loadComplete();
          } else {
            refreshController.loadNoData();
          }
        }
        isLoading = false;
        notifyListeners();
      } else {
        // showError('Không thể kết nối đến máy chủ.\nVui lòng thử lại.');
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      log(e.message.toString());
      // showError('Không thể kết nối đến máy chủ.\nVui lòng thử lại.');
      isLoading = false;
      hideLoading();
    }
  }

  ///
  /// lấy video
  ///
  Future fetchVideo() async {
    try {
      final response = await api.apiServices.getVideo(
        idVideo,
        {'x-atoken-id': prefs.token},
        {'x-client-id': prefs.userID},
      );
      if (response.status! >= 200) {
        modelVideo = response.data ?? CourseDetailModel();

        notifyListeners();
      } else {
        // showError('Không thể kết nối đến máy chủ.\nVui lòng thử lại.');
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      log(e.message.toString());
      // showError('Không thể kết nối đến máy chủ.\nVui lòng thử lại.');
      isLoading = false;
      hideLoading();
    }
  }

  ///
  /// lấy tài liệu
  ///
  Future fetchDocument() async {
    try {
      final response =
          await api.apiServices.getAllDocument(idVideo, {'x-atoken-id': prefs.token}, {'x-client-id': prefs.userID});
      if (response.status! >= 200 || response.status! < 400) {
        listDocument.clear();
        listDocument.addAll(response.data ?? []);
        notifyListeners();
      } else {
        // showError('Không thể kết nối đến máy chủ.\nVui lòng thử lại.');
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      log(e.message.toString());
      // showError('Không thể kết nối đến máy chủ.\nVui lòng thử lại.');
      isLoading = false;
      hideLoading();
    }
  }

  Future<void> downloadDocument(BuildContext context, String fileName) async {
    final DeviceInfoPlugin info = DeviceInfoPlugin();
    final AndroidDeviceInfo androidInfo = await info.androidInfo;
    debugPrint('releaseVersion : ${androidInfo.version.release}');
    final int androidVersion = int.parse(androidInfo.version.release);
    // var isStorage = await Permission.manageExternalStorage.status;
    bool havePermission = false;
    if (androidVersion >= 13) {
      final request = await [
        Permission.videos,
        Permission.photos,
        //..... as needed
      ].request();
      havePermission = request.values.every((status) => status == PermissionStatus.granted);
    } else {
      final status = await Permission.storage.request();
      havePermission = status.isGranted;
    }
    if (!havePermission) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => const DialogPermision(),
      );
    } else {
      await startDownload(fileName);
      hideLoading();
      notifyListeners();
      OpenFile.open(filePath);
    }
  }

  startDownload(String fileName) async {
    cancelToken = CancelToken();
    var storePath = await getPathFile.getPath();
    filePath = '$storePath/$fileName';

    dowloading = true;
    progress = 0;
    showLoading();
    try {
      await Dio().download('http://54.251.153.22:3000/v1/api/download-document/$idVideo?fileName=$fileName', filePath,
          onReceiveProgress: (count, total) {
        progress = (count / total);
      }, cancelToken: cancelToken);
      dowloading = false;
      fileExists = true;
    } catch (e) {
      log(e.toString());
      {
        dowloading = false;
      }
    }
  }
  // cancelDownload() {
  //   cancelToken.cancel();
  //   setState(() {
  //     dowloading = false;
  //   });
  // }

  // void checkFileExit() async {
  //   var storePath = await getPathFile.getPath();
  //   filePath = '$storePath/$fileName';
  //   bool fileExistCheck = await File(filePath).exists();
  //   fileExists = fileExistCheck;
  // }
}
