import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum Type { red, blue }

class AchieveMark extends StatelessWidget {
  ///
  final String name;

  ///
  final String achieve;

  ///
  final Type type;

  const AchieveMark({
    super.key,
    required this.name,
    required this.achieve,
    this.type = Type.red,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        border: Border.all(
          color: const Color(0xFFF8F8F8),
          width: 0.4.w,
        ),
        borderRadius: BorderRadius.circular(2.w),
      ),
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.w),
      child: Text(
        '$name·$achieve',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 11.sp,
        ),
      ),
    );
  }
}
