import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/resources/colors.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/utils/tools.dart';
import 'package:prize_lottery_app/views/rank/model/master_item_rank.dart';
import 'package:prize_lottery_app/views/user/controller/user_center_controller.dart';

class MasterRecommendView extends StatelessWidget {
  ///
  const MasterRecommendView({
    super.key,
    this.marginLeft = 0.0,
    required this.recommend,
  });

  final double marginLeft;
  final MasterRankRecommend recommend;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.6,
      margin: EdgeInsets.only(left: marginLeft, right: 10.w, top: 10.w),
      padding: EdgeInsets.only(bottom: 8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.w),
        border: Border.all(color: const Color(0xFFC9C9C9), width: 0.08),
      ),
      child: Stack(
        children: [
          Container(
            height: 44.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(6.w),
                topRight: Radius.circular(6.w),
              ),
              image: const DecorationImage(
                opacity: 0.6,
                image: AssetImage(R.recHeaderBg),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              _buildRankHeader(recommend),
              ..._buildRecommendList(recommend),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildRankHeader(MasterRankRecommend recommend) {
    return Container(
      padding: EdgeInsets.only(left: 12.w, top: 14.w, bottom: 14.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(6.w),
          topRight: Radius.circular(6.w),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            recommend.name,
            style: TextStyle(
              fontSize: 16.sp,
              color: const Color(0xFF896a45),
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.w, bottom: 2.w),
            child: Text(
              '专家推荐榜',
              style: TextStyle(
                color: const Color(0xFF896a45),
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildRecommendList(MasterRankRecommend recommend) {
    List<Widget> views = [];
    List<MasterItemRank> ranks = recommend.ranks;
    for (int i = 0; i < ranks.length; i++) {
      views.add(_buildItemRank(recommend.type, ranks[i], i < ranks.length - 1));
    }
    return views;
  }

  Widget _buildItemRank(String type, MasterItemRank rank, bool bordered) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/$type/master/${rank.master.masterId}');
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: bordered
                ? BorderSide(color: Colors.black12, width: 0.15.w)
                : BorderSide.none,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 13.5.w,
                  height: 13.5.w,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 6.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.w),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.bottomCenter,
                      colors: [
                        itemRankColors[rank.rank <= 4 ? rank.rank : 4]!
                            .withValues(alpha: 0.8),
                        itemRankColors[rank.rank <= 4 ? rank.rank : 4]!,
                      ],
                    ),
                  ),
                  child: Text(
                    '${rank.rank}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9.sp,
                      fontFamily: 'bebas',
                      height: 1.2,
                    ),
                  ),
                ),
                Text(
                  Tools.limitText(rank.master.name, 7),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            _rankView(rank.rank, rank.lastRank),
          ],
        ),
      ),
    );
  }

  Widget _rankView(int rank, int lastRank) {
    int delta = rank - lastRank;
    if (lastRank == 0 || delta == 0) {
      return Container(
        height: 18.w,
        padding: EdgeInsets.only(right: 12.w),
        child: Text(
          '-',
          style: TextStyle(
            color: Colors.black26,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }
    if (delta > 0) {
      return Container(
        height: 18.w,
        padding: EdgeInsets.only(right: 10.w),
        child: Text(
          '↓',
          style: TextStyle(
            color: const Color(0xFFEE3226),
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }
    return Container(
      height: 18.w,
      padding: EdgeInsets.only(right: 10.w),
      child: Text(
        '↑',
        style: TextStyle(
          color: const Color(0xFF25D489),
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
