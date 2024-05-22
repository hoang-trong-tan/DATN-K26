import 'package:flutter/material.dart';
import 'package:kltn/src/components/paginate.dart';

import '../../../utils/app_colors.dart';
import '../search_vm.dart';
import 'course_widget.dart';
import 'mentor_widget.dart';

class ResultSearchWidget extends StatefulWidget {
  const ResultSearchWidget({super.key, required this.provider});
  final SearchVM provider;

  @override
  State<ResultSearchWidget> createState() => _ResultSearchWidgetState();
}

class _ResultSearchWidgetState extends State<ResultSearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            onTap: (value) {
              setState(() {
                widget.provider.index = value;
                if (value == 1) {
                  widget.provider.fetchSearchUser(refresh: true);
                } else {
                  widget.provider.fetchSearchByType(refresh: true);
                }
              });
            },
            // indicatorColor: AppColors.blue_246BFD,

            indicatorPadding: const EdgeInsets.only(top: 43),
            indicatorWeight: 0.1,
            indicator: const BoxDecoration(
                color: AppColors.blue_246BFD,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5))),
            tabs: [
              Tab(
                child: Text(
                  'Khóa học',
                  style: TextStyle(
                      color: widget.provider.index == 0 ? AppColors.blue_246BFD : AppColors.h434343,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Tab(
                child: Text(
                  'Giáo viên',
                  style: TextStyle(
                      color: widget.provider.index == 1 ? AppColors.blue_246BFD : AppColors.h434343,
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
          const SizedBox(
            height: 15,
          ),
          Text(
            'Kết quả tìm kiếm "${widget.provider.controller.text}"',
            style: const TextStyle(
                color: AppColors.h434343, overflow: TextOverflow.ellipsis, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Expanded(
            child: Paginate(
              onRefresh: () {
                widget.provider.checkloadingsearch = false;
                if (widget.provider.index == 1) {
                  widget.provider.fetchSearchUser(refresh: true);
                } else {
                  widget.provider.fetchSearchByType(refresh: true);
                }
              },
              refreshController: widget.provider.refreshController,
              enablePullDown: true,
              enablePullUp: widget.provider.enablePullUp,
              onLoading: () {
                widget.provider.checkloadingsearch = false;
                if (widget.provider.index == 1) {
                  widget.provider.fetchSearchUser(refresh: false);
                } else {
                  widget.provider.fetchSearchByType(refresh: false);
                }
              },
              child: widget.provider.index == 0
                  ? CourseWidget(
                      provider: widget.provider,
                    )
                  : MentorWidget(provider: widget.provider),
            ),
          ),
        ],
      ),
    );
  }
}
