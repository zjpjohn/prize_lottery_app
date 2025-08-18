import 'package:flutter/material.dart';

class HeaderClipper extends CustomClipper<Path> {
  late double width;

  HeaderClipper({this.width = 6});

  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(size.width - width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
