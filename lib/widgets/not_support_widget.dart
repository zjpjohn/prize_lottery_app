import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/resources/resources.dart';

class NotSupportView extends StatelessWidget {
  ///
  ///
  const NotSupportView({
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
          child: Image.asset(
            R.notSupport,
            width: size ?? 144.w,
            height: size ?? 144.w,
          ),
        ),
        Text(
          message ?? '研发中，请耐心等待',
          style: TextStyle(
            fontSize: 13.sp,
            color: Colors.black26,
          ),
        )
      ],
    );
  }
}
