import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/model/master_value.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/utils/tools.dart';
import 'package:prize_lottery_app/widgets/cached_avatar.dart';

class MasterHeader extends SliverPersistentHeaderDelegate {
  ///
  final MasterValue master;

  ///是否订阅专家
  final int subscribed;

  ///
  final double expandedHeight;

  ///
  final double collapsedHeight;

  ///
  final Widget widget;

  ///
  final GestureTapCallback onTap;

  MasterHeader({
    required this.master,
    required this.subscribed,
    required this.widget,
    required this.expandedHeight,
    required this.onTap,
    this.collapsedHeight = 46,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      height: maxExtent,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            child: widget,
          ),
          Positioned(
            top: 0,
            child: _buildHeaderView(shrinkOffset),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderView(double shrinkOffset) {
    return Container(
      width: Get.width,
      height: collapsedHeight,
      color: makeStickyHeaderBgColor(shrinkOffset),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: EdgeInsets.only(left: 16.w),
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 26.w,
                  height: 26.w,
                  decoration: BoxDecoration(
                    color: shrinkBackColor(
                      shrinkOffset,
                      Colors.black12.withValues(alpha: 0.04),
                    ),
                    borderRadius: BorderRadius.circular(20.w),
                  ),
                  child: Icon(
                    const IconData(0xe669, fontFamily: 'iconfont'),
                    size: 18.w,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 28.w,
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 3.w, right: 8.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.w),
              color: shrinkColor(
                shrinkOffset,
                subscribed == 0
                    ? const Color(0xFFFF0033).withValues(alpha: 0.08)
                    : const Color(0xFFF4F4F4),
              ),
            ),
            child: shrinkOffset >= 50
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Opacity(
                        opacity: makeImageOpacity(shrinkOffset),
                        child: Container(
                          height: 22.w,
                          width: 22.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: subscribed == 0
                                ? const Color(0xFFFF0033).withValues(alpha: 0.4)
                                : const Color(0xFFC1C1C1),
                            borderRadius: BorderRadius.circular(22.w),
                          ),
                          child: CachedAvatar(
                            width: 19.w,
                            height: 19.w,
                            radius: 19.w,
                            url: master.avatar,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 6.w),
                        child: Text(
                          Tools.limitText(master.name, 2),
                          style: TextStyle(
                            fontSize: 14.sp,
                            height: 1.25,
                            fontWeight: FontWeight.w600,
                            color: shrinkColor(
                              shrinkOffset,
                              subscribed == 0
                                  ? const Color(0xFFFF0033)
                                  : Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Text(
                    '专家详情',
                    style: TextStyle(
                      color: shrinkBackColor(shrinkOffset, Colors.black),
                      fontSize: 17.sp,
                    ),
                  ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(right: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: onTap,
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 34.w,
                      height: 32.w,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 4.w),
                      child: Icon(
                        const IconData(0xe65e, fontFamily: 'iconfont'),
                        size: 18.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.browse);
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: 34.w,
                        height: 32.w,
                        alignment: Alignment.center,
                        child: Icon(
                          const IconData(0xe64d, fontFamily: 'iconfont'),
                          size: 24.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
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
    return Colors.white.withAlpha(alpha);
  }

  Color shrinkColor(double shrinkOffset, Color color) {
    if (shrinkOffset <= 50) {
      return Colors.transparent;
    }
    double oldAlpha = color.a;
    int alpha = (shrinkOffset / (maxExtent - minExtent) * oldAlpha)
        .clamp(0, oldAlpha)
        .toInt();
    return color.withAlpha(alpha);
  }

  Color makeStickyHeaderTextColor(shrinkOffset, isIcon) {
    if (shrinkOffset <= 50) {
      return isIcon ? Colors.white : Colors.transparent;
    } else {
      final int alpha =
          (shrinkOffset / (maxExtent - minExtent) * 255).clamp(0, 255).toInt();
      return Colors.black.withAlpha(alpha);
    }
  }

  double makeImageOpacity(double shrinkOffset) {
    if (shrinkOffset <= 50) {
      return 0;
    }
    double offset = maxExtent - minExtent;
    if (shrinkOffset <= offset) {
      return shrinkOffset / (maxExtent - minExtent);
    }
    return 1;
  }

  Color shrinkBackColor(double shrinkOffset, Color color) {
    if (shrinkOffset >= 50) {
      return Colors.transparent;
    }
    double oldAlpha = color.a;
    double alpha = ((50 - shrinkOffset) / 50 * oldAlpha).clamp(0, oldAlpha);
    return Color.from(
      alpha: alpha,
      red: color.r,
      green: color.g,
      blue: color.b,
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => collapsedHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
