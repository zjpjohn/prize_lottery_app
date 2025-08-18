import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/refresh_widget.dart';
import 'package:prize_lottery_app/resources/colors.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/views/glad/model/ssq_master_glad.dart';
import 'package:prize_lottery_app/views/home/controller/ssq_home_controller.dart';
import 'package:prize_lottery_app/views/home/widgets/achieve_tag_view.dart';
import 'package:prize_lottery_app/views/home/widgets/channel_button.dart';
import 'package:prize_lottery_app/views/home/widgets/lottery_panel.dart';
import 'package:prize_lottery_app/views/home/widgets/master_glad_panel.dart';
import 'package:prize_lottery_app/views/home/widgets/rank_panel_widget.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_info.dart';
import 'package:prize_lottery_app/views/rank/model/ssq_master_rank.dart';
import 'package:prize_lottery_app/widgets/lottery_hint_widget.dart';

class SsqHomeView extends StatefulWidget {
  ///
  ///
  const SsqHomeView({super.key});

  @override
  SsqHomeViewState createState() => SsqHomeViewState();
}

class SsqHomeViewState extends State<SsqHomeView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshWidget<SsqHomeController>(
      init: SsqHomeController(),
      bottomBouncing: false,
      enableLoad: false,
      builder: (controller) {
        return _buildContentContainer(controller);
      },
    );
  }

  Widget _buildContentContainer(SsqHomeController controller) {
    return Container(
      padding: EdgeInsets.only(top: 16.w),
      child: Column(
        children: [
          _buildLotteryView(controller.lottery),
          _buildChannelView(),
          _buildRankView(
            type: 0,
            ranks: controller.ranks,
            title: '优质红球精品专家出炉!',
            colors: [const Color(0xFFFD7164), const Color(0xFFFD9E8A)],
          ),
          _buildRankView(
            type: 1,
            ranks: controller.bRanks,
            title: '优质蓝球精品专家出炉!',
            colors: [const Color(0xFF6CAFF6), const Color(0xFF9DC9FA)],
          ),
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

  Widget _buildChannelView() {
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
                ChannelButton(
                  text: '专家PK',
                  icon: R.pkAnalyzeIcon,
                  size: 36.w,
                  callback: () {
                    Get.toNamed(AppRoutes.ssqBattle);
                  },
                ),
                ChannelButton(
                  text: '号码预警',
                  icon: R.alertAnalyzeIcon,
                  size: 36.w,
                  callback: () {
                    Get.toNamed(AppRoutes.ssqAnaCensus);
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
                    Get.toNamed(AppRoutes.ssqVipCensus);
                  },
                ),
                ChannelButton(
                  text: '号码走势',
                  icon: R.trendAnalyzeIcon,
                  size: 36.w,
                  callback: () {
                    Get.toNamed('/ssq/trend/0');
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                ChannelButton(
                  text: '热点分析',
                  icon: R.hotAnalyzeIcon,
                  size: 36.w,
                  callback: () {
                    Get.toNamed(AppRoutes.ssqHotCensus);
                  },
                ),
                ChannelButton(
                  text: '缩水过滤',
                  icon: R.filterAnalyzeIcon,
                  size: 36.w,
                  callback: () {
                    Get.toNamed(AppRoutes.ssqShrink);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                ChannelButton(
                  text: '臻选牛人',
                  icon: R.masterAnalyzeIcon,
                  size: 36.w,
                  callback: () {
                    Get.toNamed(AppRoutes.ssqRateCensus);
                  },
                ),
                ChannelButton(
                  text: '奖金计算',
                  icon: R.calcAnalyzeIcon,
                  size: 36.w,
                  margin: EdgeInsets.zero,
                  callback: () {
                    Get.toNamed(AppRoutes.ssqCalculator);
                  },
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
                    Get.toNamed(AppRoutes.ssqFullCensus);
                  },
                ),
                ChannelButton(
                  text: '历史开奖',
                  icon: R.historyAnalyzeIcon,
                  size: 36.w,
                  callback: () {
                    Get.toNamed('/lotto/history/ssq');
                  },
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildRankView({
    required List<SsqMasterMulRank> ranks,
    required int type,
    required List<Color> colors,
    required String title,
  }) {
    if (ranks.isEmpty) {
      return const SizedBox.shrink();
    }
    return RankPanelWidget(
      ranks: ranks,
      type: type,
      title: title,
      colors: colors,
      channel: type == 0 ? 'rk3' : 'bk',
      detailPrefix: '/ssq/master/',
      moreAction: () {
        Get.toNamed('/ssq/mul_rank/$type');
      },
    );
  }

  Widget _buildGladView(List<SsqMasterGlad> glads) {
    if (glads.isEmpty) {
      return Container();
    }
    return Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w),
      child: MasterGladPanel<SsqMasterGlad>(
        glads: glads,
        colors: ssqColors,
        moreAction: () {
          Get.toNamed(AppRoutes.ssqGladList);
        },
        masterCallback: (glad) {
          Get.toNamed(
            '/ssq/master/${glad.master.masterId}',
            parameters: {'channel': 'r25'},
          );
        },
        tagCallback: (glad) {
          return [
            AchieveTag(
              name: '围红',
              achieve: '近${glad.red25.count}期',
            ),
            AchieveTag(
              name: '杀蓝',
              achieve: '近${glad.bk.count}期',
              tagColor: TagColor.blue,
            ),
          ];
        },
        rateCallback: (glad) {
          List<String> tags = [
            if (glad.red25.rate >= 0.5) '围红',
            if (glad.rk3.rate >= 0.6) '杀红',
            if (glad.bk.rate >= 0.75) '杀蓝'
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
