import 'package:flutter/material.dart';
import 'package:kltn/src/base/base_page.dart';
import 'package:kltn/src/components/paginate.dart';
import 'package:kltn/src/page/notification/detail_notification/detail_notification_page.dart';
import 'package:kltn/src/page/notification/notification_vm.dart';
import 'package:shimmer/shimmer.dart';

import '../../base/helper/helper.dart';
import '../../utils/app_colors.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> with MixinBasePage<NotificationVM> {
  @override
  Widget build(BuildContext context) {
    return builder(
      () => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            // toolbarHeight: 80,
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
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: AppColors.white, width: 0.5)),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context, provider.checkNotifi);
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
              'Thông báo',
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
              provider.fetchAllNotification(isRefresh: true);
            },
            refreshController: provider.refreshController,
            enablePullDown: true,
            enablePullUp: true,
            onLoading: () {
              provider.fetchAllNotification(isRefresh: false);
            },
            child: provider.isLoading
                ? loading()
                : provider.listNotifation.isNotEmpty
                    ? ListView.separated(
                        shrinkWrap: true,
                        itemCount: provider.listNotifation.length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () async {
                              if (provider.listNotifation[index].status == false) {
                                provider.readNotify(provider.listNotifation[index].id ?? '', index);
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailNotificationPage(
                                    model: provider.listNotifation[index],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              color: !(provider.listNotifation[index].status ?? true)
                                  ? AppColors.blue_246BFD.withOpacity(0.1)
                                  : Colors.transparent,
                              padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.symmetric(vertical: 10),
                                    decoration:
                                        BoxDecoration(color: Colors.grey.withOpacity(0.1), shape: BoxShape.circle),
                                    child: const Icon(Icons.chat_bubble_sharp, color: AppColors.blue_246BFD),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              provider.listNotifation[index].title ?? '',
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
                                            ),
                                            const Spacer(),
                                            Text(
                                              Helper.formatRelativeDate(provider.listNotifation[index].createdAt ?? ''),
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          provider.listNotifation[index].description ?? '',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            color: Colors.grey.withOpacity(0.5),
                            height: 0,
                          );
                        },
                      )
                    : const Center(
                        child: Text(
                          'Không có thông báo',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ),
          ),
        ),
      ),
    );
  }

  @override
  NotificationVM create() {
    return NotificationVM();
  }

  @override
  void initialise(BuildContext context) {
  }
  Widget loading() {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 20,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            color: AppColors.blue_246BFD.withOpacity(0.1),
            padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
            child: Row(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1), shape: BoxShape.circle),
                    child: const Icon(Icons.chat_bubble_sharp, color: AppColors.blue_246BFD),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                height: 10,
                                width: 200,
                                color: Colors.amber,
                              )),
                          const Spacer(),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              height: 10,
                              width: 20,
                              color: Colors.amber,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          height: 20,
                          width: 200,
                          color: Colors.amber,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: Colors.grey.withOpacity(0.5),
          height: 0,
        );
      },
    );
  }
}
