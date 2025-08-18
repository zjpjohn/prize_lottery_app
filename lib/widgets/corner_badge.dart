import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';

class CornerBadge extends StatelessWidget {
  const CornerBadge({
    super.key,
    required this.badge,
    required this.size,
    this.radius = BorderRadius.zero,
    this.color = Colors.white,
    this.position = BadgePosition.topStart,
    this.background = const Color(0xFFFF0045),
  });

  final String badge;
  final Color color;
  final Color background;
  final double size;
  final BadgePosition position;
  final BorderRadius radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: radius,
      child: Container(
        width: size,
        height: size,
        foregroundDecoration: RotatedCornerDecoration.withColor(
          color: background,
          spanBaselineShift: 2.w,
          badgeCornerRadius: Radius.zero,
          badgeSize: Size(size, size),
          badgePosition: position,
          textSpan: TextSpan(
            text: badge,
            style: TextStyle(
              color: color,
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
