import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/model/stat_hit_value.dart';
import 'package:prize_lottery_app/views/master/widgets/master_rank_card.dart';
import 'package:prize_lottery_app/views/rank/model/master_mul_rank.dart';

class MultipleMasterRank {
  late MasterMulRank rank;
  late StatHitValue hit;

  MultipleMasterRank({
    required this.rank,
    required this.hit,
  });
}

List<Widget> rankCards(String detailPrefix, List<MultipleMasterRank> ranks) {
  List<Widget> cards = [
    SizedBox(
      width: 340.w,
      height: 130.w,
    ),
  ];
  for (int i = ranks.length; i >= 1; i--) {
    MultipleMasterRank data = ranks[i - 1];
    Widget card = MasterRankCard(
      master: data.rank.master,
      rank: data.rank.rank,
      achieve: data.hit.count,
      width: 80.w,
      onTap: () {
        Get.toNamed('$detailPrefix${data.rank.master.masterId}');
      },
    );
    if (i % 2 == 0) {
      cards.add(
        Positioned(
          top: (i ~/ 2) * 6.w,
          left: 170.w - (40.w + 64.w * (i ~/ 2)),
          child: card,
        ),
      );
    } else {
      cards.add(
        Positioned(
          top: (i ~/ 2) * 6.w,
          right: 170.w - (40.w + 64.w * (i ~/ 2)),
          child: card,
        ),
      );
    }
  }
  return cards;
}

class MultipleRbRankPanel extends StatelessWidget {
  const MultipleRbRankPanel({
    super.key,
    required this.ranks,
    required this.moreRed,
    required this.moreBlue,
    required this.detailPrefix,
  });

  final List<MultipleMasterRank> ranks;
  final GestureTapCallback moreRed;
  final GestureTapCallback moreBlue;
  final String detailPrefix;

  @override
  Widget build(BuildContext context) {
    if (ranks.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      color: Colors.white,
      padding:
          EdgeInsets.only(left: 16.w, right: 16.w, top: 24.w, bottom: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: rankCards(detailPrefix, ranks),
          ),
          Padding(
            padding: EdgeInsets.only(top: 6.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: moreRed,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.w),
                      border: Border.all(
                        color: const Color(0xFFFF1139),
                        width: 0.8.w,
                      ),
                    ),
                    child: Text(
                      '查看红球排行榜',
                      style: TextStyle(
                        color: const Color(0xFFFF1139),
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                GestureDetector(
                  onTap: moreBlue,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.w),
                      border: Border.all(
                        color: const Color(0xFF0081FF),
                        width: 0.8.w,
                      ),
                    ),
                    child: Text(
                      '查看蓝球排行榜',
                      style: TextStyle(
                        color: const Color(0xFF0081FF),
                        fontSize: 12.sp,
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

class MultipleRankPanel extends StatelessWidget {
  ///
  const MultipleRankPanel({
    super.key,
    required this.ranks,
    required this.moreAction,
    required this.detailPrefix,
  });

  final List<MultipleMasterRank> ranks;
  final GestureTapCallback moreAction;
  final String detailPrefix;

  @override
  Widget build(BuildContext context) {
    if (ranks.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      color: Colors.white,
      padding:
          EdgeInsets.only(left: 16.w, right: 16.w, top: 24.w, bottom: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: rankCards(detailPrefix, ranks),
          ),
          GestureDetector(
            onTap: moreAction,
            behavior: HitTestBehavior.opaque,
            child: Container(
              margin: EdgeInsets.only(top: 4.w),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.w),
                border: Border.all(
                  color: Colors.green,
                  width: 0.8.w,
                ),
              ),
              child: Text(
                '查看完整综合榜单',
                style: TextStyle(color: Colors.green.shade500, fontSize: 12.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
