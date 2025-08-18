import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:prize_lottery_app/resources/resources.dart';

class LoadingView extends StatelessWidget {
  final double? width;
  final double? height;

  const LoadingView({
    super.key,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 88.w,
      height: height ?? 88.w,
      child: Lottie.asset(
        R.loadingLottie,
        repeat: true,
      ),
    );
  }
}
