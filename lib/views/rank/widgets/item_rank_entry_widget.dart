import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/utils/constants.dart';
import 'package:prize_lottery_app/utils/tools.dart';
import 'package:prize_lottery_app/views/rank/model/master_item_rank.dart';
import 'package:prize_lottery_app/widgets/cached_avatar.dart';
import 'package:prize_lottery_app/widgets/common_widgets.dart';
import 'package:prize_lottery_app/widgets/corner_badge.dart';
import 'package:prize_lottery_app/widgets/tag_mark.dart';

class ItemRankEntryWidget extends StatelessWidget {
  const ItemRankEntryWidget({
    super.key,
    this.border = true,
    this.radius = false,
    this.showAds = false,
    required this.data,
    required this.onTap,
  });

  final bool border;
  final bool radius;
  final bool showAds;
  final MasterItemRank data;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(top: 14.w),
                margin: EdgeInsets.only(left: 10.w, right: 10.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: radius
                      ? BorderRadius.only(
                          topLeft: Radius.circular(6.w),
                          topRight: Radius.circular(6.w))
                      : BorderRadius.zero,
                ),
                child: Container(
                  padding: EdgeInsets.only(bottom: 16.w),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: border
                            ? BorderSide(
                                color: const Color(0xFFF1F1F1), width: 0.5.w)
                            : BorderSide.none),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.w, right: 12.w),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 12.w),
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(top: 2.w),
                          child: Stack(
                            children: [
                              CachedAvatar(
                                width: 82.w,
                                height: 100.w,
                                radius: 4.w,
                                url: data.master.avatar,
                              ),
                              if (data.vip == 0)
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: CornerBadge(
                                    badge: '免费',
                                    size: 32.w,
                                    color: Colors.redAccent,
                                    radius: BorderRadius.only(
                                      topLeft: Radius.circular(4.w),
                                    ),
                                    background: Colors.grey.shade200,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 100.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  Tools.limitName(data.master.name, 10),
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: const Color(0xFF3C3C3C),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                CommonWidgets.rankView(
                                  rank: data.rank,
                                  lastRank: data.lastRank,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    TagView(
                                        name: data.hot == 1 ? '热门大牛' : '普通专家'),
                                    Padding(
                                      padding: EdgeInsets.only(right: 12.w),
                                      child: Text(
                                        '${data.browse}次查看',
                                        style: TextStyle(
                                          color: Colors.black26,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            color: Colors.black38),
                                        children: [
                                          const TextSpan(text: '近'),
                                          TextSpan(
                                            text: data.rate.count,
                                            style: const TextStyle(
                                                color: Colors.redAccent),
                                          ),
                                          const TextSpan(text: '期'),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 12.w),
                                      child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                              fontSize: 13.sp,
                                              color: Colors.black38),
                                          children: [
                                            const TextSpan(text: '连红'),
                                            TextSpan(
                                              text: '${data.rate.series}',
                                              style: const TextStyle(
                                                  color: Colors.redAccent),
                                            ),
                                            const TextSpan(text: '期'),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 12.w),
                                      child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                              fontSize: 13.sp,
                                              color: Colors.black38),
                                          children: [
                                            const TextSpan(text: '命中率'),
                                            TextSpan(
                                              text:
                                                  '${(data.rate.rate * 100).toInt()}%',
                                              style: TextStyle(
                                                color: Colors.redAccent,
                                                fontFamily: 'bebas',
                                                fontSize: 11.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 16.w,
                top: 10.w,
                child: data.rank <= 3
                    ? Container(
                        alignment: Alignment.centerRight,
                        width: 90.w,
                        child: Image.asset(
                          ranks[data.rank]!,
                          width: 26.w,
                          height: 26.w,
                        ),
                      )
                    : Container(
                        width: 90.w,
                        height: 24.w,
                        padding: EdgeInsets.only(right: 4.w),
                        alignment: Alignment.centerRight,
                        child: Text(
                          '${data.rank}',
                          style: TextStyle(
                            color: const Color(0xFFC98E00),
                            fontSize: 18.sp,
                            fontFamily: 'bebas',
                          ),
                        ),
                      ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
