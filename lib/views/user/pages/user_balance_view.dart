import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/views/user/pages/balance/user_reward_view.dart';
import 'package:prize_lottery_app/views/user/pages/balance/user_surplus_view.dart';
import 'package:prize_lottery_app/widgets/custom_tab_indicator.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class UserBalanceView extends StatefulWidget {
  ///
  ///
  const UserBalanceView({super.key});

  @override
  UserBalanceViewState createState() => UserBalanceViewState();
}

class UserBalanceViewState extends State<UserBalanceView>
    with TickerProviderStateMixin {
  ///
  ///tab选项卡
  List<Widget> tabs = [
    Container(
      height: 26.w,
      alignment: Alignment.center,
      child: const Text('奖励金'),
    ),
    Container(
      height: 26.w,
      alignment: Alignment.center,
      child: const Text('金币'),
    )
  ];

  ///
  ///tab选项页面
  List<Widget> views = [const UserRewardView(), const UserSurplusView()];

  ///
  ///TabBar控制器
  late TabController tabController;

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      header: _buildTabBar(),
      content: Container(
        color: const Color(0xFFF6F6F6),
        child: TabBarView(
          controller: tabController,
          children: views,
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: 136.w,
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(20.w),
        ),
        child: TabBar(
          tabs: tabs,
          controller: tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          labelPadding: EdgeInsets.symmetric(horizontal: 8.w),
          isScrollable: false,
          dividerHeight: 0,
          labelColor: const Color(0xFFEF3454),
          unselectedLabelColor: const Color(0xCC000000),
          labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
          indicator: CustomRRecTabIndicator(
            radius: 20.w,
            color: const Color(0xFFFFE7E7).withValues(alpha: 0.75),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: int.parse(Get.parameters['index'] ?? '0'),
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
