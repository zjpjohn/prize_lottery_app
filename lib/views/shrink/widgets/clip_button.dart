import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef OnTapHandle = Function(int);

class ClipButton extends StatelessWidget {
  ///
  ///
  const ClipButton({
    super.key,
    required this.text,
    required this.value,
    required this.width,
    required this.height,
    required this.onTap,
    this.selected = false,
    this.disable = false,
    this.fontSize = 13,
    this.margin = 0,
  });

  final String text;
  final int value;
  final double width;
  final double height;
  final bool selected;
  final bool disable;
  final double fontSize;
  final double margin;
  final OnTapHandle onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.only(right: margin),
      child: GestureDetector(
        onTap: () {
          if (disable) {
            return;
          }
          onTap(value);
        },
        child: Stack(
          children: [
            Container(
              height: height,
              alignment: Alignment.center,
              // padding: EdgeInsets.fromLTRB(8.w, 0, 8.w, 0),
              decoration: BoxDecoration(
                color: !disable
                    ? const Color(0xFFF6F6F6)
                    : const Color(0xFFEFEFEF),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: fontSize.sp,
                  color: !disable
                      ? (selected ? const Color(0xFFFF0045) : Colors.black54)
                      : Colors.black26,
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Visibility(
                visible: !disable && selected,
                child: ClipPath(
                  clipper: RightBottomCliper(),
                  child: Container(
                    height: height,
                    width: height,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF0045),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RightBottomCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(size.width, size.height * 2 / 3)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width - size.height / 3, size.height)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
