import 'package:flutter/material.dart';

class PersistentHeader extends SliverPersistentHeaderDelegate {
  final Widget widget;
  final double? height;
  final Key? key;

  PersistentHeader({required this.widget, this.height, this.key});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      key: key,
      width: double.infinity,
      height: height ?? 45,
      child: widget,
    );
  }

  @override
  double get maxExtent => height ?? 50;

  @override
  double get minExtent => height ?? 45;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}