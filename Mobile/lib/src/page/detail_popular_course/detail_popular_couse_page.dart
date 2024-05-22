import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kltn/src/base/base_page.dart';
import 'package:kltn/src/components/paginate.dart';
import 'package:kltn/src/page/detail_course/detail_course_page.dart';
import 'package:kltn/src/page/detail_popular_course/detail_popular_couse_vm.dart';
import 'package:kltn/src/utils/app_colors.dart';
import 'package:shimmer/shimmer.dart';

import '../../components/imformation_popup.dart';

class DetailPopularCoursePage extends StatefulWidget {
  const DetailPopularCoursePage({super.key});

  @override
  State<DetailPopularCoursePage> createState() => _DetailPopularCoursePageState();
}

class _DetailPopularCoursePageState extends State<DetailPopularCoursePage> with MixinBasePage<DetailPopularCourseVM> {
  @override
  Widget build(BuildContext context) {
    return builder(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 60,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: AppColors.gray99, width: 0.5),
                  ),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.black,
                        size: 20,
                      )),
                ),
              ],
            ),
          ),
          title: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 7),
            child: const Text(
              'Khóa học phổ biến',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: Paginate(
              onRefresh: () {
                provider.fetchPopularCourse(isRefresh: true);
              },
              refreshController: provider.refreshPopularController,
              enablePullDown: true,
              enablePullUp: true,
              onLoading: () {
                provider.fetchPopularCourse(isRefresh: false);
              },
              child: !provider.isLoadingCourse
                  ? ScrollConfiguration(
                      behavior: const ScrollBehavior().copyWith(overscroll: false),
                      child: provider.listPopularCourse.isNotEmpty
                          ? ListView.builder(
                              itemCount: provider.listPopularCourse.length,
                              shrinkWrap: true,
                              // controller: widget.provider.ongoingControler,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    // widget.provider.ongoingControler = ScrollController();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailCoursePage(
                                            id: provider.listPopularCourse[index].id ?? "",
                                          ),
                                        ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(color: AppColors.h8C8C8C.withOpacity(0.4), width: 0.5),
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            right: 0,
                                            top: 0,
                                            child: IconButton(
                                              onPressed: () {
                                                if (provider.listPopularCourse[index].isInCart == false) {
                                                  setState(() {
                                                    provider.addCart(provider.listPopularCourse[index].id ?? '');
                                                    provider.listPopularCourse[index].isInCart = true;
                                                  });
                                                } else {
                                                  ImformationPopup.show(
                                                      context, "Khóa học đã được thêm vào danh sách yêu thích");
                                                }
                                              },
                                              icon: Icon(
                                                Icons.bookmark,
                                                color: provider.listPopularCourse[index].isInCart ?? false
                                                    ? AppColors.blue_246BFD
                                                    : Colors.grey,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            provider.listPopularCourse[index].courseThumnail ?? ''),
                                                        fit: BoxFit.cover)),
                                              ),
                                              const SizedBox(
                                                width: 7,
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 200,
                                                    child: Text(
                                                      provider.listPopularCourse[index].courseName ?? '',
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black.withOpacity(0.7),
                                                          fontWeight: FontWeight.w500),
                                                    ),
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
                                                      Text(
                                                        provider.listPopularCourse[index].userTeacher?.userName ?? '',
                                                        style: const TextStyle(
                                                            color: AppColors.h8C8C8C,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w400),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "${NumberFormat.decimalPattern().format(provider.listPopularCourse[index].coursePrice ?? 0)}VND",
                                                        style: const TextStyle(
                                                            color: AppColors.blue_246BFD,
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w500),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
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
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : const Center(
                              child: Text(
                              'Không có dữ liệu',
                              style: TextStyle(color: Colors.black, fontSize: 14),
                            )),
                    )
                  : ListView.builder(
                      itemCount: 10,
                      shrinkWrap: true,
                      // controller: provider.scrollController,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: AppColors.h8C8C8C.withOpacity(0.4), width: 0.5),
                            ),
                            child: Row(
                              children: [
                                Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration:
                                        BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                                  ),
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: Container(
                                        width: 30,
                                        height: 10,
                                        padding: const EdgeInsets.all(4),
                                        decoration:
                                            BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: Container(
                                        width: 70,
                                        height: 10,
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20),
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
                                        width: 100,
                                        height: 10,
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade100,
                                          child: Container(
                                            width: 150,
                                            height: 10,
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade100,
                                          child: Container(
                                            width: 30,
                                            height: 10,
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            )),
      ),
    );
  }

  @override
  DetailPopularCourseVM create() {
    return DetailPopularCourseVM();
  }

  @override
  void initialise(BuildContext context) {}
}
