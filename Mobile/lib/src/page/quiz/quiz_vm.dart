import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kltn/src/remote/service/body/quiz_body.dart';
import 'package:kltn/src/utils/app_colors.dart';

import '../../base/base_vm.dart';
import '../../remote/service/respone/quiz/quiz_response.dart';

class QuizVM extends BaseViewModel {
  int currentPage = 0;

  PageController pageController = PageController(initialPage: 0);
  List<QuizResponse> listQuizQuestion = [];
  List<QuizBody> quizBody = [];
  double score = 0;
  String idSesstion = '';
  bool isLoading = true;
  int isRight = 0;
  int isWrong = 0;
  @override
  void onInit() {
    Fluttertoast.showToast(msg: 'Cuộn sang phải để qua câu tiếp theo', timeInSecForIosWeb: 3);
    fetchAllQuestionAndAswer(id: idSesstion);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  ///
  /// lấy câu hỏi và câu trả lời
  ///
  Future fetchAllQuestionAndAswer({required String id}) async {
    notifyListeners();
    try {
      final response = await api.apiServices.getQuestionAndAnswerQuiz(
          id, {'x-atoken-id': prefs.token.toString()}, {'x-client-id': prefs.userID.toString()});
      if (response.status! >= 200 || response.status! < 400) {
        score = response.data?.quizScores ?? 0;
        listQuizQuestion = response.data?.printResults ?? [];
        for (var element in response.data!.printResults ?? []) {
          if (element.isCorrect ?? false) {
            isRight++;
          } else {
            isWrong++;
          }
        }
        isLoading = false;
        notifyListeners();
      } else {
        showError('Không thể kết nối đến máy chủ.\nVui lòng thử lại.');
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      log(e.message.toString());
      fetchAllQuestion(id: idSesstion);
    }
  }

  ///
  /// lấy câu hỏi
  ///
  Future fetchAllQuestion({required String id}) async {
    showLoading();
    notifyListeners();
    try {
      final response = await api.apiServices
          .getQuestionQuiz(id, {'x-atoken-id': prefs.token.toString()}, {'x-client-id': prefs.userID.toString()});
      if (response.status! >= 200 || response.status! < 400) {
        isLoading = false;
        listQuizQuestion = response.data ?? [];
        hideLoading();
        notifyListeners();
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
  /// gửi câu trả lời
  ///
  Future postAnswer() async {
    showLoading();
    notifyListeners();
    try {
      final response = await api.apiServices.createAnwserQuiz(
          idSesstion, {'x-atoken-id': prefs.token.toString()}, {'x-client-id': prefs.userID.toString()}, quizBody);
      if (response.status! >= 200 || response.status! < 400) {
        showSucces('Nộp bài thành công');
        fetchAllQuestionAndAswer(id: idSesstion);
        quizBody.clear();
        currentPage = 0;
        goToPage(currentPage);
        hideLoading();
        notifyListeners();
      } else {
        showError('Không thể kết nối đến máy chủ.\nVui lòng thử lại.');
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      log(e.message.toString());
      showError('Không thể kết nối đến máy chủ.\nVui lòng thử lại.');
    }
  }

  void goToPage(int page) {
    currentPage = page;
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
    notifyListeners();
  }

  bool checkSubmit() {
    if (listQuizQuestion.first.isCorrect != null) return false;
    if (currentPage == listQuizQuestion.length - 1) {
      return true;
    }
    return false;
  }

  void addBody(QuizResponse quizResponse, int index) {
    for (var element in quizBody) {
      if (element.questionId == quizResponse.id) {
        quizBody.removeWhere((element) => element.questionId == quizResponse.id);
        quizBody.add(QuizBody()
          ..answersOption = index
          ..questionId = quizResponse.id);
        return;
      }
    }
    quizBody.add(QuizBody()
      ..answersOption = index
      ..questionId = quizResponse.id);
  }

  Color colorBoder(QuizResponse quizResponse, int index) {
    if (quizBody.isEmpty && quizResponse.isCorrect == null) {
      return Colors.grey;
    } else if (quizResponse.isCorrect == null) {
      for (var element in quizBody) {
        if (quizResponse.id == element.questionId) {
          if (index == element.answersOption) {
            return AppColors.blue_246BFD;
          } else {
            return Colors.grey;
          }
        }
      }
    } else {
      if (quizResponse.isCorrect ?? true) {
        if (quizResponse.quizCorrectAnswer == index) {
          return Colors.green;
        }
      } else {
        if (quizResponse.quizCorrectAnswer == index) {
          return Colors.green;
        } else if (quizResponse.answersOption == index) {
          return Colors.red;
        } else {
          return Colors.grey;
        }
      }
    }
    return Colors.grey;
  }

  Widget icon(QuizResponse quizResponse, int index) {
    if (quizResponse.isCorrect == null) {
      return const SizedBox.shrink();
    } else {
      if (quizResponse.isCorrect ?? true) {
        if (quizResponse.quizCorrectAnswer == index) {
          return const Icon(
            Icons.check,
            color: Colors.green,
          );
        }
      } else {
        if (quizResponse.quizCorrectAnswer == index) {
          return const Icon(
            Icons.check,
            color: Colors.green,
          );
        } else if (quizResponse.answersOption == index) {
          return const Icon(
            Icons.close,
            color: Colors.red,
          );
        } else {
          return const SizedBox.shrink();
        }
      }
    }
    return const SizedBox.shrink();
  }

  Color colorBackground(QuizResponse quizResponse, int index) {
    if (quizBody.isEmpty && quizResponse.isCorrect == null) {
      return Colors.white;
    } else if (quizResponse.isCorrect == null) {
      for (var element in quizBody) {
        if (quizResponse.id == element.questionId) {
          if (index == element.answersOption) {
            return AppColors.blue_246BFD.withOpacity(0.1);
          } else {
            return Colors.white;
          }
        }
      }
    } else {
      if (quizResponse.isCorrect ?? true) {
        if (quizResponse.quizCorrectAnswer == index) {
          return Colors.green.withOpacity(0.1);
        }
      } else {
        if (quizResponse.quizCorrectAnswer == index) {
          return Colors.green.withOpacity(0.1);
        } else if (quizResponse.answersOption == index) {
          return Colors.red.withOpacity(0.1);
        } else {
          return Colors.white;
        }
      }
    }
    return Colors.white;
  }
}
