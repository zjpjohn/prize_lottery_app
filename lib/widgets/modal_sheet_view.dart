import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/utils/constants.dart';

class ModalSheetView extends StatelessWidget {
  const ModalSheetView({
    super.key,
    required this.title,
    required this.height,
    required this.child,
    this.borderRadius = 10,
    this.border = true,
    this.leftTxt,
    this.leftTap,
    this.color,
  });

  final String title;
  final double height;
  final double borderRadius;
  final Widget child;
  final String? leftTxt;
  final Function? leftTap;
  final Color? color;
  final bool border;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color ?? Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(borderRadius.w),
        topRight: Radius.circular(borderRadius.w),
      ),
      child: SizedBox(
        height: height,
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                if (leftTxt != null)
                  Positioned(
                    left: 16.w,
                    top: 2.w,
                    child: GestureDetector(
                      onTap: () {
                        if (leftTap != null) {
                          leftTap!();
                        }
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 14.w),
                        child: Text(
                          leftTxt!,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: const Color(0xFFFF0033),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 14.w),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 17.sp,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Positioned(
                  right: 16.w,
                  top: 8.w,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 50.w,
                      height: 32.w,
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 20.w,
                        height: 20.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(20.w),
                        ),
                        child: Icon(
                          const IconData(0xe606, fontFamily: 'iconfont'),
                          size: 12.sp,
                          color: Colors.orangeAccent,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            if (border) Constants.line,
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
