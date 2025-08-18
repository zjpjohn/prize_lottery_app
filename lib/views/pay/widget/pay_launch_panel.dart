import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/app/app_controller.dart';
import 'package:prize_lottery_app/widgets/cached_avatar.dart';

typedef PayCallback = Function(String channel);

class PayContactPanel extends StatelessWidget {
  const PayContactPanel({
    super.key,
    required this.title,
    required this.amount,
  });

  final String title;
  final int amount;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {},
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.w),
          topRight: Radius.circular(10.w),
        ),
        child: SizedBox(
          height: Get.height * 0.5,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  height: 40.w,
                  padding: EdgeInsets.only(left: 16.w),
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    height: 32.w,
                    width: 50.w,
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 22.w,
                      height: 22.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20.w),
                      ),
                      child: Icon(
                        const IconData(0xe606, fontFamily: 'iconfont'),
                        size: 13.sp,
                        color: const Color(0xFFFF0045),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 16.w),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 4.w),
                          child: Text(
                            '¥',
                            style: TextStyle(
                              fontSize: 26.sp,
                              fontFamily: 'bebas',
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          (amount / 100).toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: 26.sp,
                            fontFamily: 'bebas',
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 12.w),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16.w, bottom: 8.w),
                      child: Text(
                        '请联系管理员后台手动开通会员服务',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                    if (AppController().contacts.isNotEmpty)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: AppController()
                              .contacts
                              .map((e) => Container(
                                    margin: EdgeInsets.only(left: 16.sp),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 4.w),
                                          child: Text(
                                            e.name,
                                            style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 13.sp,
                                            ),
                                          ),
                                        ),
                                        CachedAvatar(
                                          width: 116.w,
                                          height: 160.w,
                                          fit: BoxFit.fitHeight,
                                          color: Color(0xFFF6F6F6),
                                          url: e.qrImg,
                                        ),
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
