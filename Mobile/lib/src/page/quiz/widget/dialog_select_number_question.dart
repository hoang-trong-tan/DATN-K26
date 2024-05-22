import 'package:flutter/material.dart';
import 'package:kltn/src/page/quiz/quiz_vm.dart';

import '../../../utils/app_colors.dart';

class DialogSelectNumberQuestion extends StatefulWidget {
  const DialogSelectNumberQuestion({super.key, required this.provider});
  final QuizVM provider;

  @override
  State<DialogSelectNumberQuestion> createState() => _DialogSelectNumberQuestionState();
}

class _DialogSelectNumberQuestionState extends State<DialogSelectNumberQuestion> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        const Center(
          child: Text(
            'Chọn câu hỏi',
            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        widget.provider.listQuizQuestion.isNotEmpty
            ? Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(
                  widget.provider.listQuizQuestion.length,
                  (i) => GestureDetector(
                    onTap: () {
                      widget.provider.goToPage(i);
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: widget.provider.currentPage == i ? AppColors.blue_246BFD : Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.blue_246BFD.withOpacity(0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 4),
                              spreadRadius: 0,
                            ),
                          ]),
                      child: Center(
                        child: Text(
                          (i + 1).toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: widget.provider.currentPage == i ? Colors.white : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : const Center(
                child: Text(
                  'Chưa có câu hỏi',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
