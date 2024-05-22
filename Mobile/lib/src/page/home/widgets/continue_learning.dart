import 'package:flutter/material.dart';
import 'package:kltn/src/page/auth/sign_in/sign_in_page.dart';
import 'package:kltn/src/page/home/home_vm.dart';
import 'package:kltn/src/page/main/main_page.dart';
import 'package:kltn/src/utils/app_colors.dart';
import 'package:shimmer/shimmer.dart';

import '../../course/course_page.dart';

class ContinueLearningWidget extends StatefulWidget {
  const ContinueLearningWidget({super.key, required this.provider});
  final HomeVM provider;

  @override
  State<ContinueLearningWidget> createState() => _ContinueLearningWidgetState();
}

class _ContinueLearningWidgetState extends State<ContinueLearningWidget> {
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
                'Đang học',
                style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              !widget.provider.isLoadingContinue
                  ? GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainPage(initPage: 1),
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
        const SizedBox(
          height: 20,
        ),
        widget.provider.isLogIn
            ? !widget.provider.isLoadingContinue
                ? widget.provider.modelProcessOngoing.isNotEmpty
                    ? ListView.builder(
                        itemCount: widget.provider.modelProcessOngoing.length,
                        shrinkWrap: true,
                        controller: widget.provider.scrollController,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CoursePage(
                                    // getCourseData: [],
                                    idCourse: widget.provider.modelProcessOngoing[index].courseInfo?.id ?? '',
                                  ),
                                )),
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
                                              image: NetworkImage(widget
                                                      .provider.modelProcessOngoing[index].courseInfo?.courseThumnail ??
                                                  ''),
                                              fit: BoxFit.cover)),
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            // width: 50,
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                color: Colors.amber.withOpacity(0.2)),
                                            child: Text(
                                                widget.provider.modelProcessOngoing[index].courseInfo?.courseType !=
                                                        null
                                                    ? widget.provider.modelProcessOngoing[index].courseInfo
                                                            ?.courseType['type_name'] ??
                                                        ''
                                                    : 'Lập trình',
                                                style: const TextStyle(
                                                    fontSize: 12, color: Colors.amber, fontWeight: FontWeight.w400)),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            widget.provider.modelProcessOngoing[index].courseInfo?.courseName ?? '',
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
                                              Text(
                                                widget.provider.modelProcessOngoing[index].courseInfo?.userTeacher
                                                        ?.userName ??
                                                    '',
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
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width - 200,
                                                child: LinearProgressIndicator(
                                                    minHeight: 10,
                                                    value: widget.provider.modelProcessOngoing[index].processCourse,
                                                    backgroundColor: AppColors.hECECEC,
                                                    color: AppColors.blue_246BFD,
                                                    borderRadius: BorderRadius.circular(5)),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                '${(widget.provider.modelProcessOngoing[index].processCourse ?? 0) * 100}%',
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors.h8C8C8C),
                                              )
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
                    : const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 30),
                        child: Center(
                          child: Text(
                            'Không có khóa học nào đang học',
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ),
                      )
                : ListView.builder(
                    itemCount: 10,
                    shrinkWrap: true,
                    controller: widget.provider.scrollController,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
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
                  )
            : GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignInPage(),
                      ));
                },
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 60),
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.blue_246BFD),
                      color: Colors.white,
                    ),
                    child: const Center(
                      child: Text('Đăng nhập',
                          style: TextStyle(color: AppColors.blue_246BFD, fontSize: 16, fontWeight: FontWeight.w500)),
                    ),
                  ),
                ),
              )
      ],
    );
  }
}
