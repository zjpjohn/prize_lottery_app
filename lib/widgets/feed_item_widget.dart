import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/utils/date_util.dart';
import 'package:prize_lottery_app/utils/tools.dart';
import 'package:prize_lottery_app/widgets/cached_avatar.dart';

class FeedItemWidget extends StatelessWidget {
  ///
  const FeedItemWidget({
    super.key,
    required this.title,
    required this.delta,
    required this.header,
    required this.browse,
    required this.onTap,
    this.border = true,
    this.showAds = false,
  });

  final String title;
  final TimeDelta delta;
  final String header;
  final int browse;
  final bool border;
  final bool showAds;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white, width: 0.0),
      ),
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: border
                  ? BorderSide(color: Colors.black26, width: 0.2.w)
                  : BorderSide.none,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 12.w),
                  height: 80.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 15.5.sp,
                          color: Colors.black87,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 16.w),
                            child: Text(
                              '${delta.time}${delta.text}',
                              style: TextStyle(
                                color: Colors.black26,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: '${Tools.randLimit(browse, 100)}',
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 12.sp,
                              ),
                              children: [
                                TextSpan(
                                  text: '阅读',
                                  style: TextStyle(
                                    color: Colors.black26,
                                    fontSize: 11.sp,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              CachedAvatar(
                width: 132.w,
                height: 80.w,
                url: header.isNotEmpty
                    ? '$header?x-oss-process=image/resize,w_165'
                    : '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
