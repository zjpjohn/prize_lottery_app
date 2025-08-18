import 'package:flutter/material.dart';

class SliverHeader extends SliverPersistentHeaderDelegate {
  final double expanded;
  final double collapse;
  final Widget child;

  SliverHeader({
    required this.expanded,
    required this.collapse,
    required this.child,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => expanded;

  @override
  double get minExtent => collapse;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
