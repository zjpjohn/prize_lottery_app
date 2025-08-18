import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/routes/names.dart';

class MemberHintWidget extends StatelessWidget {
  const MemberHintWidget({
    super.key,
    required this.width,
    required this.height,
    required this.period,
    required this.name,
  });

  final double width;
  final double height;
  final String period;
  final String name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.offNamed(AppRoutes.member);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white54,
              Colors.white70,
              Color(0xC9FFFFFF),
              Colors.white,
              Colors.white
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 6.w),
              child: Text(
                '无权查看$period期$name',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFFF0033),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 12.w),
              child: Text(
                '温馨提示：$name功能仅限于会员用户使用',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xFFFF0033),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.w),
              margin: EdgeInsets.symmetric(horizontal: 28.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFFF0045),
                borderRadius: BorderRadius.circular(30.w),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF0045).withValues(alpha: 0.3),
                    offset: const Offset(4, 4),
                    blurRadius: 6,
                    spreadRadius: 0.0,
                  )
                ],
              ),
              child: Text(
                '领取会员',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
