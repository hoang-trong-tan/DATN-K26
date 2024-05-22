import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/app_colors.dart';

class LoadingDashboardWidget extends StatefulWidget {
  const LoadingDashboardWidget({super.key});

  @override
  State<LoadingDashboardWidget> createState() => _LoadingDashboardWidgetState();
}

class _LoadingDashboardWidgetState extends State<LoadingDashboardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 40,
        ),
        Expanded(
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: PieChart(
              dataMap: const {
                "Đang tải": 5,
                "Đang tải.": 3,
                "Đang tải..": 2,
                "Đang tải...": 2,
              },
              animationDuration: const Duration(milliseconds: 800),
              chartLegendSpacing: 32,
              chartRadius: MediaQuery.of(context).size.width / 3.2,
              // colorList: colorList,
              initialAngleInDegree: 0,
              chartType: ChartType.ring,
              ringStrokeWidth: 32,

              centerText: "Học Sinh",
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
        ),
        const Text(
          'Tất cả khóa học',
          style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            shrinkWrap: true,
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
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
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
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
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
        ),
      ]),
    );
  }
}
