import 'package:flutter/material.dart';

class ImagePlaceholder extends StatelessWidget {
  ///
  ///
  const ImagePlaceholder({
    super.key,
    this.fontSize = 23,
    this.radius = 8.0,
  });

  ///
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
          '哇彩推荐',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
            color: Colors.white.withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }
}
