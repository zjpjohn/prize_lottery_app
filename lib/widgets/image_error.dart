import 'package:flutter/material.dart';
import 'package:prize_lottery_app/resources/colors.dart';

class ImageError extends StatelessWidget {
  ///
  ///
  const ImageError({
    super.key,
    this.fontSize = 23,
    this.radius = 8.0,
  });

  ///
  final double fontSize;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Transform.rotate(
        angle: 0.75,
        child: Text(
          '加载错误',
          style: TextStyle(
            color: lineColor.withValues(alpha: 0.5),
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
