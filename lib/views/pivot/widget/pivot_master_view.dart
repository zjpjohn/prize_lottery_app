import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/base/model/stat_hit_value.dart';
import 'package:prize_lottery_app/utils/tools.dart';
import 'package:prize_lottery_app/views/home/widgets/achieve_tag_view.dart';
import 'package:prize_lottery_app/views/home/widgets/master_rank_view.dart';
import 'package:prize_lottery_app/widgets/cached_avatar.dart';

class PivotMasterView extends StatelessWidget {
  const PivotMasterView({
    super.key,
    required this.name,
    required this.avatar,
    required this.rank,
    required this.margin,
    required this.onTap,
    required this.hitValue,
  });

  final String name;
  final String avatar;
  final int rank;
  final EdgeInsets margin;
  final Function onTap;
  final MapEntry<String, StatHitValue> hitValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 72.h,
        margin: margin,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 52.w,
              height: 56.h,
              margin: EdgeInsets.only(right: 8.w),
              child: CachedAvatar(
                width: 52.w,
                height: 56.h,
                url: avatar,
                color: const Color(0xFFF1F1F1),
              ),
            ),
            SizedBox(
              height: 56.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 4.w),
                    width: 90.w,
                    child: Text(
                      Tools.limitText(name, 7),
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        height: 1.1,
                        fontSize: 14.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RankTag(
                        tagColor: TagColor.red,
                        name: hitValue.key,
                        achieve: hitValue.value.count,
                      ),
                      RichText(
                        text: TextSpan(
                          text: '连中',
                          style: TextStyle(
                            color: Colors.brown.shade300,
                            fontSize: 10.sp,
                          ),
                          children: [
                            TextSpan(
                              text: '${hitValue.value.series}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const TextSpan(text: '期'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
