import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef EyeSwitchHandle = void Function(bool);

class PasswordEyeView extends StatelessWidget {
  final bool value;
  final EyeSwitchHandle tap;

  const PasswordEyeView({
    super.key,
    required this.value,
    required this.tap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        tap(!value);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 16.w,
        width: 24.w,
        alignment: Alignment.center,
        child: Icon(
          value ? Icons.visibility : Icons.visibility_off,
          size: 16.sp,
          color: Colors.black,
        ),
      ),
    );
  }
}
