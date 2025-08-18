import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/refresh_widget.dart';
import 'package:prize_lottery_app/resources/colors.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/views/glad/model/fc3d_master_glad.dart';
import 'package:prize_lottery_app/views/home/controller/fc3d_home_controller.dart';
import 'package:prize_lottery_app/views/home/controller/layer_state_controller.dart';
import 'package:prize_lottery_app/views/home/widgets/achieve_tag_view.dart';
import 'package:prize_lottery_app/views/home/widgets/channel_button.dart';
import 'package:prize_lottery_app/views/home/widgets/lottery_panel.dart';
import 'package:prize_lottery_app/views/home/widgets/master_glad_panel.dart';
import 'package:prize_lottery_app/views/home/widgets/rank_panel_widget.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_info.dart';
import 'package:prize_lottery_app/views/rank/model/fc3d_master_rank.dart';
import 'package:prize_lottery_app/widgets/lottery_hint_widget.dart';

class Fc3dHomeView extends StatefulWidget {
  ///
  ///
  const Fc3dHomeView({super.key});

  @override
  Fc3dHomeViewState createState() => Fc3dHomeViewState();
}

class Fc3dHomeViewState extends State<Fc3dHomeView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshWidget<Fc3dHomeController>(
      init: Fc3dHomeController(),
      bottomBouncing: false,
      enableLoad: false,
      builder: (controller) {
        return _buildContentContainer(controller);
      },
    );
  }

  Widget _buildContentContainer(Fc3dHomeController controller) {
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

  ///
  /// 开奖信息
  Widget _buildLotteryView(LotteryInfo lottery) {
    return LotteryInfoPanel(lottery: lottery);
  }

  ///
  /// 福彩3D渠道面板
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
                        Get.toNamed(AppRoutes.fc3dBattle);
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
                    Get.toNamed(AppRoutes.fc3dIntellect);
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
                    Get.toNamed(AppRoutes.fc3dVipCensus);
                  },
                ),
                ChannelButton(
                  text: '快速查表',
                  icon: R.fastAnalyzeIcon,
                  size: 36.w,
                  callback: () {
                    Get.toNamed('/qtable/fc3d');
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
                        Get.toNamed('/fc3d/num3/layer');
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
                    Get.toNamed('/fc3d/trend/0');
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
                    Get.toNamed('/palace/new/fc3d');
                  },
                ),
                Stack(
                  children: [
                    ChannelButton(
                      text: '缩水过滤',
                      icon: R.masterAnalyzeIcon,
                      size: 36.w,
                      callback: () {
                        Get.toNamed('/wens/filter/fc3d');
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
                    Get.toNamed(AppRoutes.fc3dFullCensus);
                  },
                ),
                ChannelButton(
                  text: '今日指数',
                  icon: R.historyAnalyzeIcon,
                  size: 36.w,
                  callback: () {
                    Get.toNamed('/fc3d/num3/lotto/index');
                  },
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  ///
  /// 综合排名面板
  Widget _buildRankView(List<Fc3dMasterMulRank> ranks) {
    if (ranks.isEmpty) {
      return const SizedBox.shrink();
    }
    return RankPanelWidget(
      ranks: ranks,
      type: 0,
      detailPrefix: '/fc3d/master/',
      moreAction: () {
        Get.toNamed(AppRoutes.fc3dMulRank);
      },
    );
  }

  ///
  /// 中奖信息面板
  Widget _buildGladView(List<Fc3dMasterGlad> glads) {
    if (glads.isEmpty) {
      return Container();
    }
    return Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w),
      child: MasterGladPanel<Fc3dMasterGlad>(
        glads: glads,
        colors: fc3dColors,
        moreAction: () {
          Get.toNamed(AppRoutes.fc3dGladList);
        },
        masterCallback: (glad) {
          Get.toNamed(
            '/fc3d/master/${glad.master.masterId}',
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
