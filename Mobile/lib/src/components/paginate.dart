import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Paginate extends StatelessWidget {
  const Paginate({
    Key? key,
    required this.child,
    required this.onRefresh,
    required this.refreshController,
    required this.enablePullDown,
    required this.onLoading,
    this.primary,
    this.enablePullUp,
    this.scrollDirection,
    this.header,
    this.footer,
    this.noDataText,
    this.reverse,
  }) : super(key: key);

  final Function() onRefresh;
  final Function() onLoading;
  final bool enablePullDown;
  final Widget child;
  final bool? primary;
  final RefreshController? refreshController;
  final bool? enablePullUp;
  final bool? reverse;
  final Axis? scrollDirection;
  final Widget? header;
  final Widget? footer;
  final String? noDataText;

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      physics: const ClampingScrollPhysics(),
      primary: primary ?? false,
      onRefresh: onRefresh,
      onLoading: onLoading,
      controller: refreshController!,
      enablePullUp: enablePullUp ?? false,
      enablePullDown: enablePullDown,
      scrollDirection: scrollDirection,
      reverse: reverse,
      header: header ??
          const ClassicHeader(
            idleText: 'Vuốt xuống để làm mới',
            releaseText: 'Vuốt xuống để làm mới dữ liệu',
            completeText: 'Làm mới dữ liệu thành công',
            refreshingText: 'Làm mới dữ liệu',
            failedText: 'Làm mới dữ liệu lỗi',
            canTwoLevelText: 'Vuốt xuống để làm mới',
          ),
      footer: footer ??
          ClassicFooter(
            loadingText: 'Đang tải...',
            canLoadingText: 'Vuốt lên để tải thêm dữ liệu',
            failedText: 'Lỗi khi tải thêm dữ liệu',
            idleText: noDataText ?? 'Vuốt lên để tải thêm dữ liệu',
            idleIcon: const SizedBox(),
            noDataText: noDataText ?? '', //'smart_refresh_009'.tr,
          ),
      child: child,
    );
  }
}
