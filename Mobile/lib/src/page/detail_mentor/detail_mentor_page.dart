import 'package:flutter/material.dart';
import 'package:kltn/src/base/base_page.dart';
import 'package:kltn/src/page/detail_course/widget/persisten_header.dart';
import 'package:kltn/src/page/detail_mentor/detail_mentor_vm.dart';
import 'package:kltn/src/page/detail_mentor/widget.dart/about_mentor.dart';
import 'package:kltn/src/page/detail_mentor/widget.dart/course_mentor.dart';
import 'package:kltn/src/page/detail_mentor/widget.dart/loading_mentor.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/app_colors.dart';

class DetailMentorPage extends StatefulWidget {
  const DetailMentorPage({super.key, required this.idMentor});
  final String idMentor;

  @override
  State<DetailMentorPage> createState() => _DetailMentorPageState();
}

class _DetailMentorPageState extends State<DetailMentorPage> with MixinBasePage<DetailMentorVM> {
  @override
  Widget build(BuildContext context) {
    return builder(
      () => DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
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
                        border: Border.all(color: AppColors.gray99, width: 0.5)),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            title: const Text(
              'Chi tiết giảng viên',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            centerTitle: true,
          ),
          body: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: CustomScrollView(controller: provider.scrollController, slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: PersistentHeader(
                  height: 155,
                  widget: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          !provider.checkLoading
                              ? Row(
                                  children: [
                                    Container(
                                      height: 65,
                                      width: 65,
                                      margin: const EdgeInsets.only(top: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(70),
                                        image: DecorationImage(
                                            image: (provider.mentorModel.findTeacher?.userAvatar ?? '').isNotEmpty
                                                ? NetworkImage(provider.mentorModel.findTeacher?.userAvatar ?? '')
                                                : const AssetImage('assets/image/logo.png') as ImageProvider<Object>,
                                            fit: BoxFit.contain),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          provider.mentorModel.findTeacher?.userName ?? '',
                                          style: const TextStyle(
                                              fontSize: 16, color: AppColors.h333333, fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          provider.mentorModel.findTeacher?.courseType != null
                                              ? provider.mentorModel.findTeacher?.courseType["type_name"] ?? ''
                                              : '',
                                          style: const TextStyle(
                                              fontSize: 12, color: AppColors.h9497AD, fontWeight: FontWeight.w400),
                                        ),
                                        // const SizedBox(
                                        //   height: 4,
                                        // ),
                                        // Row(
                                        //   children: [
                                        //     const Icon(
                                        //       Icons.star,
                                        //       color: Colors.amber,
                                        //       size: 16,
                                        //     ),
                                        //     RichText(
                                        //       text: const TextSpan(
                                        //           style: TextStyle(
                                        //               fontSize: 12,
                                        //               color: AppColors.h9497AD,
                                        //               fontWeight: FontWeight.w400),
                                        //           children: [TextSpan(text: '4.9'), TextSpan(text: ' (360 đánh giá)')]),
                                        //     ),
                                        //   ],
                                        // )
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
                                    //     Icons.phone,
                                    //     color: AppColors.blue_246BFD,
                                    //   ),
                                    // ),
                                    // const SizedBox(
                                    //   width: 8,
                                    // ),
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
                                    // ),
                                  ],
                                )
                              : loadingInfor(),
                          const SizedBox(
                            height: 20,
                          ),
                          !provider.checkLoading
                              ? Column(
                                  children: [
                                    Divider(
                                      color: AppColors.h9497AD.withOpacity(0.5),
                                      height: 0,
                                    ),
                                    // const SizedBox(
                                    //   height: 5,
                                    // ),
                                    TabBar(
                                      onTap: (value) {
                                        setState(() {
                                          provider.index = value;
                                        });
                                      },
                                      // indicatorColor: AppColors.blue_246BFD,

                                      indicatorPadding: const EdgeInsets.only(top: 43),
                                      indicatorWeight: 0.1,
                                      indicator: const BoxDecoration(
                                          color: AppColors.blue_246BFD,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(5), topRight: Radius.circular(5))),
                                      tabs: [
                                        Tab(
                                          child: Text(
                                            'Mô tả',
                                            style: TextStyle(
                                                color: provider.index == 0 ? AppColors.blue_246BFD : AppColors.h434343,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Tab(
                                          child: Text(
                                            'Khóa học',
                                            style: TextStyle(
                                                color: provider.index == 1 ? AppColors.blue_246BFD : AppColors.h434343,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),

                                    Divider(
                                      color: AppColors.h9497AD.withOpacity(0.5),
                                      height: 0,
                                    ),
                                  ],
                                )
                              : Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 50,
                                    decoration:
                                        BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                  // child: ,
                  // child: CourseMentorWidget(provider: provider),
                  child: provider.index == 0
                      ? AboutMentorWidget(provider: provider)
                      : CourseMentorWidget(provider: provider))
            ]),
          ),
        ),
      ),
    );
  }

  @override
  DetailMentorVM create() {
    return DetailMentorVM();
  }

  @override
  void initialise(BuildContext context) {
    provider.idMentor = widget.idMentor;
  }
}
