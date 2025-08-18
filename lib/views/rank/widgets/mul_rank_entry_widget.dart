import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/utils/constants.dart';
import 'package:prize_lottery_app/utils/tools.dart';
import 'package:prize_lottery_app/views/home/widgets/achieve_tag_view.dart';
import 'package:prize_lottery_app/views/rank/model/master_mul_rank.dart';
import 'package:prize_lottery_app/widgets/cached_avatar.dart';
import 'package:prize_lottery_app/widgets/common_widgets.dart';
import 'package:prize_lottery_app/widgets/corner_badge.dart';
import 'package:prize_lottery_app/widgets/tag_mark.dart';

class MulRankEntryWidget extends StatelessWidget {
  ///
  ///
  const MulRankEntryWidget({
    super.key,
    this.border = true,
    this.showAds = false,
    required this.data,
    required this.onTap,
  });

  final bool border;
  final bool showAds;
  final MulMasterRank data;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(top: 14.w, bottom: 16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: border
                          ? BorderSide(
                              width: 0.5.w,
                              color: const Color(0xFFF1F1F1),
                            )
                          : BorderSide.none),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w),
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
                              url: data.rank.master.avatar,
                            ),
                            if (data.rank.vip == 0)
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
                                Tools.limitName(
                                    data.rank.master.name.trim(), 12),
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: const Color(0xFF3C3C3C),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              CommonWidgets.rankView(
                                rank: data.rank.rank,
                                lastRank: data.rank.lastRank,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  TagView(
                                    name: data.rank.hot == 1 ? '热门大牛' : '普通专家',
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 12.w),
                                    child: Text(
                                      '${data.rank.browse}次查看',
                                      style: TextStyle(
                                        color: Colors.black26,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: data.achieves
                                    .map((e) => AchieveTag(
                                          name: e.name,
                                          achieve: e.count,
                                          tagColor: e.color,
                                        ))
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 16.w,
                top: 10.w,
                child: data.rank.rank <= 3
                    ? Container(
                        alignment: Alignment.centerRight,
                        width: 90.w,
                        child: Image.asset(
                          ranks[data.rank.rank]!,
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
                          '${data.rank.rank}',
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

class MulMasterRank {
  ///
  /// 专家排名信息
  late MasterMulRank rank;

  ///
  /// 获得成绩
  late List<AchieveInfo> achieves;

  MulMasterRank({
    required this.rank,
    required this.achieves,
  });
}

class AchieveInfo {
  late String name;
  late String count;
  late TagColor color;

  AchieveInfo({
    required this.name,
    required this.count,
    this.color = TagColor.red,
  });
}
