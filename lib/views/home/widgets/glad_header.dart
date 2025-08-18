import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GladHeader extends StatelessWidget {
  const GladHeader({
    super.key,
    required this.colors,
  });

  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 2,
          bottom: 1,
          child: Container(
            width: 58.w,
            height: 4.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.w),
                bottomLeft: Radius.circular(5.w),
              ),
              gradient: LinearGradient(
                colors: colors
                    .map((color) => color.withValues(alpha: 0.25))
                    .toList(),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 2.w),
          child: Text(
            '推荐中奖',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
