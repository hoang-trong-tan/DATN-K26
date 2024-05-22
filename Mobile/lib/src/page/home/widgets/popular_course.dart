import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kltn/src/components/paginate.dart';
import 'package:kltn/src/page/detail_course/detail_course_page.dart';
import 'package:kltn/src/page/detail_popular_course/detail_popular_couse_page.dart';
import 'package:kltn/src/page/home/home_vm.dart';
import 'package:kltn/src/utils/app_colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

import '../../../components/imformation_popup.dart';
import '../../main/widget/dialog_login.dart';

class PopularCourseWidget extends StatefulWidget {
  const PopularCourseWidget({super.key, required this.provider});
  final HomeVM provider;

  @override
  State<PopularCourseWidget> createState() => _PopularCourseWidgetState();
}

class _PopularCourseWidgetState extends State<PopularCourseWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              const Text(
                'Khóa học phổ biến',
                style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              !widget.provider.isLoadingCourse
                  ? GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DetailPopularCoursePage(),
                            ));
                      },
                      child: const Text(
                        'Xem tất cả',
                        style: TextStyle(fontSize: 12, color: Colors.amber, fontWeight: FontWeight.w400),
                      ))
                  : Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        height: 10,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
        SizedBox(
          height: 220,
          child: Paginate(
            onRefresh: () {
              widget.provider.fetchPopularCourse(isRefresh: true);
            },
            refreshController: widget.provider.refreshPopularController,
            enablePullDown: true,
            enablePullUp: widget.provider.isEnablePullUpPopular,
            scrollDirection: Axis.horizontal,
            header: const ClassicHeader(
              idleText: '',
              releaseText: '',
              completeText: '',
              refreshingText: '',
              failedText: '',
              canTwoLevelText: '',
            ),
            footer: const ClassicFooter(
              loadingText: '.',
              canLoadingText: '',
              failedText: '',
              idleText: '',
              idleIcon: SizedBox(),
              noDataText: '',
            ),
            onLoading: () {
              widget.provider.fetchPopularCourse(isRefresh: false);
            },
            child: !widget.provider.isLoadingCourse
                ? widget.provider.listPopularCourse.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: SizedBox(
                          height: 220,
                          child: ScrollConfiguration(
                            behavior: const ScrollBehavior().copyWith(overscroll: false),
                            child: ListView.builder(
                              itemCount: widget.provider.listPopularCourse.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailCoursePage(
                                          id: widget.provider.listPopularCourse[index].id ?? '',
                                        ),
                                      )),
                                  child: Container(
                                    width: 200,
                                    padding: const EdgeInsets.only(top: 20, right: 15),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              width: 160,
                                              height: 110,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          widget.provider.listPopularCourse[index].courseThumnail ??
                                                              ''),
                                                      fit: BoxFit.cover)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                padding: const EdgeInsets.only(top: 2, bottom: 2, left: 3, right: 5),
                                                decoration: BoxDecoration(
                                                    color: Colors.white, borderRadius: BorderRadius.circular(5)),
                                                child: Row(mainAxisSize: MainAxisSize.min, children: [
                                                  const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                    size: 18,
                                                  ),
                                                  const SizedBox(
                                                    width: 2,
                                                  ),
                                                  Text(
                                                    (widget.provider.listPopularCourse[index].courseRatingsAverage ?? 0)
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
                                                  )
                                                ]),
                                              ),
                                            ),
                                            Positioned(
                                              top: 8,
                                              right: 8,
                                              child: GestureDetector(
                                                onTap: widget.provider.isLogIn
                                                    ? () {
                                                        if (widget.provider.listPopularCourse[index].isInCart ==
                                                            false) {
                                                          setState(() {
                                                            widget.provider.addCart(
                                                                widget.provider.listPopularCourse[index].id ?? '');
                                                            widget.provider.listPopularCourse[index].isInCart = true;
                                                          });
                                                        } else {
                                                          ImformationPopup.show(
                                                              context, "Khóa học đã được thêm vào giỏ hàng");
                                                        }
                                                      }
                                                    : () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (ctx) => DialogLogin(
                                                            login: {
                                                              'id_course':
                                                                  widget.provider.listPopularCourse[index].id ?? '',
                                                              'cart': true,
                                                              'home': true
                                                            },
                                                          ),
                                                        );
                                                      },
                                                child: Container(
                                                  padding: const EdgeInsets.all(3),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                  child: Icon(
                                                    Icons.bookmark,
                                                    color: widget.provider.listPopularCourse[index].isInCart ?? false
                                                        ? AppColors.blue_246BFD
                                                        : Colors.grey,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          widget.provider.listPopularCourse[index].courseName ?? '',
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
                                              width: 5,
                                            ),
                                            Expanded(
                                              child: Text(
                                                widget.provider.listPopularCourse[index].userTeacher?.userName ?? '',
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: AppColors.h8C8C8C,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '${NumberFormat.decimalPattern().format(widget.provider.listPopularCourse[index].coursePrice ?? 0)} VND',
                                                style: const TextStyle(
                                                    color: AppColors.blue_246BFD,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    overflow: TextOverflow.ellipsis),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Visibility(
                                              visible: index <= 10,
                                              child: Container(
                                                // width: 50,
                                                padding: const EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20),
                                                    color: Colors.amber.withOpacity(0.2)),
                                                child: const Text('Bán chạy',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.amber,
                                                        fontWeight: FontWeight.w400)),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      )
                    : const Center(
                        child: Text(
                          'Không có dữ liệu',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      )
                : Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: SizedBox(
                      height: 220,
                      child: ScrollConfiguration(
                        behavior: const ScrollBehavior().copyWith(overscroll: false),
                        child: ListView.builder(
                          itemCount: 10,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 20, right: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          width: 160,
                                          height: 110,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade100,
                                          child: Container(
                                            padding: const EdgeInsets.only(top: 2, bottom: 2, left: 3, right: 5),
                                            decoration: BoxDecoration(
                                                color: Colors.white, borderRadius: BorderRadius.circular(5)),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade100,
                                          child: Container(
                                            padding: const EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    child: Container(
                                      height: 10,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    child: Container(
                                      height: 10,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          width: 80,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          width: 50,
                                          height: 10,
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20), color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
          ),
        )
      ],
    );
  }
}
