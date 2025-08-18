import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TagColor { red, blue }

class AchieveTag extends StatelessWidget {
  final String name;
  final String achieve;
  final TagColor tagColor;

  const AchieveTag({
    super.key,
    required this.name,
    required this.achieve,
    this.tagColor = TagColor.red,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: tagColor == TagColor.red
              ? const Color(0xFFEE3226).withValues(alpha: 0.12)
              : Colors.blueAccent.withValues(alpha: 0.12),
          width: 0.5.w,
        ),
        borderRadius: BorderRadius.circular(2.w),
      ),
      child: Row(
        children: [
          Container(
            color: tagColor == TagColor.red
                ? const Color(0xFFEE3226).withValues(alpha: 0.08)
                : Colors.blueAccent.withValues(alpha: 0.08),
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.w),
            child: Text(
              name,
              style: TextStyle(
                color: tagColor == TagColor.red
                    ? const Color(0xFFEE3226)
                    : Colors.blueAccent,
                fontSize: 10.sp,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.w),
            child: Text(
              achieve,
              style: TextStyle(
                color: tagColor == TagColor.red
                    ? const Color(0xFFEE3226)
                    : Colors.blueAccent,
                fontSize: 10.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
