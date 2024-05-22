import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kltn/src/base/base_page.dart';
import 'package:kltn/src/base/vnpay/vnpay.dart';
import 'package:kltn/src/page/course/course_page.dart';
import 'package:kltn/src/page/detail_course/detail_course_vm.dart';
import 'package:kltn/src/page/detail_course/widget/about_widget.dart';
import 'package:kltn/src/page/detail_course/widget/lesson.dart';
import 'package:kltn/src/page/detail_course/widget/review_widget.dart';
import 'package:kltn/src/page/video/video_page.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/app_colors.dart';
import '../main/widget/dialog_login.dart';
import 'widget/persisten_header.dart';

class DetailCoursePage extends StatefulWidget {
  const DetailCoursePage({super.key, required this.id, this.checkPay = false, this.login, this.idVideo});
  final String id;
  final String? idVideo;
  final bool checkPay;
  final Map<String, dynamic>? login;

  @override
  State<DetailCoursePage> createState() => _DetailCoursePageState();
}

class _DetailCoursePageState extends State<DetailCoursePage> with MixinBasePage<DetailCourseVM> {
  @override
  Widget build(BuildContext context) {
    return builder(
      () => DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: CustomScrollView(
              controller: provider.scrollController,
              slivers: [
                SliverAppBar(
                  backgroundColor: AppColors.white,
                  elevation: 0,
                  leading: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Row(
                        children: [
                          // Container(
                          //   height: 40,
                          //   width: 40,
                          //   decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     borderRadius: BorderRadius.circular(30),
                          //   ),
                          //   child: const Icon(
                          //     Icons.share,
                          //     color: Colors.black,
                          //   ),
                          // ),
                          const SizedBox(
                            width: 7,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (provider.isLogin) {
                                provider.addCart(provider.model.id);
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => DialogLogin(
                                    login: {'id_course': widget.id.toString(), 'cart': true},
                                  ),
                                );
                              }
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Icon(
                                Icons.bookmark,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  pinned: true,
                  expandedHeight: 250,
                  automaticallyImplyLeading: false,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        Container(
                          // height: 300,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(provider.model.courseThumnail ?? ''),
                              onError: (exception, stackTrace) => const Icon(
                                Icons.error,
                                color: Colors.amber,
                                size: 80,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Center(
                            child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                DialogRoute(
                                  context: context,
                                  builder: (context) => VideoPage(
                                    url: provider.model.courseDemoVideo ?? '',
                                    idCourse: '',
                                    idVideo: '',
                                    idVideoSession: const [],
                                    isView: false,
                                  ),
                                ));
                          },
                          child: const Icon(
                            Icons.play_circle,
                            size: 50,
                            color: Colors.white,
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      !provider.isLoading
                          ? Container(
                              color: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.amber.withOpacity(0.2)),
                                      child: const Text('Khóa học bán chạy',
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.amber, fontWeight: FontWeight.w500)),
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
                                      '${provider.model.courseRatingsAverage}/${provider.listComment.length} đánh giá',
                                      style: const TextStyle(
                                          color: AppColors.h9497AD, fontSize: 12, fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  provider.model.courseName ?? '',
                                  style:
                                      const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
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
                                            provider.mentorModel.findTeacher?.userName ?? '',
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
                                            '${provider.listData.length} Bài giảng',
                                            style: const TextStyle(
                                                color: AppColors.h9497AD, fontSize: 12, fontWeight: FontWeight.w400),
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
                                            provider.convertSecondsToMinute(provider.model.totalLength ?? 0),
                                            style: const TextStyle(
                                                color: AppColors.h9497AD, fontSize: 12, fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ]),
                            )
                          : infoLoading(context)
                    ],
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: PersistentHeader(
                    height: 50,
                    widget: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          !provider.isLoading
                              ? Column(
                                  children: [
                                    TabBar(
                                      onTap: (value) {
                                        setState(() {
                                          provider.index = value;
                                        });
                                      },
                                      dragStartBehavior: DragStartBehavior.down,
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
                                        Tab(
                                          child: Text(
                                            'Đánh giá',
                                            style: TextStyle(
                                                color: provider.index == 2 ? AppColors.blue_246BFD : AppColors.h434343,
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
                                    height: 30,
                                    padding: const EdgeInsets.all(6),
                                    decoration:
                                        BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 10),
                    child: Column(
                      children: [
                        if (provider.index == 0)
                          AboutWidget(
                            provider: provider,
                          )
                        else if (provider.index == 1)
                          LessonWidget(
                            provider: provider,
                          )
                        else
                          ReviewWidget(provider: provider),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            height: 80,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
              child: !provider.isLoading
                  ? provider.checkPay || provider.prefs.userID == provider.mentorModel.findTeacher?.id
                      ? GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CoursePage(
                                    // getCourseData: provider.model.getCourseData ?? [],
                                    idCourse: provider.model.id ?? '',
                                  ),
                                ));
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: AppColors.blue_246BFD,
                            ),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                    provider.prefs.userID == provider.mentorModel.findTeacher?.id
                                        ? 'Khóa học của bạn'
                                        : 'Học ngay',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400))),
                          ),
                        )
                      : Row(children: [
                          Column(
                            children: [
                              const Text(
                                'Giá',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.h8C8C8C,
                                ),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                '${NumberFormat.decimalPattern().format(provider.model.coursePrice ?? 0)} VND',
                                style: const TextStyle(
                                    fontSize: 18, color: AppColors.blue_246BFD, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (provider.isLogin) {
                                  provider.payCourse(widget.id);
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => DialogLogin(
                                      login: {'id_course': widget.id.toString()},
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: AppColors.blue_246BFD,
                                ),
                                child: const Align(
                                    alignment: Alignment.center,
                                    child: Text('Mua ngay',
                                        style:
                                            TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400))),
                              ),
                            ),
                          )
                        ])
                  : Row(children: [
                      Column(
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
                              width: 100,
                              height: 20,
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Expanded(
                          child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          width: 50,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: AppColors.blue_246BFD,
                          ),
                        ),
                      )),
                    ]),
            ),
          ),
        ),
      ),
    );
  }

  @override
  DetailCourseVM create() {
    return DetailCourseVM();
  }

  @override
  void initialise(BuildContext context) {
    provider.id = widget.id;
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (widget.checkPay == true) {
          if (provider.checkPay) {
            provider.showCompleted('Khóa học này đã được mua');
          } else {
            provider.payCourse(widget.id);
          }
        }
        if (widget.login?['cart'] != null) {
          provider.addCart(provider.model.id);
        }
      },
    );
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (widget.idVideo != null) {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return VideoPage(
                url: '',
                idCourse: widget.id,
                idVideo: widget.idVideo ?? '',
                idVideoSession: const [],
                isView: true,
              );
            },
          ));
        }
      },
    );
    provider.callback = (p0) async {
      await Navigator.push(
        context,
        DialogRoute(
          context: context,
          builder: (context) => WebviewScreen(
            paymentUrl: p0,
            onPaymentSuccess: (p0) async {
              await provider.fetchCourse();
              provider.show(true);
            },
            onPaymentError: (p0) {
              int code = int.parse(p0['vnp_ResponseCode']);
              provider.show(false, codeError: code);
            },
          ),
        ),
      ).then((value) {
        setState(() {
          if (value == true) {
            provider.isLoading = true;
          }
        });
      });
    };
  }
}

Widget infoLoading(BuildContext context) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
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
          const Spacer(),
          const SizedBox(
            width: 2,
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
      const SizedBox(
        height: 15,
      ),
      Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 30,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
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
          ),
          // const Spacer(),
          SizedBox(
            width: (MediaQuery.of(context).size.width - 30) / 3,
            child: Column(
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
          ),
          // const Spacer(),
          SizedBox(
            width: (MediaQuery.of(context).size.width - 30) / 3,
            child: Column(
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
          )
        ],
      ),
      const SizedBox(
        height: 5,
      ),
    ]),
  );
}
