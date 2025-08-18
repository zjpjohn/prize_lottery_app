import 'dart:math';

import 'package:flutter/material.dart';

class DiamondWidget extends StatelessWidget {
  const DiamondWidget({
    super.key,
    required this.width,
    required this.height,
    required this.color,
    required this.child,
    this.margin = 0.0,
    this.border = 0.0,
    this.borderColor = Colors.transparent,
  });

  final double width;
  final double height;
  final Color color;
  final Widget child;
  final double border;
  final double margin;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: DiamondClipper(),
      child: Container(
        width: width,
        height: height,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              top: margin,
              left: margin,
              child: ClipPath(
                clipper: DiamondClipper(),
                child: Container(
                  color: color,
                  width: width - margin,
                  height: height - margin,
                ),
              ),
            ),
            Positioned(
              top: margin,
              left: margin,
              width: width - margin,
              height: height - margin,
              child: CustomPaint(
                size: Size(width - margin, height - margin),
                foregroundPainter:
                    DiamondBorder(border: border, color: borderColor),
                child: Align(
                  alignment: Alignment.center,
                  child: child,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DiamondClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    double crop = 0.5 * width * tan(pi / 6);
    return Path()
      ..moveTo(0, crop)
      ..lineTo(0, height - crop)
      ..lineTo(width / 2, height)
      ..lineTo(width, height - crop)
      ..lineTo(width, crop)
      ..lineTo(width / 2, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class DiamondBorder extends CustomPainter {
  ///
  /// 边框宽度
  final double border;

  ///边框颜色
  final Color color;

  DiamondBorder({required this.border, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (border == 0) {
      return;
    }
    double delta = border / 2;
    double width = size.width - delta;
    double height = size.height - delta;
    double crop = 0.5 * width * tan(pi / 6);
    final Paint paint = Paint()
      ..isAntiAlias = true
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt
      ..strokeWidth = border;
    canvas.drawLine(
      Offset(width / 2, 0),
      Offset(delta, crop),
      paint,
    );
    canvas.drawLine(
      Offset(delta, crop),
      Offset(delta, height - crop),
      paint,
    );
    canvas.drawLine(
      Offset(delta, height - crop),
      Offset(width / 2, height),
      paint,
    );
    canvas.drawLine(
      Offset(width / 2, height),
      Offset(width, height - crop),
      paint,
    );
    canvas.drawLine(
      Offset(width, height - crop),
      Offset(width, crop),
      paint,
    );
    canvas.drawLine(
      Offset(width, crop),
      Offset(width / 2, 0),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
