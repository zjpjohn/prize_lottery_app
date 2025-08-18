import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/views/lottery/controller/ssq_number_trend_controller.dart';
import 'package:prize_lottery_app/views/lottery/pages/ssq/trend/ssq_blue_trend_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/ssq/trend/ssq_red_trend_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/ssq/trend/ssq_state_view.dart';
import 'package:prize_lottery_app/views/lottery/utils/trend_constants.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';
import 'package:prize_lottery_app/widgets/lottery_hint_widget.dart';

class SsqNumberTrendView extends StatefulWidget {
  ///
  const SsqNumberTrendView({super.key});

  @override
  SsqNumberTrendViewState createState() => SsqNumberTrendViewState();
}

class SsqNumberTrendViewState extends State<SsqNumberTrendView>
    with TickerProviderStateMixin {
  ///
  late TabController tabController;

  ///tab选项卡
  List<Widget> tabs = [
    Container(
      height: trendTabBarHeight,
      alignment: Alignment.center,
      child: const Text('红球走势'),
    ),
    Container(
      height: trendTabBarHeight,
      alignment: Alignment.center,
      child: const Text('蓝球走势'),
    ),
    Container(
      height: trendTabBarHeight,
      alignment: Alignment.center,
      child: const Text('分布态势'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double top = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height;
    double blockHeight = height - top - 44.h - 34.h - 40.h;
    int rows = blockHeight ~/ trendCellSize;
    return LayoutContainer(
      title: '选号走势',
      content: Container(
        color: Colors.white,
        child: RequestWidget<SsqNumberTrendController>(
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTabBar(controller),
                _buildTabView(controller, rows),
                _buildBottomHint(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTabBar(SsqNumberTrendController controller) {
    return Container(
      width: trendTabBarWidth,
      height: trendTabBarHeight,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 10.w),
      child: TabBar(
        tabs: tabs,
        dividerHeight: 0,
        controller: tabController,
        labelPadding: EdgeInsets.only(left: 4.w, right: 4.w),
        isScrollable: false,
        labelColor: const Color(0xFFEF3454),
        unselectedLabelColor: Colors.black87,
        unselectedLabelStyle:
            TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
        labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        indicator: const BoxDecoration(),
      ),
    );
  }

  Widget _buildTabView(SsqNumberTrendController controller, int rows) {
    return SizedBox(
      height: trendCellSize * rows + 2.w,
      child: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          SsqRedTrendView(
              rows: rows, omits: controller.omits, census: controller.census),
          SsqBlueTrendView(
              rows: rows, omits: controller.omits, census: controller.census),
          SsqStateView(rows: rows, censuses: controller.lottos),
        ],
      ),
    );
  }

  Widget _buildBottomHint() {
    return SizedBox(
      height: 38.h,
      child: const LotteryHintWidget(
        hint: '开奖信息仅供参考，请以官方开奖信息为准',
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: int.parse(Get.parameters['type'] ?? '0'),
      length: tabs.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
