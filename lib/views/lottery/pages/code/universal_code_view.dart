import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/views/lottery/pages/code/lottery_code_view.dart';
import 'package:prize_lottery_app/views/lottery/utils/trend_constants.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class UniversalCodeView extends StatefulWidget {
  const UniversalCodeView({super.key});

  @override
  State<UniversalCodeView> createState() => _UniversalCodeViewState();
}

class _UniversalCodeViewState extends State<UniversalCodeView>
    with TickerProviderStateMixin {
  ///
  /// 彩票种类
  late String lotto;

  ///
  late TabController tabController;

  ///tab选项卡
  List<Widget> tabs = [
    Container(
      height: trendTabBarHeight,
      alignment: Alignment.center,
      child: const Text('万能四码'),
    ),
    Container(
      height: trendTabBarHeight,
      alignment: Alignment.center,
      child: const Text('万能五码'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double top = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height;
    double blockHeight = height - top - 44.h - 34.h - 82.h;
    int rows = blockHeight ~/ trendCellSize;
    return LayoutContainer(
      title: '万能选号',
      content: Container(
        color: Colors.white,
        child: Column(
          children: [
            _buildTabBar(),
            Expanded(
              child: _buildTabView(rows),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      width: trendN3TabBarWidth,
      height: trendTabBarHeight,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 10.w),
      child: TabBar(
        tabs: tabs,
        controller: tabController,
        labelPadding: EdgeInsets.only(left: 4.w, right: 4.w),
        isScrollable: false,
        dividerHeight: 0,
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
    return TabBarView(
      controller: tabController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        LotteryCodeView(rows: rows, lotto: lotto, type: 1),
        LotteryCodeView(rows: rows, lotto: lotto, type: 2),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    lotto = Get.parameters['lotto']!;
    tabController = TabController(
      initialIndex: 0,
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
