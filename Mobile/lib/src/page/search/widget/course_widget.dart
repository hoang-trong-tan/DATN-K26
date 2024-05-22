import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kltn/src/remote/service/respone/cart/cart_response.dart';
import '../../../utils/app_colors.dart';
import '../../book_mark/widget/bottom_remove.dart';
import '../../detail_course/detail_course_page.dart';
import '../search_vm.dart';

class CourseWidget extends StatefulWidget {
  const CourseWidget({super.key, required this.provider});
  final SearchVM provider;

  @override
  State<CourseWidget> createState() => _CourseWidgetState();
}

class _CourseWidgetState extends State<CourseWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.provider.listSearch.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: ListView.builder(
                itemCount: widget.provider.listSearch.length,
                shrinkWrap: true,
                // controller: provider.scrollController,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailCoursePage(
                            id: widget.provider.listSearch[index].id ?? '',
                          ),
                        ),
                      );
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
                                      showModalBottomSheet(
                                        context: context,
                                        backgroundColor: Colors.transparent,
                                        builder: (context) {
                                          return RemoveWidget(
                                            model: CartResponse(),
                                          );
                                        },
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.bookmark,
                                      color: AppColors.blue_246BFD,
                                    ))),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                          image: NetworkImage(widget.provider.listSearch[index].courseThumnail ?? ''),
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
                                        widget.provider.listSearch[index].courseName ?? '',
                                        style: TextStyle(
                                            fontSize: 14,
                                            overflow: TextOverflow.ellipsis,
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
                                          widget.provider.listSearch[index].userTeacher?.userName ?? '',
                                          style: const TextStyle(
                                              color: AppColors.h8C8C8C, fontSize: 12, fontWeight: FontWeight.w400),
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
                                          '${NumberFormat.decimalPattern().format(widget.provider.listSearch[index].coursePrice ?? 0)} VND',
                                          style: const TextStyle(
                                              color: AppColors.blue_246BFD, fontSize: 16, fontWeight: FontWeight.w500),
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
                                                  fontSize: 12, color: Colors.amber, fontWeight: FontWeight.w400)),
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
              ),
            ),
          )
        : const Center(
            child: Text(
            'Không có dữ liệu',
            style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
          ));
  }
}
