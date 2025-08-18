import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/resources/colors.dart';
import 'package:prize_lottery_app/utils/constants.dart';
import 'package:prize_lottery_app/widgets/cached_avatar.dart';

class RankAvatar extends StatelessWidget {
  ///
  ///
  const RankAvatar({
    super.key,
    required this.avatar,
    required this.rank,
    required this.size,
  });

  final int rank;
  final String avatar;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 2.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size),
            border: Border.all(
              color: rank <= 3 ? rankColors[rank]! : rankColors[4]!,
              width: 2.8.w,
            ),
          ),
          child: CachedAvatar(
            width: size,
            height: size,
            radius: size,
            url: avatar,
          ),
        ),
        rank <= 3
            ? Positioned(
                left: (size - 26.w) / 2 + 2.8.w,
                bottom: 0,
                child: Image.asset(
                  crowns[rank]!,
                  width: 26.w,
                  height: 26.w,
                ),
              )
            : Positioned(
                left: (size - 30.w) / 2 + 2.8.w,
                bottom: 0,
                child: Container(
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
    );
  }
}
