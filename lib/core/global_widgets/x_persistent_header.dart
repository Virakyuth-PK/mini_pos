import 'package:flutter/material.dart';

class XPersistentHeader extends SliverPersistentHeaderDelegate {
  final Widget widget;
  final double height;

  XPersistentHeader({required this.widget, this.height = 60});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox(width: double.infinity, height: height, child: widget);
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
