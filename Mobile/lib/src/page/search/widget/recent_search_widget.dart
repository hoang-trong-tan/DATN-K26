import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kltn/src/page/search/search_vm.dart';

import '../../../utils/app_colors.dart';

class RecentSearchWidget extends StatefulWidget {
  const RecentSearchWidget({super.key, required this.provider});
  final SearchVM provider;

  @override
  State<RecentSearchWidget> createState() => _RecentSearchWidgetState();
}

class _RecentSearchWidgetState extends State<RecentSearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Lịch sử tìm kiếm',
                style: TextStyle(color: AppColors.h434343, fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  setState(() {
                    widget.provider.listRecent.clear();
                    widget.provider.removeListRecent;
                  });
                },
                child: const Icon(
                  Icons.delete_forever_sharp,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          widget.provider.listRecent.isNotEmpty
              ? ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(overscroll: false),
                  child: Expanded(
                    child: ListView.builder(
                      itemCount: widget.provider.listRecent.length,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: InkResponse(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              widget.provider.setPrefRecentSearchList();
                              widget.provider.controller.text = widget.provider.listRecent[index];
                              widget.provider.checkViewSearch = true;
                              widget.provider.fetchSearchByType(refresh: true);
                            },
                            child: Row(
                              children: [
                                Text(
                                  widget.provider.listRecent[index],
                                  style: const TextStyle(
                                      color: AppColors.grayA2,
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w400),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    setState(() {
                                      widget.provider.listRecent.removeAt(index);
                                      widget.provider.setPrefRecentSearchList();
                                    });
                                  },
                                  child: SvgPicture.asset(
                                    'assets/icon/cancel.svg',
                                    height: 14,
                                    width: 30,
                                  ),
                                ),
                                const SizedBox(
                                  width: 3,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              : Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: const Center(
                        child: Text(
                      'Không có dữ liệu',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    )),
                  ),
                )
        ],
      ),
    );
  }
}
