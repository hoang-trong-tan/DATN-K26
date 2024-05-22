import 'package:flutter/material.dart';
import 'package:kltn/src/base/base_page.dart';
import 'package:kltn/src/page/my_course/my_course_vm.dart';
import 'package:kltn/src/page/my_course/widget/completed.dart';
import 'package:kltn/src/page/my_course/widget/ongoing.dart';

import '../../utils/app_colors.dart';

class MyCoursePage extends StatefulWidget {
  const MyCoursePage({super.key});

  @override
  State<MyCoursePage> createState() => _MyCoursePageState();
}

class _MyCoursePageState extends State<MyCoursePage>
    with MixinBasePage<MyCourseVM> {
  @override
  Widget build(BuildContext context) {
    return builder(
      () => DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.white,
            title: const Center(
              child: Text(
                'Khóa học của tôi',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              TabBar(
                onTap: (value) {
                  setState(() {
                    provider.index = value;
                  });
                },
                // indicatorColor: AppColors.blue_246BFD,

                indicatorPadding: const EdgeInsets.only(top: 42),
                indicatorWeight: 0.1,
                indicator: const BoxDecoration(
                    color: AppColors.blue_246BFD,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5))),
                tabs: [
                  Tab(
                    child: Text(
                      'Đang học',
                      style: TextStyle(
                          color: provider.index == 0
                              ? AppColors.blue_246BFD
                              : AppColors.h434343,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Đã hoàn thành',
                      style: TextStyle(
                          color: provider.index == 1
                              ? AppColors.blue_246BFD
                              : AppColors.h434343,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              const Divider(
                color: AppColors.h9497AD,
                height: 0,
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(overscroll: false),
                  child: CustomScrollView(
                    controller: provider.ongoingControler,
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: [
                              provider.index == 0
                                  ? OngoingWidget(
                                      provider: provider,
                                    )
                                  : CompletedWidget(
                                      provider: provider,
                                    )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  MyCourseVM create() {
    return MyCourseVM();
  }

  @override
  void initialise(BuildContext context) {}
}
