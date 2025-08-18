import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:prize_lottery_app/app/app_controller.dart';
import 'package:prize_lottery_app/resources/resources.dart';

class UpgradeAppSheet extends StatelessWidget {
  const UpgradeAppSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (!didPop && AppController().appInfo!.main.force == 1) {
          EasyLoading.showToast('重要功能更新，请立即升级');
        }
      },
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.w),
          topRight: Radius.circular(16.w),
        ),
        child: SizedBox(
          height: 320.w,
          child: GetBuilder<AppController>(builder: (controller) {
            return Stack(
              children: [
                _buildUpgradeContent(controller),
                Positioned(
                  top: 14.w,
                  right: 12.w,
                  child: GestureDetector(
                    onTap: () {
                      if (controller.appInfo!.main.force == 1) {
                        EasyLoading.showToast('重要功能更新，请立即升级');
                        controller.upgrade();
                        return;
                      }
                      Get.back();
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 24.w,
                      height: 24.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(22.w),
                      ),
                      child: Icon(
                        const IconData(0xe66a, fontFamily: 'iconfont'),
                        size: 14.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildUpgradeContent(AppController controller) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 120.w,
            height: 120.w,
            child: Lottie.asset(
              R.upgradeLottie,
              repeat: true,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.w, bottom: 8.w),
            child: Text(
              '发现新版本啦!',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            '使用最新版本，获得更好的应用体验',
            style: TextStyle(
              color: Colors.black45,
              fontSize: 15.sp,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 24.w),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (controller.appInfo!.main.force == 1) {
                        EasyLoading.showToast('重要功能更新，请立即升级');
                        return;
                      }
                      Get.back();
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 10.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6F6F6),
                        borderRadius: BorderRadius.circular(6.w),
                      ),
                      child: Text(
                        '以后再说',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: const Color(0xBB000000),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.upgrade();
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 10.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF0045),
                        borderRadius: BorderRadius.circular(6.w),
                      ),
                      child: Text(
                        '立即升级',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
