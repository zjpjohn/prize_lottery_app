import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/refresh_widget.dart';
import 'package:prize_lottery_app/resources/colors.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/views/glad/model/qlc_master_glad.dart';
import 'package:prize_lottery_app/views/home/controller/qlc_home_controller.dart';
import 'package:prize_lottery_app/views/home/widgets/achieve_tag_view.dart';
import 'package:prize_lottery_app/views/home/widgets/channel_button.dart';
import 'package:prize_lottery_app/views/home/widgets/lottery_panel.dart';
import 'package:prize_lottery_app/views/home/widgets/master_glad_panel.dart';
import 'package:prize_lottery_app/views/home/widgets/rank_panel_widget.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_info.dart';
import 'package:prize_lottery_app/views/rank/model/qlc_master_rank.dart';
import 'package:prize_lottery_app/widgets/lottery_hint_widget.dart';

class QlcHomeView extends StatefulWidget {
  ///
  ///
  const QlcHomeView({super.key});

  @override
  QlcHomeViewState createState() => QlcHomeViewState();
}

class QlcHomeViewState extends State<QlcHomeView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshWidget<QlcHomeController>(
      init: QlcHomeController(),
      enableLoad: false,
      bottomBouncing: false,
      builder: (controller) {
        return _buildContentContainer(controller);
      },
    );
  }

  Widget _buildContentContainer(QlcHomeController controller) {
    return Container(
      padding: EdgeInsets.only(top: 16.w),
      child: Column(
        children: [
          _buildLotteryView(controller.lottery),
          _buildChannelView(),
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
                    Get.toNamed(AppRoutes.qlcBattle);
                  },
                ),
                ChannelButton(
                  text: '号码预警',
                  icon: R.alertAnalyzeIcon,
                  size: 36.w,
                  callback: () {
                    Get.toNamed(AppRoutes.qlcAnaCensus);
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
                    Get.toNamed(AppRoutes.qlcVipCensus);
                  },
                ),
                ChannelButton(
                  text: '号码走势',
                  icon: R.trendAnalyzeIcon,
                  size: 36.w,
                  callback: () {
                    Get.toNamed('/qlc/trend/0');
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
                    Get.toNamed(AppRoutes.qlcHotCensus);
                  },
                ),
                ChannelButton(
                  text: '缩水过滤',
                  icon: R.filterAnalyzeIcon,
                  size: 36.w,
                  callback: () {
                    Get.toNamed(AppRoutes.qlcShrink);
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
                    Get.toNamed(AppRoutes.qlcRateCensus);
                  },
                ),
                ChannelButton(
                  text: '奖金计算',
                  icon: R.calcAnalyzeIcon,
                  size: 36.w,
                  margin: EdgeInsets.zero,
                  callback: () {
                    Get.toNamed(AppRoutes.qlcCalculator);
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
                    Get.toNamed(AppRoutes.qlcFullCensus);
                  },
                ),
                ChannelButton(
                  text: '历史开奖',
                  icon: R.historyAnalyzeIcon,
                  size: 36.w,
                  callback: () {
                    Get.toNamed('/lotto/history/qlc');
                  },
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildRankView(List<QlcMasterMulRank> ranks) {
    if (ranks.isEmpty) {
      return const SizedBox.shrink();
    }
    return RankPanelWidget(
      ranks: ranks,
      type: 0,
      detailPrefix: '/qlc/master/',
      moreAction: () {
        Get.toNamed(AppRoutes.qlcMulRank);
      },
    );
  }

  Widget _buildGladView(List<QlcMasterGlad> glads) {
    if (glads.isEmpty) {
      return Container();
    }
    return Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w),
      child: MasterGladPanel<QlcMasterGlad>(
        glads: glads,
        colors: qlcColors,
        moreAction: () {
          Get.toNamed(AppRoutes.fc3dGladList);
        },
        masterCallback: (glad) {
          Get.toNamed(
            '/qlc/master/${glad.master.masterId}',
            parameters: {'channel': 'r22'},
          );
        },
        tagCallback: (glad) {
          return [
            AchieveTag(name: '围码', achieve: '近${glad.red22.count}期'),
            AchieveTag(name: '杀码', achieve: '近${glad.kill3.count}期'),
          ];
        },
        rateCallback: (glad) {
          List<String> tags = [
            if (glad.red22.rate >= 0.6) '围码',
            if (glad.kill3.rate >= 0.6) '杀码',
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
