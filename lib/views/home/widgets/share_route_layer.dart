import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/widgets/cached_avatar.dart';

class ShareRouteLayer extends StatelessWidget {
  const ShareRouteLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 40.h),
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Get.toNamed(AppRoutes.invite);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 20.h),
                child: CachedAvatar(
                  width: 260.h,
                  height: 380.h,
                  url: R.shareLayer,
                  fit: BoxFit.fitWidth,
                  color: Colors.transparent,
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: SizedBox(
                  width: 42.h,
                  height: 42.h,
                  child: Container(
                    transform: Matrix4.translationValues(0, -1.h, 0),
                    child: Icon(
                      const IconData(0xe681, fontFamily: 'iconfont'),
                      size: 28.h,
                      color: Colors.white,
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
