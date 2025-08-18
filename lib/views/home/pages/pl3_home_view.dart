import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/refresh_widget.dart';
import 'package:prize_lottery_app/resources/colors.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/views/glad/model/pl3_master_glad.dart';
import 'package:prize_lottery_app/views/home/controller/layer_state_controller.dart';
import 'package:prize_lottery_app/views/home/controller/pl3_home_controller.dart';
import 'package:prize_lottery_app/views/home/widgets/achieve_tag_view.dart';
import 'package:prize_lottery_app/views/home/widgets/channel_button.dart';
import 'package:prize_lottery_app/views/home/widgets/lottery_panel.dart';
import 'package:prize_lottery_app/views/home/widgets/master_glad_panel.dart';
import 'package:prize_lottery_app/views/home/widgets/rank_panel_widget.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_info.dart';
import 'package:prize_lottery_app/views/rank/model/pl3_master_rank.dart';
import 'package:prize_lottery_app/widgets/lottery_hint_widget.dart';

class Pl3HomeView extends StatefulWidget {
  ///
  const Pl3HomeView({super.key});

  @override
  Pl3HomeViewState createState() => Pl3HomeViewState();
}

class Pl3HomeViewState extends State<Pl3HomeView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshWidget<Pl3HomeController>(
      init: Pl3HomeController(),
      bottomBouncing: false,
      enableLoad: false,
      builder: (controller) {
        return _buildContentContainer(controller);
      },
    );
  }

  Widget _buildContentContainer(Pl3HomeController controller) {
    return Container(
      padding: EdgeInsets.only(top: 16.w),
      child: Column(
        children: [
          _buildLotteryView(controller.lottery),
          _buildChannelView(controller.layerState),
          _buildRankView(controller.ranks),
          _buildGladView(controller.glads),
          _buildBottomHint(),
        ],
      ),
    );
  }

  Widget _buildBottomHint() {
    return Padding(
      padding: EdgeInsets.only(top: 8.w, bottom: 20.w),
      child: const LotteryHintWidget(
        hint: '本应用不提供购彩服务，请理性购彩',
      ),
    );
  }

  Widget _buildLotteryView(LotteryInfo lottery) {
    return LotteryInfoPanel(lottery: lottery);
  }

  Widget _buildChannelView(LayerState state) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 4.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.w),
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              children: [
                Stack(
                  children: [
                    ChannelButton(
                      text: '专家PK',
                      icon: R.pkAnalyzeIcon,
                      size: 36.w,
                      callback: () {
                        Get.toNamed(AppRoutes.pl3Battle);
                      },
                    ),
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
                          '热门',
                          style: TextStyle(
                            fontSize: 8.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ChannelButton(
                  text: '智能选号',
                  icon: R.lottoIntellectIcon,
                  size: 36.w,
                  callback: () {
                    Get.toNamed(AppRoutes.pl3Intellect);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                ChannelButton(
                  text: '综合分析',
                  icon: R.zongheAnalyzeIcon,
                  size: 36.w,
                  callback: () {
                    Get.toNamed(AppRoutes.pl3VipCensus);
                  },
                ),
                ChannelButton(
                  text: '快速查表',
                  icon: R.fastAnalyzeIcon,
                  size: 36.w,
                  margin: EdgeInsets.zero,
                  callback: () {
                    Get.toNamed('/qtable/pl3');
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Stack(
                  children: [
                    ChannelButton(
                      text: '预警推荐',
                      icon: R.earlyWarnIcon,
                      size: 36.w,
                      callback: () {
                        Get.toNamed('/pl3/num3/layer');
                      },
                    ),
                    if (state.state >= 1)
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
                                Color(0xFFFF0045).withAlpha(130),
                                Color(0xFFFF0045).withAlpha(190),
                                Color(0xFFFF0045),
                              ],
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.w),
                              topRight: Radius.circular(8.w),
                              bottomRight: Radius.circular(8.w),
                            ),
                          ),
                          child: Text(
                            state.state == 1 ? '命中' : '上新',
                            style: TextStyle(
                              fontSize: 8.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                ChannelButton(
                  text: '号码走势',
                  icon: R.trendAnalyzeIcon,
                  size: 36.w,
                  callback: () {
                    Get.toNamed('/pl3/trend/0');
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                ChannelButton(
                  text: '蜂巢选号',
                  icon: R.hotAnalyzeIcon,
                  size: 36.w,
                  callback: () {
                    Get.toNamed('/palace/new/pl3');
                  },
                ),
                Stack(
                  children: [
                    ChannelButton(
                      text: '缩水过滤',
                      icon: R.masterAnalyzeIcon,
                      size: 36.w,
                      callback: () {
                        Get.toNamed('/wens/filter/pl3');
                      },
                    ),
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
                          '热门',
                          style: TextStyle(
                            fontSize: 8.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                ChannelButton(
                  text: '整体分析',
                  icon: R.chartAnalyzeIcon,
                  size: 36.w,
                  callback: () {
                    Get.toNamed(AppRoutes.pl3FullCensus);
                  },
                ),
                ChannelButton(
                  text: '今日指数',
                  icon: R.historyAnalyzeIcon,
                  size: 36.w,
                  callback: () {
                    Get.toNamed('/pl3/num3/lotto/index');
                  },
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildRankView(List<Pl3MasterMulRank> ranks) {
    if (ranks.isEmpty) {
      return const SizedBox.shrink();
    }
    return RankPanelWidget(
      ranks: ranks,
      type: 0,
      detailPrefix: '/pl3/master/',
      moreAction: () {
        Get.toNamed(AppRoutes.pl3MulRank);
      },
    );
  }

  Widget _buildGladView(List<Pl3MasterGlad> glads) {
    if (glads.isEmpty) {
      return Container();
    }
    return Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w),
      child: MasterGladPanel<Pl3MasterGlad>(
        glads: glads,
        colors: pl3Colors,
        moreAction: () {
          Get.toNamed(AppRoutes.pl3GladList);
        },
        masterCallback: (glad) {
          Get.toNamed(
            '/pl3/master/${glad.master.masterId}',
            parameters: {'channel': 'd3'},
          );
        },
        tagCallback: (glad) {
          return [
            AchieveTag(name: '三胆', achieve: '近${glad.dan3.count}期'),
            AchieveTag(name: '杀一码', achieve: '近${glad.kill1.count}期'),
          ];
        },
        rateCallback: (glad) {
          List<String> tags = [
            if (glad.dan3.rate >= 0.75) '三胆',
            if (glad.com7.rate >= 0.8) '七码',
            if (glad.kill1.rate >= 0.8) '杀一码',
          ];
          if (tags.isEmpty) {
            tags.add('加油中');
          }
          return tags;
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
