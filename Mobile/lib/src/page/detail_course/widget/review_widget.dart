import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kltn/src/base/helper/helper.dart';
import 'package:kltn/src/components/paginate.dart';
import 'package:kltn/src/page/detail_course/detail_course_vm.dart';
import 'package:kltn/src/page/detail_course/widget/bottom_review.dart';
import '../../../utils/app_colors.dart';

class ReviewWidget extends StatefulWidget {
  const ReviewWidget({super.key, required this.provider});
  final DetailCourseVM provider;

  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                children: [
                  const TextSpan(
                    text: 'Đánh giá ',
                    style: TextStyle(
                      color: AppColors.h434343,
                    ),
                  ),
                  TextSpan(
                    text: '(${widget.provider.listComment.length})',
                    style: const TextStyle(
                      color: AppColors.blue_246BFD,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            RatingBar.builder(
              initialRating: widget.provider.model.courseRatingsAverage ?? 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              ignoreGestures: true,
              itemSize: 15,
              itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {},
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "${(widget.provider.model.courseRatingsAverage ?? 0)}",
              style: const TextStyle(color: AppColors.h8C8C8C, fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Visibility(
          visible: widget.provider.checkVisibleReview()
              ,
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                  builder: (context) {
                    return SingleChildScrollView(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: BottomReview(provider: widget.provider));
                  });
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.gray99.withOpacity(0.5),
                  )),
              child: Text(
                'Đánh giá ngay....',
                style: TextStyle(fontSize: 12, color: AppColors.gray99.withOpacity(0.5)),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 300,
          child: Paginate(
            onRefresh: () {
              widget.provider.fetchAllReview(isRefresh: true);
            },
            refreshController: widget.provider.reviewRefreshControllrer,
            enablePullDown: true,
            enablePullUp: true,
            onLoading: () {
              widget.provider.fetchAllReview(isRefresh: false);
            },
            child: widget.provider.listComment.isNotEmpty
                ? ListView.separated(
                    itemCount: widget.provider.listComment.length,
                    controller: widget.provider.scrollController,
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
                                      image: widget.provider.listComment[index].userId?.userAvatar?.isNotEmpty == true
                                          ? NetworkImage(widget.provider.listComment[index].userId?.userAvatar ?? '')
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
                                      widget.provider.listComment[index].userId?.userName ?? '',
                                      style: const TextStyle(
                                          color: AppColors.h434343, fontSize: 13, fontWeight: FontWeight.w600),
                                    ),
                                    Row(
                                      children: [
                                        RatingBar.builder(
                                          initialRating: double.parse(
                                              (widget.provider.listComment[index].reviewRating ?? 0).toString()),
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          ignoreGestures: true,
                                          itemSize: 12,
                                          itemBuilder: (context, _) => const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {},
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "${(widget.provider.listComment[index].reviewRating ?? 0)}/5",
                                          style: const TextStyle(
                                              color: AppColors.h8C8C8C, fontSize: 10, fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                const Spacer(),
                                Text(
                                  Helper.formatRelativeDate(widget.provider.listComment[index].createdAt ?? ''),
                                  style: const TextStyle(
                                      color: AppColors.hC4C4C4, fontSize: 12, fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              widget.provider.listComment[index].reviewComment ?? '',
                              style:
                                  const TextStyle(color: AppColors.h8C8C8C, fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                            widget.provider.listComment[index].replyComment == null
                                ? Column(
                                    children: [
                                      Visibility(
                                        visible: widget.provider.listComment[index].replyComment == null &&
                                            (widget.provider.mentorModel.findTeacher?.id ?? '') ==
                                                widget.provider.prefs.userID,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              widget.provider.listCheckReply[index] =
                                                  !(widget.provider.isListDetailVisible(index) ?? false);
                                            });
                                          },
                                          child: const Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              'Phản hồi',
                                              style: TextStyle(
                                                  color: AppColors.h8C8C8C, fontSize: 12, fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: ((widget.provider.isListDetailVisible(index)) ?? false) &&
                                            widget.provider.listComment[index].replyComment == null &&
                                            (widget.provider.mentorModel.findTeacher?.id ?? '') ==
                                                widget.provider.prefs.userID,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: TextField(
                                                controller: widget.provider.replyCommentController,
                                                decoration: InputDecoration(
                                                    hintText: 'Phản hồi ngay',
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
                                                widget.provider.createReply(
                                                    idComment: widget.provider.listComment[index].id ?? '');
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
                                  )
                                : Column(
                                    children: [
                                      Visibility(
                                        visible: widget.provider.listComment[index].replyComment != null,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              widget.provider.listCheckReply[index] =
                                                  !(widget.provider.isListDetailVisible(index) ?? false);
                                            });
                                          },
                                          child: const Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              'Xem phản hồi',
                                              style: TextStyle(
                                                  color: AppColors.h8C8C8C, fontSize: 12, fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: ((widget.provider.isListDetailVisible(index)) ?? false) &&
                                            widget.provider.listComment[index].replyComment != null,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 20, top: 10),
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
                                                        image: widget.provider.listComment[index].replyComment?.userId
                                                                    ?.userAvatar?.isNotEmpty ==
                                                                true
                                                            ? NetworkImage(
                                                                widget.provider.listComment[index].userId?.userAvatar ??
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
                                                    widget.provider.listComment[index].replyComment?.userId?.userName ??
                                                        '',
                                                    style: const TextStyle(
                                                        color: AppColors.h434343,
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w600),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    Helper.formatRelativeDate(
                                                        widget.provider.listComment[index].replyComment?.createdAt ??
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
                                                  widget.provider.listComment[index].replyComment?.replyComment ?? '',
                                                  style: const TextStyle(
                                                      color: AppColors.h8C8C8C,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w400),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
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
                    child: Center(child: Text('Chưa có đánh giá!!!')),
                  ),
          ),
        ),
      ],
    );
  }
}
