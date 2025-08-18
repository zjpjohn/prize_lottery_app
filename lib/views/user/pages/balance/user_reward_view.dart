import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:prize_lottery_app/store/balance.dart';
import 'package:prize_lottery_app/store/store.dart';
import 'package:prize_lottery_app/views/user/model/user_balance.dart';
import 'package:prize_lottery_app/views/user/pages/balance/reward_consume_view.dart';
import 'package:prize_lottery_app/views/user/pages/balance/reward_obtain_view.dart';
import 'package:prize_lottery_app/views/user/pages/balance/reward_withdraw_view.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:prize_lottery_app/widgets/custom_tab_indicator.dart';

class UserRewardView extends StatefulWidget {
  ///
  ///
  const UserRewardView({super.key});

  @override
  UserRewardViewState createState() => UserRewardViewState();
}

class UserRewardViewState extends State<UserRewardView>
    with TickerProviderStateMixin {
  ///
  ///
  List<Widget> tabs = [
    Container(
      height: 26.w,
      alignment: Alignment.center,
      child: const Text('已获得'),
    ),
    Container(
      height: 26.w,
      alignment: Alignment.center,
      child: const Text('已提现'),
    ),
    Container(
      height: 26.w,
      alignment: Alignment.center,
      child: const Text('已消费'),
    ),
  ];

  ///
  ///
  List<Widget> views = [
    const RewardObtainView(),
    const RewardWithdrawView(),
    const RewardConsumeView(),
  ];

  ///
  ///
  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: CustomScrollBehavior(),
      child: ExtendedNestedScrollView(
        onlyOneScrollInBody: true,
        headerSliverBuilder: (context, scrolled) {
          return [
            SliverToBoxAdapter(child: _buildHintView()),
            SliverToBoxAdapter(child: _buildRewardPanel()),
          ];
        },
        body: _buildHistoryPanel(),
      ),
    );
  }

  Widget _buildHintView() {
    return Container(
      margin: EdgeInsets.only(top: 12.sp, bottom: 12.sp),
      padding: EdgeInsets.only(left: 16.sp),
      alignment: Alignment.centerLeft,
      child: Text(
        '1元=1000奖励金，奖励金可提现也可付费查看推荐',
        style: TextStyle(
          color: Colors.black26,
          fontSize: 12.sp,
        ),
      ),
    );
  }

  Widget _buildRewardPanel() {
    return Container(
      margin: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 16.w),
      padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: GetBuilder<BalanceInstance>(builder: (store) {
        UserBalance? balance = store.balance;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 2.w),
                    child: Text(
                      '${balance != null ? balance.balance : 0}',
                      style: TextStyle(
                        fontSize: 24.sp,
                        color: Colors.black87,
                        fontFamily: 'bebas',
                      ),
                    ),
                  ),
                  Text(
                    '奖励金',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black38,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (balance == null) {
                    EasyLoading.showToast('账户无权提现');
                    return;
                  }

                  ///提现校验及跳转提现页面
                  balance.withdrawAction();
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 88.w,
                    height: 30.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFd4A68),
                      borderRadius: BorderRadius.circular(20.w),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0xFFFd4A68).withValues(alpha: 0.4),
                            offset: const Offset(4, 4),
                            blurRadius: 8,
                            spreadRadius: 0.0)
                      ],
                    ),
                    child: Text(
                      '去提现',
                      style: TextStyle(fontSize: 15.sp, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildHistoryPanel() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black12, width: 0.25.w),
              ),
            ),
            child: _buildTabBar(),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: views,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 12.w),
      width: 198.w,
      child: TabBar(
        tabs: tabs,
        controller: _tabController,
        labelPadding: EdgeInsets.only(left: 2.w, right: 2.w),
        isScrollable: false,
        dividerHeight: 0,
        labelColor: const Color(0xFFEF3454),
        unselectedLabelColor: Colors.black,
        labelStyle: TextStyle(fontSize: 14.sp),
        indicator: CustomTabIndicator(
          ratio: 0.20,
          borderSide: BorderSide(color: const Color(0xFFEF3454), width: 1.4.w),
        ),
      ),
    );
  }

  @override
  void initState() {
    BalanceInstance().refreshBalance();
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
