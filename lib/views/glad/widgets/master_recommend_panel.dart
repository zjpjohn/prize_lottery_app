import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/base/model/stat_hit_value.dart';
import 'package:prize_lottery_app/utils/tools.dart';
import 'package:prize_lottery_app/views/rank/model/master_mul_rank.dart';
import 'package:prize_lottery_app/widgets/card_banner_swiper.dart';

typedef MasterTapCallback<T extends MasterMulRank> = void Function(T master);

typedef StatHitCallback<T extends MasterMulRank> = StatHitValue Function(
    T master);

class MasterRecommendPanel<T extends MasterMulRank> extends StatelessWidget {
  ///
  const MasterRecommendPanel({
    super.key,
    required this.masters,
    required this.tapCallback,
    required this.hitCallback,
  });

  final List<T> masters;
  final MasterTapCallback<T> tapCallback;
  final StatHitCallback<T> hitCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 8.w, bottom: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 10.w, left: 16.w),
            child: Stack(
              children: [
                Positioned(
                  left: 2,
                  bottom: 0.2,
                  child: Container(
                    width: 40.w,
                    height: 4.w,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.indigo.withValues(alpha: 0.35),
                          Colors.indigo.withValues(alpha: 0.05),
                        ],
                      ),
                    ),
                  ),
                ),
                Text(
                  '精选推荐',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 12.w,
              bottom: 14.w,
            ),
            child: CardBannerSwiper<T>(
              datas: masters,
              width: 44.w,
              height: 30.w,
              duration: 4000,
              extractor: (data) => data.master.avatar,
              builder: (context, data) {
                StatHitValue hit = hitCallback(data);
                return GestureDetector(
                  onTap: () {
                    tapCallback(data);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    height: 44.w,
                    padding: EdgeInsets.only(left: 8.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Tools.limitText(data.master.name, 10),
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.black87,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 4.w),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(text: '近期预测'),
                                    TextSpan(
                                      text: hit.count,
                                      style: const TextStyle(
                                        color: Color(0xFFFF0033),
                                      ),
                                    ),
                                    const TextSpan(text: '期'),
                                  ],
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.black38,
                                  ),
                                ),
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(text: '已连续命中'),
                                  TextSpan(
                                    text: '${hit.series}',
                                    style: const TextStyle(
                                      color: Color(0xFFFF0033),
                                    ),
                                  ),
                                  const TextSpan(text: '期'),
                                ],
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.black38,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
