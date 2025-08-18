import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 30);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    var secondControlPoint = Offset(size.width - (size.width / 4), size.height);
    var secondPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

///
/// 右侧4阶贝塞尔曲线参见
///
class RightBezierClipper extends CustomClipper<Path> {
  ///
  double offset;

  RightBezierClipper(this.offset);

  @override
  Path getClip(Size size) {
    double width = size.width, height = size.height;
    Path path = Path();
    path.lineTo(0, height);
    path.lineTo(width - offset, height);

    var firstControlPoint = Offset(width - offset / 4, height * 3 / 4);
    var firstPoint = Offset(width - offset / 2, height / 2);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    var secondControlPoint = Offset(width - offset * 3 / 4, height / 4);
    var secondPoint = Offset(width, 0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(0, 0);
    path.close();

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class TopLeftClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path()
      ..lineTo(0, 0)
      ..lineTo(8, 4)
      ..lineTo(8, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class RightOvalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path()
      ..moveTo(size.width - 4, 0)
      ..arcToPoint(
        Offset(size.width, 4),
        radius: const Radius.circular(4),
        clockwise: false,
      )
      ..lineTo(size.width, size.height - 4)
      ..arcToPoint(
        Offset(size.width - 4, size.height),
        radius: const Radius.circular(4),
        clockwise: false,
      )
      ..lineTo(0, size.height)
      ..lineTo(0, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class LeftOvalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path()
      ..moveTo(4, 0)
      ..arcToPoint(
        const Offset(0, 4),
        radius: const Radius.circular(4),
      )
      ..lineTo(0, size.height - 4)
      ..arcToPoint(
        Offset(4, size.height),
        radius: const Radius.circular(4),
      )
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class TopOvalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path()
      ..moveTo(0, 4)
      ..arcToPoint(
        const Offset(4, 0),
        radius: const Radius.circular(4),
        clockwise: false,
      )
      ..lineTo(size.width - 4, 0)
      ..arcToPoint(
        Offset(size.width, 4),
        radius: const Radius.circular(4),
        clockwise: false,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class BottomOvalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path()
      ..moveTo(0, size.height - 4)
      ..arcToPoint(
        Offset(4, size.height),
        radius: const Radius.circular(4),
      )
      ..lineTo(size.width - 4, size.height)
      ..arcToPoint(
        Offset(size.width, size.height - 4),
        radius: const Radius.circular(4),
      )
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class RightClipper extends CustomClipper<Path> {
  ///
  ///
  final double clip;

  RightClipper(this.clip);

  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(size.width, 0)
      ..lineTo(size.width - clip, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, 0)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class LeftClipper extends CustomClipper<Path> {
  ///
  ///
  final double clip;

  LeftClipper(this.clip);

  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(0, size.height)
      ..lineTo(clip, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class MemberClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(size.width / 2, 15.w, size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> old) => true;
}
