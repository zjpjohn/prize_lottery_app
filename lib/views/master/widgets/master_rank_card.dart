import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/base/model/master_value.dart';
import 'package:prize_lottery_app/resources/colors.dart';
import 'package:prize_lottery_app/utils/constants.dart';
import 'package:prize_lottery_app/utils/tools.dart';
import 'package:prize_lottery_app/widgets/cached_avatar.dart';

class MasterRankCard extends StatelessWidget {
  ///
  ///
  const MasterRankCard({
    super.key,
    required this.master,
    required this.rank,
    required this.achieve,
    required this.width,
    required this.onTap,
  });

  final MasterValue master;
  final int rank;
  final String achieve;
  final double width;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.w),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFF6F6F6),
              blurRadius: 4.w,
              offset: Offset(3.w, 3.w),
            ),
            BoxShadow(
              color: const Color(0xFFF6F6F6),
              blurRadius: 4.w,
              offset: Offset(-3.w, 3.w),
            ),
            BoxShadow(
              color: const Color(0xFFF6F6F6),
              blurRadius: 4.w,
              offset: Offset(-3.w, -3.w),
            ),
            BoxShadow(
              color: const Color(0xFFF6F6F6),
              blurRadius: 4.w,
              offset: Offset(3.w, -3.w),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 4.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(48.w),
                    border: Border.all(
                      color: rank <= 3 ? rankColors[rank]! : rankColors[4]!,
                      width: 2.8.w,
                    ),
                  ),
                  child: CachedAvatar(
                    width: 48.w,
                    height: 48.w,
                    radius: 25.w,
                    url: master.avatar,
                  ),
                ),
                Positioned(
                  left: 12.8.w,
                  bottom: 0.w,
                  child: rank <= 3
                      ? Container(
                          width: 30.w,
                          alignment: Alignment.center,
                          child: Image.asset(
                            crowns[rank]!,
                            width: 26.w,
                            height: 26.w,
                          ),
                        )
                      : Container(
                          width: 30.w,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 2.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFFCBCBCB),
                            borderRadius: BorderRadius.circular(2.w),
                          ),
                          child: Text(
                            'No.$rank',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9.sp,
                            ),
                          ),
                        ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 4.w),
              child: Text(
                Tools.limitText(master.name, 4),
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 12.sp,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 2.w),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 10.sp, color: Colors.black38),
                  children: [
                    const TextSpan(text: '近'),
                    TextSpan(
                      text: achieve,
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                    const TextSpan(text: '期'),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
