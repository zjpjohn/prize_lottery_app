import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/utils/tools.dart';
import 'package:prize_lottery_app/views/rank/model/master_item_rank.dart';
import 'package:prize_lottery_app/widgets/card_banner_swiper.dart';

typedef BannerTapCallback = void Function(MasterItemRank);

class RecommendBannerSwiper extends StatelessWidget {
  const RecommendBannerSwiper({
    super.key,
    required this.ranks,
    required this.onTap,
    required this.width,
    required this.height,
    required this.duration,
  }) : assert(ranks.length >= 4);

  final double width;
  final double height;
  final int duration;
  final List<MasterItemRank> ranks;
  final BannerTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 12.w),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        padding: EdgeInsets.only(
          left: 10.w,
          right: 10,
          top: 12.w,
          bottom: 20.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10.w),
              child: Stack(
                children: [
                  Positioned(
                    left: 2,
                    bottom: 0.2,
                    child: Container(
                      width: 60.w,
                      height: 4.w,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.grey.withValues(alpha: 0.5),
                            Colors.grey.withValues(alpha: 0.5),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '精选大师推荐',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
            ),
            CardBannerSwiper<MasterItemRank>(
              datas: ranks,
              width: width,
              height: height,
              duration: duration,
              extractor: (rank) => rank.master.avatar,
              builder: (context, rank) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: GestureDetector(
                    onTap: () {
                      onTap(rank);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: SizedBox(
                      height: 48.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Tools.limitName(rank.master.name, 8),
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 6.w),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(text: '最近预测'),
                                      TextSpan(
                                        text: rank.rate.count,
                                        style: const TextStyle(
                                            color: Color(0xFFFF0033)),
                                      ),
                                      const TextSpan(text: '期'),
                                    ],
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(text: '已连续命中'),
                                    TextSpan(
                                      text: '${rank.rate.series}',
                                      style: const TextStyle(
                                        color: Color(0xFFFF0033),
                                      ),
                                    ),
                                    const TextSpan(text: '期'),
                                  ],
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
