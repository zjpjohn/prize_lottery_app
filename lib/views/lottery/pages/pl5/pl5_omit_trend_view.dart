import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/views/lottery/pages/pl5/omit/pl5_kua_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/pl5/omit/pl5_state_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/pl5/omit/pl5_sum_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/pl5/omit/pl5_trend_view.dart';
import 'package:prize_lottery_app/views/lottery/utils/trend_constants.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class Pl5OmitTrendView extends StatefulWidget {
  const Pl5OmitTrendView({super.key});

  @override
  State<Pl5OmitTrendView> createState() => _Pl5OmitTrendViewState();
}

class _Pl5OmitTrendViewState extends State<Pl5OmitTrendView>
    with TickerProviderStateMixin {
  ///
  late TabController tabController;

  ///tab选项卡
  List<Widget> tabs = [
    Container(
      height: trendTabBarHeight,
      alignment: Alignment.center,
      child: const Text('基本走势'),
    ),
    Container(
      height: trendTabBarHeight,
      alignment: Alignment.center,
      child: const Text('号码分布'),
    ),
    Container(
      height: trendTabBarHeight,
      alignment: Alignment.center,
      child: const Text('和值走势'),
    ),
    Container(
      height: trendTabBarHeight,
      alignment: Alignment.center,
      child: const Text('跨度走势'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double top = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height;
    double blockHeight = height - top - 44.h - 34.h - 32.h;
    int rows = blockHeight ~/ trendCellSize;
    return LayoutContainer(
      title: '选号走势',
      right: GestureDetector(
        onTap: () {
          Get.toNamed('/pl5/item/1');
        },
        behavior: HitTestBehavior.opaque,
        child: Text(
          '分位走势',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 15.sp,
          ),
        ),
      ),
      content: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTabBar(),
            _buildTabView(height - top - 44.h - 34.h, rows),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      height: trendTabBarHeight,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 10.w),
      child: TabBar(
        tabs: tabs,
        isScrollable: true,
        dividerHeight: 0,
        tabAlignment: TabAlignment.start,
        controller: tabController,
        labelPadding: EdgeInsets.only(left: 5.w, right: 5.w),
        labelColor: const Color(0xFFEF3454),
        unselectedLabelColor: Colors.black87,
        unselectedLabelStyle:
            TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
        labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        indicator: const BoxDecoration(),
      ),
    );
  }

  Widget _buildTabView(double height, int rows) {
    return SizedBox(
      height: height,
      child: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Pl5TrendView(rows: rows),
          Pl5StateView(rows: rows),
          Pl5SumView(rows: rows),
          Pl5KuaView(rows: rows),
        ],
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
