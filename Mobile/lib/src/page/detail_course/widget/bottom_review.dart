import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kltn/src/page/detail_course/detail_course_vm.dart';
import 'package:kltn/src/utils/app_colors.dart';

class BottomReview extends StatefulWidget {
  const BottomReview({super.key, required this.provider});
  final DetailCourseVM provider;

  @override
  State<BottomReview> createState() => _BottomReviewState();
}

class _BottomReviewState extends State<BottomReview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        color: Colors.white,
      ),
      child: Column(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.amber.withOpacity(0.2)),
                child: const Text('Khóa học bán chạy',
                    style: TextStyle(fontSize: 12, color: Colors.amber, fontWeight: FontWeight.w500)),
              ),
              const Spacer(),
              const Icon(
                Icons.star,
                color: Colors.amber,
                size: 17,
              ),
              const SizedBox(
                width: 2,
              ),
              Text(
                '${widget.provider.model.courseRatingsAverage}/10 đánh giá',
                style: const TextStyle(color: AppColors.h9497AD, fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.provider.model.courseName ?? '',
              style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              SizedBox(
                width: (MediaQuery.of(context).size.width - 30) / 3,
                child: Column(
                  children: [
                    const Icon(
                      Icons.person_rounded,
                      size: 20,
                      color: AppColors.h8C8C8C,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      widget.provider.model.courseName ?? '',
                      style: const TextStyle(
                          color: AppColors.h9497AD,
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              // const Spacer(),
              SizedBox(
                width: (MediaQuery.of(context).size.width - 30) / 3,
                child: Column(
                  children: [
                    const Icon(
                      Icons.play_circle,
                      size: 20,
                      color: AppColors.h8C8C8C,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      '${widget.provider.listData.length} Bài giảng',
                      style: const TextStyle(color: AppColors.h9497AD, fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              // const Spacer(),
              SizedBox(
                width: (MediaQuery.of(context).size.width - 30) / 3,
                child: Column(
                  children: [
                    const Icon(
                      Icons.query_builder,
                      size: 20,
                      color: AppColors.h8C8C8C,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      widget.provider.convertSecondsToMinute(widget.provider.model.totalLength ?? 0),
                      style: const TextStyle(color: AppColors.h9497AD, fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const Divider(
            color: AppColors.h9497AD,
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            ' Đánh giá khóa học này ngay',
            style: TextStyle(color: AppColors.h9497AD.withOpacity(0.9), fontSize: 14, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 15,
          ),
          RatingBar.builder(
            initialRating: widget.provider.numberStar,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 6.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              widget.provider.numberStar = rating;
            },
          ),
          const SizedBox(
            height: 25,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Chi tiết đánh giá',
              style: TextStyle(color: AppColors.h666666, fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextField(
            controller: widget.provider.reivewController,
            maxLines: 5,
            decoration: InputDecoration(
                hintText: 'Đánh giá ngay',
                hintStyle: const TextStyle(color: AppColors.hADACB4, fontSize: 14, fontWeight: FontWeight.w400),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.hF4F4F4.withOpacity(0.8),
                    ),
                    borderRadius: BorderRadius.circular(10))),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.pop(context);
              widget.provider.createReview(widget.provider.model.id ?? '');
            },
            child: Container(
              // height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppColors.blue_246BFD,
              ),
              child: const Align(
                  alignment: Alignment.center,
                  child: Text('Đánh giá',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400))),
            ),
          ),
        ]),
      ]),
    );
  }
}
