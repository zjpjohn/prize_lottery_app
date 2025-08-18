import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LotteryHintWidget extends StatelessWidget {
  ///
  const LotteryHintWidget({
    super.key,
    required this.hint,
  });

  final String hint;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 1.w, right: 2.w),
          child: Icon(
            const IconData(0xe63d, fontFamily: 'iconfont'),
            size: 11.sp,
            color: const Color(0xFFD2B48C).withValues(alpha: 0.5),
          ),
        ),
        Text(
          hint,
          style: TextStyle(
            color: Colors.black26,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}
