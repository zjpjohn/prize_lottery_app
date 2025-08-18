import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/routes/names.dart';

///
///
class SearchHeader extends SliverPersistentHeaderDelegate {
  ///
  /// 标题
  String title;

  ///
  /// 搜索数量
  int masters;

  ///
  /// 垂直偏移量
  double vOffset = 10.w;

  ///
  /// 文字颜色偏移量
  double fOffset = 28.w;

  SearchHeader({
    required this.title,
    required this.masters,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    double positionR = 0.0, xOffset = 72.w;
    positionR =
        shrinkOffset <= vOffset ? xOffset * shrinkOffset / vOffset : xOffset;
    return SizedBox(
      height: maxExtent,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            child: _buildTopView(shrinkOffset),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            right: positionR,
            child: _buildSearchView(),
          ),
        ],
      ),
    );
  }

  Color shrinkColor(double shrinkOffset, Color color) {
    if (shrinkOffset == 0) {
      return color;
    }
    if (shrinkOffset <= fOffset) {
      double oldAlpha = color.a;
      double alpha = (shrinkOffset / fOffset * oldAlpha).clamp(0, oldAlpha);
      return Color.from(
        alpha: oldAlpha - alpha,
        red: color.r,
        green: color.g,
        blue: color.b,
      );
    }
    return Colors.transparent;
  }

  Widget _buildTopView(double shrinkOffset) {
    return Container(
      width: Get.width,
      height: 38.w,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: shrinkColor(shrinkOffset, Colors.white),
              fontSize: 24.sp,
              fontFamily: 'shuhei',
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.browse);
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 36.w,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(top: 1.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        const IconData(0xe642, fontFamily: 'iconfont'),
                        size: 20.sp,
                        color: Colors.white,
                      ),
                      Text(
                        '足 迹',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.expertCenter);
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 36.w,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(top: 1.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        const IconData(0xe63e, fontFamily: 'iconfont'),
                        size: 20.sp,
                        color: Colors.white,
                      ),
                      Text(
                        '预 测',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchView() {
    return Container(
      height: 38.w,
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(left: 8.w),
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.w),
          border: Border.all(color: Colors.white38, width: 1.2.w),
        ),
        child: GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.searchMaster);
          },
          behavior: HitTestBehavior.opaque,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 1.w),
                child: Icon(
                  const IconData(0xe650, fontFamily: 'iconfont'),
                  size: 15.sp,
                  color: Colors.white70,
                ),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  "$masters+专家为您推荐服务",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white70, fontSize: 13.sp),
                ),
              ),
              Container(
                height: 30.w,
                // margin: EdgeInsets.only(right: 1.w),
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                decoration: BoxDecoration(
                  color: Colors.white38,
                  borderRadius: BorderRadius.circular(20.w),
                ),
                alignment: Alignment.center,
                child: Text(
                  '搜索',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 76.w;

  @override
  double get minExtent => 38.w;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
