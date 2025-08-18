import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/refresh_widget.dart';
import 'package:prize_lottery_app/resources/colors.dart';
import 'package:prize_lottery_app/resources/constants.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/utils/tools.dart';
import 'package:prize_lottery_app/views/glad/model/ssq_master_glad.dart';
import 'package:prize_lottery_app/views/home/controller/news_home_controller.dart';
import 'package:prize_lottery_app/views/master/widgets/search_master_rank.dart';
import 'package:prize_lottery_app/views/news/model/lottery_news.dart';
import 'package:prize_lottery_app/views/rank/model/ssq_master_rank.dart';
import 'package:prize_lottery_app/widgets/cached_avatar.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_phasics.dart';
import 'package:prize_lottery_app/widgets/feed_item_widget.dart';
import 'package:prize_lottery_app/widgets/vertical_marquee.dart';

class NewsHomeView extends StatefulWidget {
  ///
  ///
  const NewsHomeView({super.key});

  @override
  NewsHomeViewState createState() => NewsHomeViewState();
}

class NewsHomeViewState extends State<NewsHomeView>
    with AutomaticKeepAliveClientMixin {
  ///
  ///
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshWidget<NewsHomeController>(
      init: NewsHomeController(),
      scrollController: _scrollController,
      topConfig: const ScrollTopConfig(align: TopAlign.right),
      builder: (controller) {
        return _buildNewsHomeView(controller);
      },
    );
  }

  Widget _buildNewsHomeView(NewsHomeController controller) {
    return ListView.builder(
      itemCount: controller.news.length + 2,
      itemBuilder: (context, index) {
        if (index == 0) {
          return _buildMaterRankView(controller.ranks, controller.glads);
        }
        if (index == 1) {
          return _buildNewsPanelHeader();
        }
        return _buildNewsItem(
          controller.news[index - 2],
          index - 2,
          index - 2 < controller.news.length - 1,
          controller.limit,
        );
      },
    );
  }

  Widget _buildMaterRankView(
      List<SsqMasterMulRank> ranks, List<SsqMasterGlad> glads) {
    if (ranks.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      padding: EdgeInsets.only(top: 8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white, width: 0.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: Container(
                        width: 60.w,
                        height: 8.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.w),
                            bottomLeft: Radius.circular(5.w),
                          ),
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFFFd4A68).withValues(alpha: 0.75),
                              const Color(0xFFFd4A68).withValues(alpha: 0.05),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 1.w),
                      child: Text(
                        '双色球热榜',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
                VerticalMarquee(
                  height: 24.w,
                  width: MediaQuery.of(context).size.width * 0.48,
                  color: Colors.transparent,
                  radius: BorderRadius.circular(20.w),
                  items: glads.map((e) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed('/ssq/master/${e.master.masterId}');
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.redAccent.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20.w),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(1.5.w),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFd4A68)
                                    .withValues(alpha: 0.75),
                                borderRadius: BorderRadius.circular(17.w),
                              ),
                              child: CachedAvatar(
                                width: 17.w,
                                height: 17.w,
                                radius: 17.w,
                                url: e.master.avatar,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8.w),
                              child: RichText(
                                text: TextSpan(
                                  text: Tools.limitName(e.master.name, 7),
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 11.sp),
                                  children: [
                                    TextSpan(
                                      text:
                                          '命中${ssqLevel['${e.r25Hit}${e.b5Hit}']}',
                                      style: const TextStyle(
                                        color: Color(0xFFFd4A68),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 6.w),
            padding: EdgeInsets.only(top: 6.w),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const EasyRefreshPhysics(),
              child: Row(
                children: [
                  SizedBox(width: 12.w),
                  ...List.generate(3, (index) {
                    return Container(
                      margin: EdgeInsets.only(right: 12.w),
                      padding: EdgeInsets.only(
                        left: 10.w,
                        top: 10.w,
                        right: 10.w,
                        bottom: 2.w,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.w),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.redAccent.withValues(alpha: 0.1),
                            Colors.redAccent.withValues(alpha: 0.025),
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          _buildMasterRank(ranks[index * 3]),
                          _buildMasterRank(ranks[index * 3 + 1]),
                          _buildMasterRank(ranks[index * 3 + 2]),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMasterRank(SsqMasterMulRank rank) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Get.toNamed('/ssq/master/${rank.master.masterId}');
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8.w),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 12.w),
                  child: CachedAvatar(
                    width: 24.w,
                    height: 24.w,
                    radius: 3.w,
                    url: rank.master.avatar,
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  child: ClipPath(
                    clipper: VoucherClipper(),
                    child: Container(
                      width: 13.w,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 1.w, bottom: 5.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(3.w),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            itemRankColors[rank.rank <= 4 ? rank.rank : 4]!,
                            itemRankColors[rank.rank <= 4 ? rank.rank : 4]!
                                .withValues(alpha: 0.6),
                          ],
                        ),
                      ),
                      child: Text(
                        '${rank.rank}',
                        style: TextStyle(
                          fontSize: 9.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 24.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 120.w,
                    child: Text(
                      Tools.limitText(rank.master.name, 9),
                      textAlign: TextAlign.start,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontSize: 12.sp,
                        height: 0.98,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: '最近',
                      style: TextStyle(color: Colors.black26, fontSize: 9.sp),
                      children: [
                        TextSpan(
                          text: rank.rk3.count,
                          style: const TextStyle(color: Colors.redAccent),
                        ),
                        const TextSpan(text: '期'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsPanelHeader() {
    return Container(
      padding: EdgeInsets.only(left: 12.w, top: 10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white, width: 0.0),
      ),
      child: Row(
        children: [
          Image.asset(R.hot, width: 18.w, height: 18.w),
          Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: Text(
              '热点资讯',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsItem(
    LotteryNews news,
    int index,
    bool border,
    int pageSize,
  ) {
    return FeedItemWidget(
      title: news.title,
      delta: news.delta,
      header: news.header,
      browse: news.browse,
      border: border,
      showAds: index > 0 && index % 20 == 3,
      onTap: () {
        Get.toNamed('/news/detail/${news.seq}');
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
