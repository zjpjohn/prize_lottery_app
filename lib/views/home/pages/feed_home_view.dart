import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/model/enum_value.dart';
import 'package:prize_lottery_app/base/model/request_state.dart';
import 'package:prize_lottery_app/base/widgets/refresh_widget.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/store/config.dart';
import 'package:prize_lottery_app/utils/constants.dart';
import 'package:prize_lottery_app/utils/date_util.dart';
import 'package:prize_lottery_app/utils/tools.dart';
import 'package:prize_lottery_app/views/home/controller/feed_home_controller.dart';
import 'package:prize_lottery_app/views/home/controller/layer_state_controller.dart';
import 'package:prize_lottery_app/views/home/model/master_feeds.dart';
import 'package:prize_lottery_app/views/home/model/master_lotto_glad.dart';
import 'package:prize_lottery_app/views/home/widgets/home_refresh_widget.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_info.dart';
import 'package:prize_lottery_app/views/rank/model/master_item_rank.dart';
import 'package:prize_lottery_app/widgets/cached_avatar.dart';
import 'package:prize_lottery_app/widgets/common_widgets.dart';
import 'package:prize_lottery_app/widgets/error_widget.dart';
import 'package:prize_lottery_app/widgets/indicator_banner.dart';
import 'package:prize_lottery_app/widgets/loading_widget.dart';
import 'package:prize_lottery_app/widgets/vertical_marquee.dart';

class FeedHomeView extends StatefulWidget {
  ///
  ///
  const FeedHomeView({super.key});

  @override
  FeedHomeViewState createState() => FeedHomeViewState();
}

class FeedHomeViewState extends State<FeedHomeView>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return HomeRefreshWidget<FeedHomeController>(
      init: FeedHomeController(),
      scrollController: _scrollController,
      topConfig: ScrollTopConfig(align: TopAlign.right, throttle: 700.w),
      builder: (controller) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.w),
          ),
          child: Column(
            children: [
              _buildKingKong(controller),
              _buildMarketBanner(controller),
              ..._buildLottoAndFeeds(controller),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildLottoAndFeeds(FeedHomeController controller) {
    if (controller.state == RequestState.loading) {
      return [
        Padding(
          padding: EdgeInsets.only(top: 32.w),
          child: const LoadingView(),
        ),
      ];
    }
    if (controller.state == RequestState.error) {
      return [
        Padding(
          padding: EdgeInsets.only(top: 32.w),
          child: ErrorView(
            width: 120.w,
            height: 120.w,
            message: '加载内容失败',
            subtitle: '点击重新请求加载',
            callback: () {
              controller.onInitial();
            },
          ),
        ),
      ];
    }
    return [
      _buildLottoChannel(controller),
      _buildFeedStream(controller),
    ];
  }

  Widget _buildKingKong(FeedHomeController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: _kingKing(controller.kingkongs, controller.layerState),
    );
  }

  Widget _buildLottoChannel(FeedHomeController controller) {
    if (controller.lottery == null) {
      return const SizedBox.shrink();
    }
    return Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: Column(
        children: [
          _lotteryView(controller),
          _lottoMasters(
            controller.lottery!.recommends,
            controller.channel,
          ),
        ],
      ),
    );
  }

  Widget _kingKing(List<List<KingKong>> table, LayerState layerState) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 8.w),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 6.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
                  table[0].map((e) => _kingKongCell(e, layerState)).toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:
                table[1].map((e) => _kingKongCell(e, layerState)).toList(),
          )
        ],
      ),
    );
  }

  Widget _kingKongCell(KingKong cell, LayerState layerState) {
    if (cell.order != null && cell.intro != null) {
      return IntroStepBuilder(
        order: cell.order!,
        overlayBuilder: (params) {
          return CommonWidgets.introStep(
            text: cell.intro!,
            btnTxt: '下一步',
            onStep: params.onNext,
          );
        },
        builder: (context, key) => _kingKongWidget(cell, layerState, key),
      );
    }
    return _kingKongWidget(cell, layerState, GlobalKey());
  }

  Widget _kingKongWidget(KingKong cell, LayerState layerState, GlobalKey key) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(cell.route);
      },
      key: key,
      behavior: HitTestBehavior.opaque,
      child: Stack(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: 54.w,
                    height: 42.w,
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      cell.icon,
                      width: 34.w,
                      height: 34.w,
                    ),
                  ),
                  if (cell.hot)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.w,
                          vertical: 1.w,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFFFF0045).withAlpha(130),
                              const Color(0xFFFF0045).withAlpha(190),
                              const Color(0xFFFF0045),
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.w),
                            topRight: Radius.circular(8.w),
                            bottomRight: Radius.circular(8.w),
                          ),
                        ),
                        child: Text(
                          _kingKongMark(cell, layerState),
                          style: TextStyle(
                            fontSize: 8.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 4.w),
                child: Text(
                  cell.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.sp,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  String _kingKongMark(KingKong cell, LayerState state) {
    String mark = '热门';
    if (cell.layer) {
      mark = state.state == 0 ? '热门' : (state.state == 1 ? '命中' : '上新');
    }
    return mark;
  }

  Widget _lotteryView(FeedHomeController controller) {
    LotteryInfo lottery = controller.lottery!.lottery;
    return Container(
      padding: EdgeInsets.all(8.w),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 6.w),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10.w),
                  child: Image.asset(
                    controller.channel.icon,
                    width: 36.w,
                    height: 36.w,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.channel.name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                controller.switchLotteryChannel();
                              },
                              behavior: HitTestBehavior.opaque,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 2.w),
                                    child: Icon(
                                      const IconData(0xeb0d,
                                          fontFamily: 'iconfont'),
                                      size: 14.sp,
                                      color: Colors.black38,
                                    ),
                                  ),
                                  Text(
                                    '切换彩种',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.black38,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Text(
                              '第${lottery.period}期',
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 1.5.w),
                                  child: Text(
                                    lottery.lotDate,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.black45,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 6.w),
                                  child: Text(
                                    lottery.lotDate.isEmpty
                                        ? ''
                                        : Constants.dayWeek(
                                            DateUtil.parse(
                                              lottery.lotDate,
                                              pattern: "yyyy/MM/dd",
                                            ),
                                          ),
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.black45,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: _lotteryTxt(
                    lottery.redBalls(),
                    lottery.blueBalls(),
                  ),
                ),
              ),
              if (lottery.shi.isNotEmpty)
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: Text(
                          '试机号',
                          style: TextStyle(
                            color: Colors.black26,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                      ..._lotteryTxt(lottery.shiBalls(), []),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _lottoMasters(List<MasterItemRank> ranks, LotteryChannel channel) {
    if (ranks.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      padding: EdgeInsets.all(8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: ranks.map((e) => _master(e, channel)).toList(),
      ),
    );
  }

  Widget _master(MasterItemRank rank, LotteryChannel channel) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          '/${channel.channel}/master/${rank.master.masterId}',
          parameters: {'channel': channel.fieldIdx},
        );
      },
      child: Container(
        width: 72.w,
        padding: EdgeInsets.only(bottom: 8.w),
        decoration: BoxDecoration(
          color: Colors.orange.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(6.w),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.w),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.12),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(4.w),
                  bottomRight: Radius.circular(4.w),
                ),
              ),
              child: Text(
                '杀码',
                style: TextStyle(
                  color: Colors.deepOrangeAccent,
                  fontSize: 11.sp,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.w),
              child: Column(
                children: [
                  Text(
                    rank.rate.count,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '连中${rank.rate.series}期',
                    style: TextStyle(
                      fontSize: 11.sp,
                      height: 0.90,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(1.5.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F1F1),
                    borderRadius: BorderRadius.circular(20.w),
                  ),
                  child: CachedAvatar(
                    width: 15.w,
                    height: 15.w,
                    radius: 10.w,
                    url: rank.master.avatar,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 3.w),
                  child: Text(
                    Tools.limitText(rank.master.name, 2),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _lotteryTxt(List<String> reds, List<String> blues) {
    List<Widget> views = [];
    for (var ball in reds) {
      views.add(
        Container(
          width: 26.w,
          height: 26.w,
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 8.w),
          decoration: BoxDecoration(
            color: const Color(0xFFFF0033),
            borderRadius: BorderRadius.circular(15.w),
          ),
          child: Text(
            ball,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontFamily: 'bebas',
            ),
          ),
        ),
      );
    }
    if (blues.isNotEmpty) {
      views.add(SizedBox(width: 24.w));
      for (var ball in blues) {
        views.add(
          Container(
            width: 26.w,
            height: 26.w,
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 8.w),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(15.w),
            ),
            child: Text(
              ball,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontFamily: 'bebas',
              ),
            ),
          ),
        );
      }
    }
    return views;
  }

  Widget _buildMarketBanner(FeedHomeController controller) {
    return Container(
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: Column(
        children: [
          _masterGladSwiper(controller.glads),
          Container(
            padding: EdgeInsets.only(top: 8.w, bottom: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4.w),
                  child: Container(
                    width: 130.w,
                    height: 180.w,
                    color: Colors.orange.withValues(alpha: 0.06),
                    child: _marketBanner(),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed('/dlt/mul_rank/0');
                              },
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                height: 90.w,
                                padding: EdgeInsets.symmetric(vertical: 8.w),
                                decoration: BoxDecoration(
                                  color: Colors.orange.withValues(alpha: 0.06),
                                  borderRadius: BorderRadius.circular(4.w),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 6.w),
                                      child: Image.asset(
                                        R.dltLottoIcon,
                                        height: 48.w,
                                      ),
                                    ),
                                    Image.asset(R.jianChiFont, height: 14.w)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: IntroStepBuilder(
                              order: 5,
                              overlayBuilder: (params) {
                                return CommonWidgets.introStep(
                                  text: '会员服务：开通会员服务全部推荐资料一站式享用，为您中奖提供最大助力',
                                  btnTxt: '知道了',
                                  onStep: () {
                                    params.onFinish();
                                    ConfigStore().incrIntro();
                                  },
                                );
                              },
                              onWidgetLoad: () {
                                if (ConfigStore().intro <= 2) {
                                  Intro.of(context).start();
                                }
                              },
                              builder: (context, key) => GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoutes.member);
                                },
                                key: key,
                                behavior: HitTestBehavior.opaque,
                                child: Container(
                                  height: 90.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color:
                                        Colors.orange.withValues(alpha: 0.06),
                                    borderRadius: BorderRadius.circular(4.w),
                                  ),
                                  child: Image.asset(
                                    R.homeMember,
                                    width: 68.w,
                                    height: 76.w,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.w),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.invite);
                        },
                        child: Container(
                          height: 80.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.orange.withValues(alpha: 0.06),
                            borderRadius: BorderRadius.circular(4.w),
                            image: const DecorationImage(
                              image: AssetImage(R.homeInvite),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 1.w, right: 2.w),
                  child: Icon(
                    const IconData(0xe63d, fontFamily: 'iconfont'),
                    size: 12.sp,
                    color: const Color(0xFFD2B48C).withValues(alpha: 0.75),
                  ),
                ),
                Text(
                  '本应用不提供购彩服务，请您理性购彩',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.brown,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _marketBanner() {
    return LiquidBanner(
      interval: 1.0,
      outer: 6.w,
      inner: 3.w,
      height: 180.w,
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.ssqGladList);
          },
          child: Image.asset(
            R.homeHitPoster,
            width: 130.w,
            height: 180.w,
            fit: BoxFit.cover,
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed('/ssq/mul_rank/0');
          },
          child: Image.asset(
            R.homeMasterRank,
            width: 130.w,
            height: 180.w,
            fit: BoxFit.cover,
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.pl3Battle);
          },
          child: Image.asset(
            R.homeMasterBattle,
            width: 130.w,
            height: 180.w,
            fit: BoxFit.cover,
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.pl3Intellect);
          },
          child: Image.asset(
            R.homeIntellectLotto,
            width: 130.w,
            height: 180.w,
            fit: BoxFit.cover,
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.pl3VipCensus);
          },
          child: Image.asset(
            R.homeMasterCensus,
            width: 130.w,
            height: 180.w,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget _masterGladSwiper(List<MasterLottoGlad> glads) {
    return SizedBox(
      height: 24.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(R.gladNews, height: 14.w),
          Expanded(
            child: glads.isEmpty
                ? const SizedBox.shrink()
                : VerticalMarquee(
                    radius: BorderRadius.zero,
                    color: Colors.white,
                    height: 20.w,
                    items: glads.map((e) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(
                              '/${e.lottery.value}/master/${e.master.masterId}');
                        },
                        behavior: HitTestBehavior.opaque,
                        child: SizedBox(
                          height: 18.w,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 2.w),
                                child: Text(
                                  Tools.limitText(e.master.name, 4),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '第${e.period.substring(4)}期${e.lottery.description}${e.content}',
                                  style: TextStyle(
                                    color: const Color(0xFFFF0033),
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedStream(FeedHomeController controller) {
    if (controller.feeds.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      margin: EdgeInsets.only(top: 10.w),
      child: Column(
        children: [
          _feedHeader(),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.feeds.length,
            itemBuilder: (context, index) {
              return _masterFeedItem(
                controller.feeds[index],
                index < controller.feeds.length - 1,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _feedHeader() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      padding: EdgeInsets.only(left: 12.w, top: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.w),
          topRight: Radius.circular(8.w),
        ),
      ),
      child: Text(
        '综合推荐',
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _masterFeedItem(MasterFeeds feed, bool border) {
    return Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w),
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 20.w,
        bottom: border ? 0 : 20.w,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: border
            ? BorderRadius.circular(0)
            : BorderRadius.only(
                bottomLeft: Radius.circular(8.w),
                bottomRight: Radius.circular(8.w),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed('/${feed.type.value}/master/${feed.master.masterId}');
            },
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10.w),
                  child: CachedAvatar(
                    width: 38.w,
                    height: 38.w,
                    radius: 4.w,
                    url: feed.master.avatar,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 4.w),
                        child: Text(
                          Tools.limitText(feed.master.name, 10),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        feed.rateText,
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(
                  '/${feed.type.value}/forecast/${feed.master.masterId}');
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16.w),
              alignment: Alignment.centerLeft,
              child: Text(
                feed.masterText ?? '',
                style: TextStyle(
                  fontSize: 15.5.sp,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          _FeedTimeBottom(
            delta: feed.delta,
            type: feed.type,
            browse: feed.master.browse,
            subscribe: feed.master.subscribe,
          ),
          if (border)
            Container(
              height: 0.4.w,
              color: const Color(0xFFECECEC),
              margin: EdgeInsets.only(top: 16.w),
            ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _FeedTimeBottom extends StatelessWidget {
  final TimeDelta delta;
  final EnumValue type;
  final int browse;
  final int subscribe;

  const _FeedTimeBottom({
    required this.delta,
    required this.browse,
    required this.subscribe,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            var value = type.value;
            if (value == 'dlt' || value == 'ssq') {
              Get.toNamed('/$value/mul_rank/0');
              return;
            }
            Get.toNamed('/$value/mul_rank');
          },
          behavior: HitTestBehavior.opaque,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(right: 1.w, top: 0.5.w),
                child: Text(
                  '#',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xFFFF0045),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                '${type.description}推荐榜',
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 4.w),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 1.w),
                    child: Text(
                      '${delta.time}',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                  Text(
                    '${delta.text}更新',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 11.sp,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 4.w),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 1.w),
                    child: Text(
                      '$browse',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                  Text(
                    '浏览',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 11.sp,
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 1.w),
                  child: Text(
                    '$subscribe',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                Text(
                  '订阅',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 11.sp,
                  ),
                )
              ],
            ),
          ],
        )
      ],
    );
  }
}
