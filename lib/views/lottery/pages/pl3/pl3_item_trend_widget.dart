import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/views/lottery/controller/lottery_item_omit_controller.dart';
import 'package:prize_lottery_app/views/lottery/utils/trend_constants.dart';
import 'package:prize_lottery_app/views/lottery/widgets/item_omit_widget.dart';
import 'package:prize_lottery_app/views/lottery/widgets/page_query_widget.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class Pl3ItemTrendWidget extends StatefulWidget {
  const Pl3ItemTrendWidget({super.key});

  @override
  State<Pl3ItemTrendWidget> createState() => _Pl3ItemTrendWidgetState();
}

class _Pl3ItemTrendWidgetState extends State<Pl3ItemTrendWidget>
    with TickerProviderStateMixin {
  ///
  late TabController tabController;

  ///tab选项卡
  List<Widget> tabs = [
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
    Get.put(LotteryItemOmitController('pl3'));
    return LayoutContainer(
      title: '分位走势',
      content: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTabBar(),
            _buildTabView(rows),
            GetBuilder<LotteryItemOmitController>(
              builder: (controller) {
                return PageQueryWidget(
                  page: controller.size,
                  toMaster: 'pl3/mul_rank',
                  onTap: (size) {
                    controller.size = size;
                  },
                );
              },
            ),
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
      height: rows * trendCellSize,
      child: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ItemOmitWidget(type: 1, rows: rows),
          ItemOmitWidget(type: 2, rows: rows),
          ItemOmitWidget(type: 3, rows: rows),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
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
