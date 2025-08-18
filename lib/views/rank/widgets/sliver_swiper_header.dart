import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/resources/colors.dart';

class SliverSwiperHeader extends SliverPersistentHeaderDelegate {
  final double collapseHeight;
  final double expandedHeight;
  final double paddingTop;
  final Widget child;
  final String title;
  final bool showBack;

  SliverSwiperHeader({
    this.collapseHeight = 44,
    this.expandedHeight = 0,
    this.paddingTop = 0,
    required this.child,
    required this.title,
    this.showBack = true,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: lineColor, blurRadius: 1, spreadRadius: 0.2)
        ],
      ),
      height: maxExtent,
      width: double.infinity,
      child: Stack(
        children: [
          child,
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              color: makeStickyHeaderBgColor(shrinkOffset),
              height: collapseHeight + paddingTop,
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(top: paddingTop),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: showBack
                          ? GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                width: 50.w,
                                height: 26.w,
                                padding: EdgeInsets.only(left: 16.w),
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  const IconData(0xe669,
                                      fontFamily: 'iconfont'),
                                  size: 18.w,
                                  color: makeStickyHeaderTextColor(
                                      shrinkOffset, false),
                                ),
                              ),
                            )
                          : Container(),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17.sp,
                          color: makeStickyHeaderTextColor(shrinkOffset, false),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color makeStickyHeaderBgColor(shrinkOffset) {
    final int alpha =
        (shrinkOffset / (maxExtent - minExtent) * 255).clamp(0, 255).toInt();
    return Color.fromARGB(alpha, 255, 255, 255);
  }

  Color makeStickyHeaderTextColor(shrinkOffset, isIcon) {
    if (shrinkOffset <= 50) {
      return isIcon ? Colors.white : Colors.transparent;
    } else {
      final int alpha =
          (shrinkOffset / (maxExtent - minExtent) * 255).clamp(0, 255).toInt();
      return Color.fromARGB(alpha, 0, 0, 0);
    }
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => collapseHeight + paddingTop;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
