import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/widgets/path_clippers.dart';

class LoginBackground extends StatelessWidget {
  ///
  ///
  const LoginBackground({
    super.key,
    required this.title,
    required this.data,
  });

  ///
  ///
  final String title;

  ///
  ///
  final IconData data;

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final deviceSize = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: deviceSize.height * 0.45,
          child: Stack(
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: LoginBackClipper(left: false, delta: 96.w),
                    child: Container(
                      color: const Color(0xFFF6DBC8),
                    ),
                  ),
                  ClipPath(
                    clipper: LoginBackClipper(delta: 96.w),
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFE6D1C0),
                            Color(0xFFD8B28E),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: statusBarHeight),
                height: 44.w + statusBarHeight,
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 16.w),
                          child: Icon(
                            data,
                            size: 18.w,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.white,
                            ),
                          ),
                        )),
                    Expanded(flex: 1, child: Container()),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
