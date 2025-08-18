import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/routes/names.dart';

typedef ValueChangeHandle = Function(bool value);

class AgreementView extends StatelessWidget {
  const AgreementView({
    super.key,
    required this.value,
    required this.onHandle,
  });

  ///
  ///是否同意值
  final bool value;

  ///
  ///选择处理
  final ValueChangeHandle onHandle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            onHandle(!value);
          },
          child: Container(
            width: 24.w,
            height: 28.w,
            alignment: Alignment.center,
            child: Image.asset(
              value ? R.checkedIcon : R.uncheckedIcon,
              width: 16.w,
              height: 16.w,
            ),
          ),
        ),
        RichText(
          text: TextSpan(
            style: TextStyle(
              color: Colors.black87,
              fontSize: 12.sp,
            ),
            children: [
              const TextSpan(
                text: '我已阅读并同意',
              ),
              TextSpan(
                text: '《使用协议》',
                style: const TextStyle(
                  color: Colors.blueAccent,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Get.toNamed(AppRoutes.usage);
                  },
              ),
              const TextSpan(
                text: '和',
              ),
              TextSpan(
                text: '《隐私政策》',
                style: const TextStyle(
                  color: Colors.blueAccent,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Get.toNamed(AppRoutes.privacy);
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
