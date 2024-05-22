import 'package:flutter/material.dart';
import 'package:kltn/src/base/base_page.dart';
import 'package:kltn/src/components/paginate.dart';
import 'package:kltn/src/page/auth/sign_in/sign_in_page.dart';
import 'package:kltn/src/page/detail_course_type.dart/detail_course_type_page.dart';
import 'package:kltn/src/page/home/widgets/continue_learning.dart';
import 'package:kltn/src/page/home/widgets/popular_course.dart';
import 'package:kltn/src/page/home/widgets/top_mentor.dart';
import 'package:kltn/src/page/notification/notification_page.dart';
import 'package:kltn/src/page/search/search_page.dart';
import 'package:kltn/src/page/view_all_course_type/view_all_coure_type_page.dart';
import 'package:kltn/src/utils/app_colors.dart';
import 'package:shimmer/shimmer.dart';

import '../main/widget/dialog_login.dart';
import 'home_vm.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with MixinBasePage<HomeVM> {
  @override
  Widget build(BuildContext context) {
    return builder(() => Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 200,
                    padding: const EdgeInsets.only(right: 15, left: 15, top: 60),
                    decoration: const BoxDecoration(
                        color: AppColors.blue_246BFD,
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            !provider.isLoadingUser
                                ? provider.isLogIn
                                    ? Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Hi, ${provider.userName}',
                                            style: const TextStyle(
                                                fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.white),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
                                            'Bắt đầu học ngay thôi nào!',
                                            style: TextStyle(color: Colors.white60, fontSize: 14),
                                          ),
                                        ],
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => const SignInPage(),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          'Đăng nhập ngay',
                                          style: TextStyle(
                                              fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.white),
                                        ),
                                      )
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          width: 50,
                                          height: 10,
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20), color: Colors.white),
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
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20), color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                            const Spacer(),
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: provider.isLogIn
                                  ? () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const NotificationPage(),
                                        ),
                                      ).then((value) {
                                        if (value == true) {
                                          provider.newsNotification();
                                        }
                                      });
                                    }
                                  : () {
                                      showDialog(
                                        context: context,
                                        builder: (ctx) => const DialogLogin(
                                          login: {'notification': true},
                                        ),
                                      );
                                      return;
                                    },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white.withOpacity(0.3),
                                    ),
                                    child: const Icon(Icons.notifications_active, color: Colors.white),
                                  ),
                                  Positioned(
                                    right: 7,
                                    top: 7,
                                    child: Visibility(
                                      visible: provider.countNews > 0,
                                      child: Container(
                                        height: 10,
                                        width: 10,
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                child: TextField(
                                  readOnly: true,
                                  decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.search,
                                        color: AppColors.blue_246BFD,
                                      ),
                                      hintText: 'Tìm kiếm...',
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(color: AppColors.grayA2.withOpacity(0.8))),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const SearchPage(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            // const SizedBox(
                            //   width: 10,
                            // ),
                            // Container(
                            //   height: 45,
                            //   width: 45,
                            //   decoration: BoxDecoration(
                            //     color: Colors.white,
                            //     borderRadius: BorderRadius.circular(8),
                            //   ),
                            //   child: const Icon(
                            //     Icons.filter_alt,
                            //     color: AppColors.blue_246BFD,
                            //   ),
                            // )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ScrollConfiguration(
                      behavior: const ScrollBehavior().copyWith(overscroll: false),
                      child: Paginate(
                        onRefresh: () {
                          setState(() {
                            provider.refeshAll();
                          });
                        },
                        refreshController: provider.refreshALlController,
                        enablePullDown: true,
                        onLoading: () {},
                        child: CustomScrollView(
                          controller: provider.scrollController,
                          slivers: [
                            SliverToBoxAdapter(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Danh mục',
                                          style:
                                              TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                                        ),
                                        const Spacer(),
                                        !provider.isLoadingCatelory
                                            ? GestureDetector(
                                                onTap: () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => const ViewAllCourseTypePage(),
                                                    )),
                                                child: const Text(
                                                  'Xem tất cả',
                                                  style: TextStyle(
                                                      fontSize: 12, color: Colors.amber, fontWeight: FontWeight.w400),
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
                                  !provider.isLoadingCatelory
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 15),
                                          child: SizedBox(
                                            height: (MediaQuery.of(context).size.width / 4) + 20,
                                            child: provider.listTypeModel.isNotEmpty
                                                ? ListView.builder(
                                                    physics: const AlwaysScrollableScrollPhysics(),
                                                    scrollDirection: Axis.horizontal,
                                                    itemCount: provider.listTypeModel.length,
                                                    itemBuilder: (context, index) {
                                                      return GestureDetector(
                                                        onTap: () => Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) => DetailCourseTypePage(
                                                                nameType: provider.listTypeModel[index]),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.only(
                                                              right:
                                                                  provider.listTypeModel.length - index == 1 ? 0 : 20,
                                                              top: 20),
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                height: (MediaQuery.of(context).size.width - 90) / 4,
                                                                width: (MediaQuery.of(context).size.width - 90) / 4,
                                                                padding: const EdgeInsets.all(15),
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(60),
                                                                    color: AppColors.h595959.withOpacity(0.08)),
                                                                child: Image.network(
                                                                    provider.listTypeModel[index].typeThumnail ?? ''),
                                                              ),
                                                              const SizedBox(
                                                                height: 7,
                                                              ),
                                                              SizedBox(
                                                                width: 70,
                                                                child: Text(
                                                                  provider.listTypeModel[index].typeName ?? '',
                                                                  overflow: TextOverflow.ellipsis,
                                                                  textAlign: TextAlign.center,
                                                                  style: const TextStyle(
                                                                      color: Colors.black,
                                                                      fontSize: 12,
                                                                      fontWeight: FontWeight.w400),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : const Center(
                                                    child: Text(
                                                      'Không có dữ liệu',
                                                      style: TextStyle(color: Colors.black, fontSize: 14),
                                                    ),
                                                  ),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 15),
                                          child: SizedBox(
                                            height: (MediaQuery.of(context).size.width / 4) + 20,
                                            child: ListView.builder(
                                              physics: const AlwaysScrollableScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              itemCount: 10,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: EdgeInsets.only(right: (10 - index == 1) ? 0 : 20, top: 20),
                                                  child: Column(
                                                    children: [
                                                      Shimmer.fromColors(
                                                        baseColor: Colors.grey.shade300,
                                                        highlightColor: Colors.grey.shade100,
                                                        child: Container(
                                                          height: (MediaQuery.of(context).size.width - 90) / 4,
                                                          width: (MediaQuery.of(context).size.width - 90) / 4,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(60),
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 7),
                                                      Shimmer.fromColors(
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
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                  PopularCourseWidget(
                                    provider: provider,
                                  ),
                                  TopMentorWidget(
                                    provider: provider,
                                  ),
                                  ContinueLearningWidget(provider: provider),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  @override
  HomeVM create() {
    return HomeVM();
  }

  @override
  void initialise(BuildContext context) {}
}
