import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef OnPickedHandle = Function(String value);

class RadioButton extends StatelessWidget {
  ///
  ///
  const RadioButton({
    super.key,
    required this.text,
    required this.labelColor,
    required this.handle,
    this.label,
    this.size = 44,
    this.fontSize = 14,
    this.radius = 4,
    this.margin,
    this.selected = false,
    this.borderWidth = 0.4,
    this.borderColor = Colors.black12,
  });

  final String text;
  final String? label;
  final double size;
  final double fontSize;
  final Color labelColor;
  final Color borderColor;
  final double borderWidth;
  final double radius;
  final EdgeInsets? margin;
  final bool selected;
  final OnPickedHandle handle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        handle(text);
      },
      child: Container(
        width: size,
        height: size,
        margin: margin,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? labelColor : Colors.white,
          borderRadius: BorderRadius.circular(radius),
          border: selected
              ? const Border()
              : Border.all(color: borderColor, width: borderWidth),
        ),
        child: Text(
          label ?? text,
          style: TextStyle(
            fontSize: fontSize.sp,
            color: selected ? Colors.white : Colors.black54,
          ),
        ),
      ),
    );
  }
}
