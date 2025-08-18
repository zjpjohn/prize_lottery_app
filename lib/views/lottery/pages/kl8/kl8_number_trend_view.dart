import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/views/lottery/controller/kl8_number_trend_controller.dart';
import 'package:prize_lottery_app/views/lottery/pages/kl8/trend/kl8_bos_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/kl8/trend/kl8_kua_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/kl8/trend/kl8_odd_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/kl8/trend/kl8_sum_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/kl8/trend/kl8_trend_view.dart';
import 'package:prize_lottery_app/views/lottery/utils/trend_constants.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';
import 'package:prize_lottery_app/widgets/lottery_hint_widget.dart';

class Kl8NumberTrendView extends StatefulWidget {
  const Kl8NumberTrendView({super.key});

  @override
  State<Kl8NumberTrendView> createState() => _Kl8NumberTrendViewState();
}

class _Kl8NumberTrendViewState extends State<Kl8NumberTrendView>
    with TickerProviderStateMixin {
  ///
  ///
  late TabController tabController;

  ///tab选项卡
  List<Widget> tabs = [
    Container(
      height: trendTabBarHeight,
      alignment: Alignment.center,
      child: const Text('基础走势'),
    ),
    Container(
      height: trendTabBarHeight,
      alignment: Alignment.center,
      child: const Text('和值分布'),
    ),
    Container(
      height: trendTabBarHeight,
      alignment: Alignment.center,
      child: const Text('跨度分布'),
    ),
    Container(
      height: trendTabBarHeight,
      alignment: Alignment.center,
      child: const Text('奇偶分布'),
    ),
    Container(
      height: trendTabBarHeight,
      alignment: Alignment.center,
      child: const Text('大小分布'),
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
        child: RequestWidget<Kl8NumberTrendController>(
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTabBar(),
                _buildTabView(controller, rows),
                _buildBottomHint(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      height: trendTabBarHeight,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 8.w, right: 32.w),
      child: TabBar(
        tabs: tabs,
        dividerHeight: 0,
        tabAlignment: TabAlignment.start,
        controller: tabController,
        labelPadding: EdgeInsets.only(left: 4.w, right: 4.w),
        isScrollable: true,
        labelColor: const Color(0xFFEF3454),
        unselectedLabelColor: Colors.black87,
        unselectedLabelStyle:
            TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
        labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        indicator: const BoxDecoration(),
      ),
    );
  }

  Widget _buildTabView(Kl8NumberTrendController controller, int rows) {
    return SizedBox(
      height: trendCellSize * rows + 2.w,
      child: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Kl8TrendView(
              rows: rows, omits: controller.omits, census: controller.census),
          Kl8SumView(
              rows: rows, omits: controller.omits, census: controller.census),
          Kl8KuaView(
              rows: rows, omits: controller.omits, census: controller.census),
          Kl8OddView(
              rows: rows, omits: controller.omits, census: controller.census),
          Kl8BosView(
              rows: rows, omits: controller.omits, census: controller.census),
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
