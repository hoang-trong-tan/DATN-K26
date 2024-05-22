import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kltn/src/base/base_page.dart';
import 'package:kltn/src/page/quiz/quiz_vm.dart';
import 'package:kltn/src/page/quiz/widget/quiz_loading_widget.dart';
import 'package:kltn/src/utils/app_colors.dart';

import 'widget/dialog_select_number_question.dart';
import 'widget/item_answer_widget.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key, required this.id});
  final String id;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with MixinBasePage<QuizVM> {
  @override
  Widget build(BuildContext context) {
    return builder(
      () => provider.isLoading
          ? const QuizLoadingWidget()
          : Scaffold(
              body: SizedBox(
                height: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(top: 55, left: 15, right: 15),
                  child: Stack(
                    children: [
                      Image.asset('assets/image/quiz_background.png'),
                      Positioned(
                        top: 150,
                        left: 0,
                        right: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration:
                              BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white, boxShadow: [
                            BoxShadow(
                              color: AppColors.blue_246BFD.withOpacity(0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 4),
                              spreadRadius: 0,
                            ),
                          ]),
                          child: Column(children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Visibility(
                              visible: provider.listQuizQuestion.first.isCorrect != null,
                              child: Row(
                                children: [
                                  Text(
                                    provider.isRight.toString(),
                                    style:
                                        const TextStyle(color: Colors.green, fontSize: 14, fontWeight: FontWeight.w600),
                                  ),
                                  Container(
                                    width: 50,
                                    margin: const EdgeInsets.only(left: 5),
                                    height: 8,
                                    decoration: const BoxDecoration(
                                        color: Colors.green, borderRadius: BorderRadius.all(Radius.circular(10))),
                                  ),
                                  const Spacer(),
                                  Container(
                                    width: 50,
                                    margin: const EdgeInsets.only(right: 5),
                                    height: 8,
                                    decoration: const BoxDecoration(
                                        color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(10))),
                                  ),
                                  Text(
                                    provider.isWrong.toString(),
                                    style:
                                        const TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            Text(
                              'Câu hỏi ${provider.currentPage + 1}/${provider.listQuizQuestion.length}',
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.blue_246BFD),
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            Text(
                              provider.listQuizQuestion[provider.currentPage].quizQuestions ?? '',
                              textAlign: TextAlign.center,
                              style:
                                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xff2B262D)),
                            ),
                            const SizedBox(
                              height: 30,
                            )
                          ]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 90),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: 100,
                            width: 100,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Colors.white),
                            child: Stack(
                              children: [
                                Center(
                                  child: SizedBox(
                                    height: 85,
                                    width: 85,
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                      color: AppColors.blue_246BFD,
                                      strokeWidth: 5,
                                      value: (provider.currentPage + 1) / provider.listQuizQuestion.length,
                                      strokeCap: StrokeCap.square,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    provider.listQuizQuestion.first.isCorrect == null
                                        ? (provider.currentPage + 1).toString()
                                        : '${provider.score}/10',
                                    style: const TextStyle(
                                        color: AppColors.blue_246BFD, fontSize: 20, fontWeight: FontWeight.w600),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        left: 20,
                        right: 20,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return DialogSelectNumberQuestion(
                                        provider: provider,
                                      );
                                    },
                                  );
                                },
                                child: SvgPicture.asset('assets/image/quiz_number.svg'))
                          ],
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: MediaQuery.of(context).size.height > 750 ? 100 : 0,
                        child: SizedBox(
                          height: 320,
                          child: ScrollConfiguration(
                            behavior: const ScrollBehavior().copyWith(overscroll: false),
                            child: provider.listQuizQuestion.isNotEmpty
                                ? PageView.builder(
                                    itemCount: provider.listQuizQuestion.length,
                                    controller: provider.pageController,
                                    scrollDirection: Axis.horizontal,
                                    onPageChanged: (value) {
                                      setState(() {
                                        provider.currentPage = value;
                                      });
                                    },
                                    itemBuilder: (context, index) {
                                      return (provider.listQuizQuestion[provider.currentPage].quizOptions?.length ??
                                                  0) !=
                                              0
                                          ? ItemAnswerWidget(
                                              provider: provider,
                                            )
                                          : const Center(
                                              child: Text(
                                                'Chưa có câu trả lời',
                                                style: TextStyle(color: Colors.black, fontSize: 14),
                                              ),
                                            );
                                    },
                                  )
                                : const Center(
                                    child: Text(
                                      'Chưa có câu hỏi nào',
                                      style: TextStyle(color: Colors.black, fontSize: 14),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Visibility(
                          visible: provider.checkSubmit(),
                          child: GestureDetector(
                            onTap: provider.listQuizQuestion.length == provider.quizBody.length
                                ? () {
                                    provider.postAnswer();
                                  }
                                : () {},
                            child: Container(
                              // width: 120,
                              height: 50,
                              margin: const EdgeInsets.only(bottom: 20),
                              padding: const EdgeInsetsDirectional.symmetric(vertical: 13),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: provider.listQuizQuestion.length == provider.quizBody.length
                                    ? AppColors.blue_246BFD
                                    : Colors.grey,
                              ),
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Nộp ngay',
                                  style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  @override
  QuizVM create() {
    return QuizVM();
  }

  @override
  void initialise(BuildContext context) {
    provider.idSesstion = widget.id;
  }
}
