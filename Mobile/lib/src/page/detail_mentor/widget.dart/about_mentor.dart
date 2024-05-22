import 'package:flutter/material.dart';
import 'package:kltn/src/page/detail_mentor/detail_mentor_vm.dart';

import '../../../utils/app_colors.dart';
import 'loading_mentor.dart';

class AboutMentorWidget extends StatefulWidget {
  const AboutMentorWidget({super.key, required this.provider});

  final DetailMentorVM provider;
  @override
  State<AboutMentorWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AboutMentorWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: !widget.provider.checkLoading
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Mô tả',
                  style: TextStyle(color: AppColors.h434343, fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.provider.mentorModel.findTeacher?.userAbout ?? '',
                  style: const TextStyle(fontSize: 12, color: AppColors.h9497AD, fontWeight: FontWeight.w400),
                  maxLines: widget.provider.checkReadMore ? null : 3,
                ),
                widget.provider.checkReadMore == false
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.provider.checkReadMore = true;
                          });
                        },
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              'Xem thêm',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.blue_246BFD,
                                fontWeight: FontWeight.w500,
                                // decoration: TextDecoration.underline,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.provider.checkReadMore = false;
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Center(
                            child: Text(
                              'Thu gọn',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.blue_246BFD,
                                fontWeight: FontWeight.w500,
                                // decoration: TextDecoration.underline,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 1,
                ),
                const Text(
                  'Thông tin',
                  style: TextStyle(color: AppColors.h434343, fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  children: [
                    infor('Số học sinh', (widget.provider.mentorModel.totalStudent ?? 0).toString()),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width) / 4,
                    ),
                    infor('Khóa học', widget.provider.mentorModel.numberCourse.toString()),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Kinh nghiệm',
                  style: TextStyle(color: AppColors.h434343, fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                widget.provider.mentorModel.findTeacher!.userExperience!.isNotEmpty
                    ? ListView.separated(
                        controller: widget.provider.scrollController,
                        itemCount: widget.provider.mentorModel.findTeacher!.userExperience!.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        border: Border.all(color: AppColors.gray99, width: 0.5),
                                      ),
                                      child: ClipOval(
                                          child: Image.network(
                                        'https://th.bing.com/th/id/OIP._wQ5Yn7Oy_1MzUVTUTa-hgHaEK?rs=1&pid=ImgDetMain',
                                        fit: BoxFit.cover,
                                      )),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.provider.mentorModel.findTeacher!.userExperience?[index].company ?? '',
                                          style: const TextStyle(
                                              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          widget.provider.mentorModel.findTeacher!.userExperience?[index].title ?? '',
                                          style: const TextStyle(
                                              color: AppColors.h9497AD, fontSize: 13, fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  widget.provider.mentorModel.findTeacher!.userExperience?[index].description ?? '',
                                  style: const TextStyle(
                                      color: AppColors.h9497AD, fontSize: 14, fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            color: AppColors.h9497AD.withOpacity(0.5),
                            height: 0,
                          );
                        },
                      )
                    : const Padding(
                        padding: EdgeInsets.only(top: 150),
                        child: Center(
                          child: Text(
                            'Không có thông tin',
                            style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
              ],
            )
          : aboutLoading(widget.provider.scrollController, context),
    );
  }
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
