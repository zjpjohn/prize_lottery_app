import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum BallType { red, blue }

class Ball extends StatelessWidget {
  final String ball;
  final BallType type;

  const Ball({
    super.key,
    required this.ball,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28.w,
      height: 28.w,
      margin: EdgeInsets.only(right: 8.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: type == BallType.red
            ? const Color(0xFFFF1139)
            : const Color(0xFF0081FF),
      ),
      child: Text(
        ball,
        style: TextStyle(
          fontSize: 14.sp,
          color: Colors.white,
        ),
      ),
    );
  }
}
