import 'package:flutter/material.dart';
import 'package:kltn/src/page/quiz/quiz_vm.dart';

class ItemAnswerWidget extends StatefulWidget {
  const ItemAnswerWidget({super.key, required this.provider});
  final QuizVM provider;

  @override
  State<ItemAnswerWidget> createState() => _ItemAnswerWidgetState();
}

class _ItemAnswerWidgetState extends State<ItemAnswerWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.provider.listQuizQuestion[widget.provider.currentPage].quizOptions?.length,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final item = widget.provider.listQuizQuestion[widget.provider.currentPage].quizOptions?[index];
              return GestureDetector(
                onTap: widget.provider.listQuizQuestion.first.isCorrect == null
                    ? () {
                        setState(() {
                          widget.provider.addBody(widget.provider.listQuizQuestion[widget.provider.currentPage], index);
                          if (widget.provider.currentPage + 1 != widget.provider.listQuizQuestion.length) {
                            widget.provider.currentPage++;
                            widget.provider.goToPage(widget.provider.currentPage);
                          }
                        });
                      }
                    : () {},
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: widget.provider
                        .colorBackground(widget.provider.listQuizQuestion[widget.provider.currentPage], index),
                    border: Border.all(
                      color: widget.provider
                          .colorBoder(widget.provider.listQuizQuestion[widget.provider.currentPage], index),
                      width: 2,
                    ),
                  ),
                  child: Row(children: [
                    Text(
                      item ?? '',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                    const Spacer(),
                    widget.provider.icon(widget.provider.listQuizQuestion[widget.provider.currentPage], index),
                  ]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
