import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/routes/names.dart';

class BattleMemberWidget extends StatelessWidget {
  ///
  ///
  const BattleMemberWidget({
    super.key,
    required this.success,
  });

  final GestureTapCallback success;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240.w,
      height: 320.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: Column(
        children: [
          Image.asset(
            R.insufficient,
            width: 200.w,
            height: 200.w,
          ),
          GestureDetector(
            onTap: () {
              Get.offNamed(AppRoutes.member);
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              color: const Color(0xFFF8F8F8),
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                top: 20.w,
                bottom: 12.w,
                left: 20.w,
                right: 20.w,
              ),
              padding: EdgeInsets.only(top: 10.w, bottom: 10.w),
              child: Text(
                '成为会员，加入对战PK',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              '专家PK对战功能仅限于会员用户'
              '，开通会员即可使用专家进行PK对战',
              maxLines: 2,
              style: TextStyle(
                color: Colors.brown.withValues(alpha: 0.3),
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
