import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Map<int, int> dayIcons = {
  1: 0xe601,
  2: 0xe602,
  3: 0xe608,
  4: 0xe604,
  5: 0xe609,
  6: 0xe61a,
  7: 0xe60b,
  8: 0xe60e,
  9: 0xe610,
  10: 0xe614,
  11: 0xe60f,
  12: 0xe611,
  13: 0xe615,
  14: 0xe619,
  15: 0xe61b,
  16: 0xe61f,
  17: 0xe61c,
  18: 0xe622,
  19: 0xe623,
  20: 0xe625,
  21: 0xe624,
  22: 0xe627,
  23: 0xe62a,
  24: 0xe626,
  25: 0xe628,
  26: 0xe62d,
  27: 0xe62c,
  28: 0xe630,
  29: 0xe62e,
  30: 0xe632,
  31: 0xe631,
};

class CalendarButton extends StatelessWidget {
  ///日期
  final int day;

  ///点击回调
  final Function handle;

  const CalendarButton({
    super.key,
    required this.day,
    required this.handle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        handle();
      },
      child: Container(
        padding: EdgeInsets.only(left: 2.w, top: 2.w, bottom: 2.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF6F6F6),
          borderRadius: BorderRadius.circular(16.w),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 25.w,
              width: 25.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFFF0033).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(16.w),
              ),
              child: Padding(
                padding: EdgeInsets.only(bottom: 2.w),
                child: Icon(
                  IconData(dayIcons[day]!, fontFamily: 'iconfont'),
                  size: 16.w,
                  color: const Color(0xFFFF0033),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 6.w, right: 8.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '开奖日历',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.black87,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 2.w),
                    child: Icon(
                      const IconData(0xe653, fontFamily: 'iconfont'),
                      size: 12.w,
                      color: Colors.black12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
