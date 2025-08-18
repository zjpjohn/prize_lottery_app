import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/resources/resources.dart';

typedef ErrorCallback = void Function();

class ErrorView extends StatelessWidget {
  final double? width;
  final double? height;
  final String? message;
  final String? subtitle;
  final Color color;
  final ErrorCallback? callback;

  const ErrorView({
    super.key,
    this.width,
    this.height,
    this.message,
    this.subtitle,
    this.color = Colors.black26,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback!();
      },
      child: SizedBox(
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              R.error,
              fit: BoxFit.contain,
              width: width ?? 144.w,
              height: height ?? 144.w,
            ),
            if (message != null)
              Text(
                '$message',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: color,
                ),
              ),
            if (subtitle != null)
              Text(
                '$subtitle',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.black26,
                ),
              )
          ],
        ),
      ),
    );
  }
}
