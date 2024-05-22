import 'package:flutter/material.dart';
import 'package:kltn/src/page/quiz/quiz_page.dart';
import 'package:kltn/src/page/video/video_vm.dart';
import 'package:kltn/src/utils/app_colors.dart';

class QuizWidget extends StatefulWidget {
  const QuizWidget({super.key, required this.provider});
  final VideoVM provider;

  @override
  State<QuizWidget> createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.provider.quizTitleModel.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Text(
                  'Kiểm tra kiến thức',
                  style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 450,
                child: ListView.separated(
                  itemCount: widget.provider.quizTitleModel.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        widget.provider.chewieController.pause();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuizPage(
                              id: widget.provider.quizTitleModel[index].id ?? '',
                            ),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.provider.quizTitleModel[index].quizTile ?? '',
                              maxLines: 3,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.quiz_outlined,
                            color: AppColors.blue_246BFD,
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.grey.withOpacity(0.5),
                    );
                  },
                ),
              ),
            ],
          )
        : const Padding(
            padding: EdgeInsets.only(top: 240),
            child: Center(
              child: Text(
                'Không có bài kiểm tra nào',
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
          );
  }
}
