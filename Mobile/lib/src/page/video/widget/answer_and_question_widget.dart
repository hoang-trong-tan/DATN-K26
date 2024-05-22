import 'package:flutter/material.dart';
import 'package:kltn/src/base/helper/helper.dart';
import 'package:kltn/src/page/video/video_vm.dart';
import 'package:kltn/src/utils/app_colors.dart';

import '../../../components/paginate.dart';

class AnswerAndQuestionWidget extends StatefulWidget {
  const AnswerAndQuestionWidget({super.key, required this.provider});
  final VideoVM provider;

  @override
  State<AnswerAndQuestionWidget> createState() => _AnswerAndQuestionWidgetState();
}

class _AnswerAndQuestionWidgetState extends State<AnswerAndQuestionWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 50,
                child: TextField(
                  controller: widget.provider.questionController,
                  decoration: InputDecoration(
                    hintText: 'Bạn đang thắc mắc gì?',
                    hintStyle: const TextStyle(color: AppColors.hADACB4, fontSize: 14, fontWeight: FontWeight.w400),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.hF4F4F4.withOpacity(0.8),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () {
                widget.provider.createQuestion();
              },
              child: const Icon(
                Icons.send_sharp,
                color: AppColors.blue_246BFD,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 450,
          child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: Paginate(
              onRefresh: () {
                widget.provider.fetchAllQuestionAndAnwser(isRefresh: true);
              },
              refreshController: widget.provider.refreshController,
              enablePullDown: true,
              enablePullUp: true,
              onLoading: () {
                widget.provider.fetchAllQuestionAndAnwser(isRefresh: false);
              },
              child: widget.provider.listAnswerAndQuestion.isNotEmpty
                  ? ListView.separated(
                      itemCount: widget.provider.listAnswerAndQuestion.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      image: DecorationImage(
                                        image: widget.provider.listAnswerAndQuestion[index].userId?.userAvatar
                                                    ?.isNotEmpty ==
                                                true
                                            ? NetworkImage(
                                                widget.provider.listAnswerAndQuestion[index].userId?.userAvatar ?? '')
                                            : const AssetImage('assets/image/logo.png') as ImageProvider<Object>,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.provider.listAnswerAndQuestion[index].userId?.userName ?? '',
                                        style: const TextStyle(
                                            color: AppColors.h434343, fontSize: 13, fontWeight: FontWeight.w600),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          widget.provider.playFromSeconds(
                                              widget.provider.listAnswerAndQuestion[index].videoTime ?? 0);
                                        },
                                        child: Text(
                                          Helper.convertSecondsToMinute(
                                              widget.provider.listAnswerAndQuestion[index].videoTime ?? 0),
                                          style: const TextStyle(
                                              color: AppColors.blue_246BFD, fontSize: 13, fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Text(
                                    Helper.formatRelativeDate(
                                        widget.provider.listAnswerAndQuestion[index].createdAt ?? ''),
                                    style: const TextStyle(
                                        color: AppColors.hC4C4C4, fontSize: 12, fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                widget.provider.listAnswerAndQuestion[index].questionComment ?? '',
                                style: const TextStyle(
                                    color: AppColors.h8C8C8C, fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                              Column(
                                children: [
                                  Visibility(
                                    visible: widget.provider.listAnswerAndQuestion[index].answserComment!.isEmpty,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          widget.provider.listCheckReply[index] =
                                              !(widget.provider.isListDetailVisible(index) ?? false);
                                        });
                                      },
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          (widget.provider.listCheckReply[index] ?? true) ? 'Trả lời' : 'Ẩn',
                                          style: const TextStyle(
                                              color: AppColors.h8C8C8C, fontSize: 12, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Visibility(
                                    visible: ((widget.provider.isListDetailVisible(index)) ?? false) &&
                                        widget.provider.listAnswerAndQuestion[index].answserComment!.isEmpty,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: widget.provider.answerController,
                                            decoration: InputDecoration(
                                                hintText: 'Trả lời ngay',
                                                hintStyle: const TextStyle(
                                                    color: AppColors.hADACB4,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400),
                                                contentPadding: const EdgeInsets.all(5),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: AppColors.hF4F4F4.withOpacity(0.8),
                                                    ),
                                                    borderRadius: BorderRadius.circular(10))),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            widget.provider.createAnwser(
                                                idQuestion: widget.provider.listAnswerAndQuestion[index].id ?? '');
                                          },
                                          child: const Icon(
                                            Icons.send_sharp,
                                            color: AppColors.blue_246BFD,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Visibility(
                                    visible: widget.provider.listAnswerAndQuestion[index].answserComment!.isNotEmpty,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          widget.provider.listCheckReply[index] =
                                              !(widget.provider.isListDetailVisible(index) ?? false);
                                        });
                                      },
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          (widget.provider.listCheckReply[index] ?? true)
                                              ? 'Xem câu trả lời'
                                              : 'Ẩn câu trả lời',
                                          style: const TextStyle(
                                              color: AppColors.h8C8C8C, fontSize: 12, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: ((widget.provider.isListDetailVisible(index)) ?? false) &&
                                        widget.provider.listAnswerAndQuestion[index].answserComment!.isNotEmpty,
                                    child: Padding(
                                        padding: const EdgeInsets.only(left: 20, top: 10),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Expanded(
                                                  child: TextField(
                                                    controller: widget.provider.answerController,
                                                    decoration: InputDecoration(
                                                        hintText: 'Trả lời ngay ngay',
                                                        hintStyle: const TextStyle(
                                                            color: AppColors.hADACB4,
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w400),
                                                        contentPadding: const EdgeInsets.all(5),
                                                        border: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: AppColors.hF4F4F4.withOpacity(0.8),
                                                            ),
                                                            borderRadius: BorderRadius.circular(10))),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    widget.provider.createAnwser(
                                                        idQuestion:
                                                            widget.provider.listAnswerAndQuestion[index].id ?? '');
                                                  },
                                                  child: const Icon(
                                                    Icons.send_sharp,
                                                    color: AppColors.blue_246BFD,
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            ListView.builder(
                                              itemCount:
                                                  widget.provider.listAnswerAndQuestion[index].answserComment?.length,
                                              shrinkWrap: true,
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index2) {
                                                return Container(
                                                  margin: const EdgeInsets.only(bottom: 10),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            height: 25,
                                                            width: 25,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(30),
                                                              image: DecorationImage(
                                                                image: widget
                                                                            .provider
                                                                            .listAnswerAndQuestion[index]
                                                                            .answserComment?[index2]
                                                                            .userId
                                                                            ?.userAvatar
                                                                            ?.isNotEmpty ==
                                                                        true
                                                                    ? NetworkImage(widget
                                                                            .provider
                                                                            .listAnswerAndQuestion[index]
                                                                            .answserComment?[index2]
                                                                            .userId
                                                                            ?.userAvatar ??
                                                                        '')
                                                                    : const AssetImage('assets/image/logo.png')
                                                                        as ImageProvider<Object>,
                                                                fit: BoxFit.contain,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            widget.provider.listAnswerAndQuestion[index]
                                                                    .answserComment?[index2].userId?.userName ??
                                                                '',
                                                            style: const TextStyle(
                                                                color: AppColors.h434343,
                                                                fontSize: 13,
                                                                fontWeight: FontWeight.w600),
                                                          ),
                                                          const Spacer(),
                                                          Text(
                                                            Helper.formatRelativeDate(widget
                                                                    .provider
                                                                    .listAnswerAndQuestion[index]
                                                                    .answserComment?[index2]
                                                                    .createdAt ??
                                                                ''),
                                                            style: const TextStyle(
                                                                color: AppColors.hC4C4C4,
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.w400),
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 10, left: 5),
                                                        child: Text(
                                                          widget.provider.listAnswerAndQuestion[index]
                                                                  .answserComment?[index2].answserComment ??
                                                              '',
                                                          style: const TextStyle(
                                                              color: AppColors.h8C8C8C,
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.w400),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(
                        color: AppColors.h9497AD,
                        height: 0,
                      ),
                    )
                  : const Padding(
                      padding: EdgeInsets.only(top: 70),
                      child: Center(child: Text('Không có câu hỏi nào')),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
