import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageHintView extends StatelessWidget {
  ///
  ///
  const MessageHintView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 2.w),
          child: Icon(
            const IconData(0xe672, fontFamily: 'iconfont'),
            color: Colors.black,
            size: 20.sp,
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            width: 7.w,
            height: 7.w,
            decoration: BoxDecoration(
              color: const Color(0xFFFF0033),
              borderRadius: BorderRadius.circular(4.w),
            ),
          ),
        ),
      ],
    );
  }
}
