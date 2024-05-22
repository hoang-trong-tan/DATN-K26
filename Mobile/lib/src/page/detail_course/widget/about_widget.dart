import 'package:flutter/material.dart';
import 'package:kltn/src/page/detail_course/detail_course_vm.dart';
import 'package:kltn/src/utils/app_colors.dart';
import 'package:shimmer/shimmer.dart';

import '../../detail_mentor/detail_mentor_page.dart';

class AboutWidget extends StatefulWidget {
  const AboutWidget({super.key, required this.provider});
  final DetailCourseVM provider;

  @override
  State<AboutWidget> createState() => _AboutWidgetState();
}

class _AboutWidgetState extends State<AboutWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: !widget.provider.isLoading
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Giới thiệu khóa học',
                  style: TextStyle(color: AppColors.h434343, fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.provider.model.courseDescription ?? 'Không có giới thiệu',
                  style: const TextStyle(fontSize: 12, color: AppColors.h9497AD, fontWeight: FontWeight.w400),
                  maxLines: widget.provider.checkReadMore ? null : 3,
                  // overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 5,
                ),
                widget.provider.checkReadMore == false
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.provider.checkReadMore = true;
                          });
                        },
                        child: const Center(
                          child: Text(
                            'Xem Thêm',
                            style: TextStyle(fontSize: 13, color: AppColors.blue_246BFD, fontWeight: FontWeight.w500),
                            maxLines: 3,
                            // overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.provider.checkReadMore = false;
                          });
                        },
                        child: const Center(
                          child: Text(
                            'Thu gọn',
                            style: TextStyle(fontSize: 13, color: AppColors.blue_246BFD, fontWeight: FontWeight.w500),
                            maxLines: 3,
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Giảng viên',
                  style: TextStyle(color: AppColors.h434343, fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailMentorPage(
                          idMentor: widget.provider.model.userTeacher?.id ?? '',
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(70),
                          image: DecorationImage(
                              image: (widget.provider.mentorModel.findTeacher?.userAvatar ?? '').isNotEmpty
                                  ? NetworkImage(widget.provider.mentorModel.findTeacher?.userAvatar ?? '')
                                  : const AssetImage('assets/image/logo.png') as ImageProvider<Object>,
                              fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 250,
                            child: Text(
                              widget.provider.mentorModel.findTeacher?.userName ?? '',
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: AppColors.h333333,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            widget.provider.mentorModel.findTeacher?.courseType != null
                                ? widget.provider.mentorModel.findTeacher?.courseType['type_name'] ?? ''
                                : '',
                            style: const TextStyle(fontSize: 10, color: AppColors.h9497AD, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      // const Spacer(),
                      // Container(
                      //   height: 40,
                      //   width: 40,
                      //   padding: const EdgeInsets.all(5),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(40),
                      //     color: AppColors.h9497AD.withOpacity(0.2),
                      //   ),
                      //   child: const Icon(
                      //     Icons.chat,
                      //     color: AppColors.blue_246BFD,
                      //   ),
                      // )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Thông tin',
                  style: TextStyle(color: AppColors.h434343, fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    infor('Số học sinh', (widget.provider.mentorModel.totalStudent).toString()),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width) / 4,
                    ),
                    infor('Ngôn ngữ', 'Tiếng việt'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    infor('Ngày cập nhật', '26/01/2024'),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width) / 5,
                    ),
                    infor('Phụ đề', 'Tiếng việt'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    infor('Cấp độ', 'Trung bình'),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width) / 4,
                    ),
                    infor('Phù hợp', 'Điện thoại, Máy tính'),
                  ],
                ),
              ],
            )
          : Column(
              children: [
                aboutLoading(context),
                Row(
                  children: [
                    inforLoading(),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width) / 4,
                    ),
                    inforLoading(),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    inforLoading(),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width) / 4,
                    ),
                    inforLoading(),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    inforLoading(),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width) / 4,
                    ),
                    inforLoading(),
                  ],
                ),
              ],
            ),
    );
  }

  Widget infor(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: AppColors.h9497AD, fontSize: 13, fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          content,
          style: const TextStyle(color: AppColors.h434343, fontSize: 13, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget inforLoading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: 50,
            height: 10,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: 50,
            height: 10,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
          ),
        ),
      ],
    );
  }
}

Widget aboutLoading(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          width: 10,
          height: 10,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          width: 50,
          height: 10,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
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
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(70),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: 250,
                  height: 20,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: 50,
                  height: 10,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
                ),
              ),
            ],
          ),
          const Spacer(),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 40,
              width: 40,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: AppColors.h9497AD.withOpacity(0.2),
              ),
              child: const Icon(
                Icons.chat,
                color: AppColors.blue_246BFD,
              ),
            ),
          )
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          width: 50,
          height: 10,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
    ],
  );
}
