import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kltn/src/base/base_page.dart';
import 'package:kltn/src/components/paginate.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../utils/app_colors.dart';
import '../detail_course/detail_course_page.dart';
import 'dashboard_tearcher_vm.dart';
import 'widget/loading_dashboard_widget.dart';

class DashBoardTearcherPage extends StatefulWidget {
  const DashBoardTearcherPage({super.key});

  @override
  State<DashBoardTearcherPage> createState() => _DashBoardTearcherPageState();
}

class _DashBoardTearcherPageState extends State<DashBoardTearcherPage> with MixinBasePage<DashboardTearcherVM> {
  @override
  Widget build(BuildContext context) {
    return builder(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.blue_246BFD,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40), border: Border.all(color: AppColors.white, width: 0.5)),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          title: const Text(
            'Thông số khóa học',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
        ),
        body: Paginate(
          onRefresh: () {
            provider.fetchCourseMentor();
          },
          refreshController: provider.refreshController,
          enablePullDown: true,
          onLoading: () {},
          child: provider.isLoading
              ? const LoadingDashboardWidget()
              : provider.listCourse.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Expanded(
                          child: PieChart(
                            dataMap: provider.listPurchased,
                            animationDuration: const Duration(milliseconds: 800),
                            chartLegendSpacing: 32,
                            chartRadius: MediaQuery.of(context).size.width / 3.2,
                            // colorList: colorList,
                            initialAngleInDegree: 0,
                            chartType: ChartType.ring,
                            ringStrokeWidth: 32,

                            centerText: "${provider.count} HS",
                            legendOptions: const LegendOptions(
                              showLegendsInRow: false,
                              legendPosition: LegendPosition.bottom,
                              showLegends: true,
                              legendShape: BoxShape.circle,
                              legendTextStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValueBackground: true,
                              showChartValues: true,
                              showChartValuesInPercentage: false,
                              showChartValuesOutside: false,
                              decimalPlaces: 1,
                            ),
                          ),
                        ),
                        const Text(
                          'Tất cả khóa học',
                          style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: provider.listCourse.length,
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailCoursePage(
                                        id: provider.listCourse[index].id ?? '',
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 7),
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
                                                  image: NetworkImage(provider.listCourse[index].courseThumnail ?? ''),
                                                  fit: BoxFit.cover)),
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                provider.listCourse[index].courseName ?? '',
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
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    provider.listCourse[index].userTeacher?.userName ?? '',
                                                    style: const TextStyle(
                                                        color: AppColors.h8C8C8C,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w400),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    '${NumberFormat.decimalPattern().format(provider.listCourse[index].coursePrice)} VND',
                                                    style: const TextStyle(
                                                        color: AppColors.blue_246BFD,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500),
                                                  ),
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
                          ),
                        ),
                      ]),
                    )
                  : const Center(
                      child: Text(
                        'Không có khóa học nào đã đăng',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ),
        ),
      ),
    );
  }

  @override
  DashboardTearcherVM create() {
    return DashboardTearcherVM();
  }

  @override
  void initialise(BuildContext context) {}
}
