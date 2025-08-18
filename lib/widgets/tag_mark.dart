import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TagView extends StatelessWidget {
  ///
  final String name;

  const TagView({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 3.w),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(3.0),
        color: const Color(0xFFEE3226).withValues(alpha: 0.08),
      ),
      child: Text(
        name,
        style: TextStyle(
          color: const Color(0xFFEE3226),
          fontSize: 10.sp,
        ),
      ),
    );
  }
}

class OutlineTag extends StatelessWidget {
  final String name;

  const OutlineTag({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: 8.w),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.4.w),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(2.0.w),
        border: Border.all(
          color: const Color(0xFFEE3226).withValues(alpha: 0.1),
          width: 0.6.w,
        ),
      ),
      child: Text(
        name,
        style: TextStyle(
          color: const Color(0xFFEE3226),
          fontSize: 10.sp,
        ),
      ),
    );
  }
}
