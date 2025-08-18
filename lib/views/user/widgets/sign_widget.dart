import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignCard extends StatelessWidget {
  ///卡片标题
  final String title;

  ///是否已经签到
  final bool hasSigned;

  //当前标识
  final int index;

  //连续门槛
  final int throttle;

  const SignCard({
    super.key,
    required this.title,
    required this.hasSigned,
    required this.index,
    required this.throttle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38.w,
      height: 48.h,
      padding: EdgeInsets.fromLTRB(4.w, 2.w, 4.w, 6.w),
      decoration: BoxDecoration(
        color: hasSigned ? const Color(0xFFFF0033) : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(3.w),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: hasSigned ? Colors.white : Colors.black38,
              fontSize: 13.sp,
            ),
          ),
          _getMarkInfo(),
        ],
      ),
    );
  }

  Widget _getMarkInfo() {
    if (hasSigned) {
      return Icon(
        const IconData(0xe65b, fontFamily: 'iconfont'),
        color: index == throttle ? const Color(0xFFFFC90E) : Colors.white,
        size: 18.sp,
      );
    }
    return Icon(
      const IconData(0xe65b, fontFamily: 'iconfont'),
      color: index == throttle ? const Color(0xFFFF0033) : Colors.black12,
      size: 18.sp,
    );
  }
}
