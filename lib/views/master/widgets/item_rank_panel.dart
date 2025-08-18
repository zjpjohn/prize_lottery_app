import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/resources/colors.dart';
import 'package:prize_lottery_app/views/master/model/home_master.dart';
import 'package:prize_lottery_app/widgets/rank_avatar.dart';

class ItemRankPanel extends StatelessWidget {
  ///
  const ItemRankPanel({
    super.key,
    required this.channel,
    required this.masters,
    required this.detailPrefix,
    required this.rankPrefix,
  });

  final String channel;
  final List<HomeMaster> masters;
  final String detailPrefix;
  final String rankPrefix;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(bottom: 12.w),
      child: Column(
        children: [
          ...masters.map((e) => _buildItemRankCard(e)),
          _buildMoreBtnView(),
        ],
      ),
    );
  }

  Widget _buildItemRankCard(HomeMaster data) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          '$detailPrefix${data.master.masterId}',
          parameters: {'channel': channel},
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.bottomCenter,
            colors: [
              rankColors[data.rank <= 4 ? data.rank : 4]!
                  .withValues(alpha: 0.2),
              rankColors[data.rank <= 4 ? data.rank : 4]!
                  .withValues(alpha: 0.02),
            ],
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: RankAvatar(
                avatar: data.master.avatar,
                rank: data.rank,
                size: 46.w,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 12.w),
                  child: Text(
                    data.master.name,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        style:
                            TextStyle(fontSize: 13.sp, color: Colors.black38),
                        children: [
                          const TextSpan(text: '近'),
                          TextSpan(
                            text: data.rate.count,
                            style: const TextStyle(color: Colors.redAccent),
                          ),
                          const TextSpan(text: '期'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12.w),
                      child: RichText(
                        text: TextSpan(
                          style:
                              TextStyle(fontSize: 13.sp, color: Colors.black38),
                          children: [
                            const TextSpan(text: '连红'),
                            TextSpan(
                              text: '${data.rate.series}',
                              style: const TextStyle(color: Colors.redAccent),
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
                          style:
                              TextStyle(fontSize: 13.sp, color: Colors.black38),
                          children: [
                            const TextSpan(text: '命中率'),
                            TextSpan(
                              text: '${(data.rate.rate * 100).toInt()}%',
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
          ],
        ),
      ),
    );
  }

  Widget _buildMoreBtnView() {
    return GestureDetector(
      onTap: () {
        Get.toNamed('$rankPrefix$channel');
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 20.w, bottom: 8.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '查看更多推荐',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.brown,
              ),
            ),
            Icon(
              const IconData(0xe636, fontFamily: 'iconfont'),
              size: 14.sp,
              color: Colors.brown,
            )
          ],
        ),
      ),
    );
  }
}
