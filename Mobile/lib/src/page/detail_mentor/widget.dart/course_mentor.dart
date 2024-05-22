import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kltn/src/components/paginate.dart';
import 'package:kltn/src/page/detail_mentor/detail_mentor_vm.dart';

import '../../../utils/app_colors.dart';
import '../../detail_course/detail_course_page.dart';

class CourseMentorWidget extends StatefulWidget {
  const CourseMentorWidget({super.key, required this.provider});
  final DetailMentorVM provider;

  @override
  State<CourseMentorWidget> createState() => _CourseMentorWidgetState();
}

class _CourseMentorWidgetState extends State<CourseMentorWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: 'Khóa học',
                  style: TextStyle(color: AppColors.h434343, fontSize: 16, fontWeight: FontWeight.w500),
                ),
                TextSpan(
                  text: ' ${widget.provider.mentorModel.numberCourse ?? 0}',
                  style: const TextStyle(color: AppColors.blue_246BFD, fontSize: 16, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 700,
          child: Paginate(
            onRefresh: () {
              widget.provider.fetchCourseMentor(isRefresh: true);
            },
            refreshController: widget.provider.reviewRefreshControllrer,
            enablePullDown: true,
            enablePullUp: true,
            onLoading: () {
              widget.provider.fetchCourseMentor(isRefresh: false);
            },
            child: widget.provider.listCourse.isNotEmpty
                ? ListView.builder(
                    itemCount: widget.provider.listCourse.length,
                    shrinkWrap: true,
                    controller: widget.provider.scrollController,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Navigator.pop(context);
                          // Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailCoursePage(
                                  id: widget.provider.listCourse[index].id ?? '',
                                ),
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: AppColors.h8C8C8C.withOpacity(0.4), width: 0.5),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                          image: NetworkImage(widget.provider.listCourse[index].courseThumnail ?? ''),
                                          fit: BoxFit.cover)),
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.provider.listCourse[index].courseName ?? '',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black.withOpacity(0.7),
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.person,
                                            color: AppColors.h8C8C8C,
                                            size: 18,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            widget.provider.listCourse[index].userTeacher?.userName ?? '',
                                            style: const TextStyle(
                                                color: AppColors.h8C8C8C, fontSize: 12, fontWeight: FontWeight.w400),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${NumberFormat.decimalPattern().format(widget.provider.listCourse[index].coursePrice)} VND',
                                            style: const TextStyle(
                                                color: AppColors.blue_246BFD,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          // const SizedBox(
                                          //   width: 5,
                                          // ),
                                          // Container(
                                          //   // width: 50,
                                          //   padding: const EdgeInsets.all(4),
                                          //   decoration: BoxDecoration(
                                          //       borderRadius: BorderRadius.circular(20),
                                          //       color: Colors.amber.withOpacity(0.2)),
                                          //   child: const Text('Bán chạy',
                                          //       style: TextStyle(
                                          //           fontSize: 12, color: Colors.amber, fontWeight: FontWeight.w400)),
                                          // ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text(
                      'Không có khóa học nào',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
