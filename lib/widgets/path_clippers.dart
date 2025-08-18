import 'package:flutter/material.dart';

class LoginBackClipper extends CustomClipper<Path> {
  ///
  /// 是否为左侧
  final bool left;

  ///
  /// 对侧高度偏移
  final double delta;

  LoginBackClipper({
    this.left = true,
    this.delta = 32.0,
  });

  @override
  Path getClip(Size size) {
    var path = Path();
    if (left) {
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height - delta);
      path.lineTo(size.width, 0);
      path.lineTo(0, 0);
    } else {
      path.lineTo(0, size.height - delta);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
      path.lineTo(0, 0);
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class ConcaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 48);

    var firstControlPoint = Offset(size.width / 2, size.height);
    var firstPoint = Offset(size.width, size.height - 48);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstPoint.dx,
      firstPoint.dy,
    );
    path.lineTo(size.width, size.height - 48);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class TopCurveClipper extends CustomClipper<Path> {
  final double height;

  TopCurveClipper({this.height = 8});

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, 0.0);

    var firstControlPoint = Offset(size.width / 2, height);
    var firstPoint = Offset(size.width, 0.0);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstPoint.dx,
      firstPoint.dy,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
