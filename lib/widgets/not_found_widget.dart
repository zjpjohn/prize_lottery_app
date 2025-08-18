import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:prize_lottery_app/resources/resources.dart';

class NotFoundView extends StatelessWidget {
  ///
  ///
  const NotFoundView({
    super.key,
    this.message,
    this.size,
  });

  final String? message;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 4.w),
          child: SizedBox(
            width: 144.w,
            height: 144.w,
            child: Lottie.asset(
              R.notFoundLottie,
              repeat: true,
            ),
          ),
        ),
        Text(
          message ?? '访问的页面不存在',
          style: TextStyle(
            fontSize: 13.sp,
            color: Colors.black26,
          ),
        )
      ],
    );
  }
}
