import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/store/store.dart';
import 'package:prize_lottery_app/utils/tools.dart';
import 'package:prize_lottery_app/views/user/model/user_auth.dart';
import 'package:prize_lottery_app/widgets/message_hint_view.dart';

///
/// 垂直偏移量
final double verticalOffset = 46.w;

///
/// 文字垂直最大偏移
final double fontOffset = 40.w;

///
/// header头部白色透明渐变
Color shrinkWhite(double shrinkOffset) {
  if (shrinkOffset == 0) {
    return Colors.transparent;
  }
  if (shrinkOffset <= verticalOffset) {
    int alpha = (shrinkOffset / verticalOffset * 255).clamp(0, 255).toInt();
    return Color.fromARGB(alpha, 255, 255, 255);
  }
  return Colors.white;
}

Color shrinkColor(double shrinkOffset, Color color) {
  if (shrinkOffset == 0) {
    return color;
  }
  if (shrinkOffset <= fontOffset) {
    double oldAlpha = color.a;
    double alpha = (shrinkOffset / fontOffset * oldAlpha).clamp(0, oldAlpha);
    return Color.from(
      alpha: oldAlpha - alpha,
      red: color.r,
      green: color.g,
      blue: color.b,
    );
  }
  return Colors.transparent;
}

double imageSize(double shrinkOffset) {
  if (shrinkOffset == 0) {
    return 48.w;
  }
  if (shrinkOffset <= verticalOffset) {
    return 48.w - shrinkOffset * 24.w / verticalOffset;
  }
  return 24.w;
}

class UCenterHeader extends SliverPersistentHeaderDelegate {
  ///展开高度
  final double expanded = 120.w;

  ///收缩高度
  final double collapse = 44.w;

  final double top;

  UCenterHeader(this.top);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: maxExtent,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6FB),
        boxShadow: shrinkOffset >= 72.w
            ? [
                const BoxShadow(
                  color: Color(0xFFF6F6FB),
                  offset: Offset(0, 3),
                  blurRadius: 3,
                  spreadRadius: 2,
                ),
              ]
            : [],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            child: _buildUserView(shrinkOffset),
          ),
          Positioned(
            top: 0,
            child: _buildTopHeader(shrinkOffset),
          ),
        ],
      ),
    );
  }

  Widget _buildTopHeader(double shrinkOffset) {
    return Container(
      width: Get.width,
      height: top + collapse,
      color: shrinkWhite(shrinkOffset),
      child: Column(
        children: [
          SizedBox(
            height: top,
            width: Get.width,
          ),
          Container(
            width: Get.width,
            height: 44.w,
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 8.w, right: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GetBuilder<UserStore>(builder: (store) {
                  return Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 8.w),
                      child: Visibility(
                        visible: shrinkOffset >= verticalOffset,
                        child: Image.asset(
                          store.authUser != null ? R.avatar : R.unLogin,
                          fit: BoxFit.contain,
                          width: 24.w,
                          height: 24.w,
                        ),
                      ),
                    ),
                  );
                }),
                Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      shrinkOffset >= fontOffset ? '我的' : '',
                      style: TextStyle(fontSize: 18.sp, color: Colors.black87),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.settings);
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: SizedBox(
                            width: 20.w,
                            child: Lottie.asset(R.settingLottie, repeat: true),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.hintMessage);
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: const MessageHintView(),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserView(double shrinkOffset) {
    double size = imageSize(shrinkOffset);
    return Container(
      height: 70.w,
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.w),
      child: GetBuilder<UserStore>(builder: (store) {
        if (store.authUser != null) {
          return _authedView(store.authUser!, shrinkOffset, size);
        }
        return _unAuthedView(shrinkOffset, size);
      }),
    );
  }

  Widget _authedView(AuthUser user, double shrinkOffset, double size) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: 10.w),
            child: Image.asset(R.avatar, width: size, height: size),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Tools.encodeTel(user.phone),
                style: TextStyle(
                  fontSize: 24.sp,
                  color: shrinkColor(shrinkOffset, Colors.black87),
                ),
              ),
              Text(
                '凡彩为您的幸运而喝彩',
                style: TextStyle(
                  color: shrinkColor(shrinkOffset, Colors.black54),
                  fontSize: 13.sp,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _unAuthedView(double shrinkOffset, double size) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.login);
      },
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: 10.w),
            child: Image.asset(R.unLogin, width: size, height: size),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '快速登录',
                style: TextStyle(
                  fontSize: 24.sp,
                  color: shrinkColor(shrinkOffset, Colors.black87),
                ),
              ),
              Text(
                '凡彩为您的幸运而喝彩',
                style: TextStyle(
                  color: shrinkColor(shrinkOffset, Colors.black54),
                  fontSize: 13.sp,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => top + expanded;

  @override
  double get minExtent => top + collapse;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
