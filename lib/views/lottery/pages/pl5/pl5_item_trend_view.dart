import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/views/lottery/pages/pl5/omit/pl5_item_view.dart';
import 'package:prize_lottery_app/views/lottery/utils/trend_constants.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class Pl5ItemTrendView extends StatefulWidget {
  const Pl5ItemTrendView({super.key});

  @override
  State<Pl5ItemTrendView> createState() => _Pl5ItemTrendViewState();
}

class _Pl5ItemTrendViewState extends State<Pl5ItemTrendView>
    with TickerProviderStateMixin {
  ///
  late TabController tabController;

  ///tab选项卡
  List<Widget> tabs = [
    Container(
      height: trendTabBarHeight,
      alignment: Alignment.center,
      child: const Text('万位走势'),
    ),
    Container(
      height: trendTabBarHeight,
      alignment: Alignment.center,
      child: const Text('千位走势'),
    ),
    Container(
      height: trendTabBarHeight,
      alignment: Alignment.center,
      child: const Text('百位走势'),
    ),
    Container(
      height: trendTabBarHeight,
      alignment: Alignment.center,
      child: const Text('十位走势'),
    ),
    Container(
      height: trendTabBarHeight,
      alignment: Alignment.center,
      child: const Text('个位走势'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double top = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height;
    double blockHeight = height - top - 44.h - 34.h - 32.h;
    int rows = blockHeight ~/ trendCellSize;
    return LayoutContainer(
      title: '分位走势',
      content: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTabBar(),
            _buildTabView(rows),
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

  Widget _buildTabView(int rows) {
    return SizedBox(
      height: rows * trendCellSize + 32.h,
      child: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Pl5ItemView(type: 1, rows: rows),
          Pl5ItemView(type: 2, rows: rows),
          Pl5ItemView(type: 3, rows: rows),
          Pl5ItemView(type: 4, rows: rows),
          Pl5ItemView(type: 5, rows: rows),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: int.parse(Get.parameters['type'] ?? '1') - 1,
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
