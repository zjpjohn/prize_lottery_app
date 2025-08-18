import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/views/pay/pages/order_list_view.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class OrderCenterView extends StatefulWidget {
  const OrderCenterView({super.key});

  @override
  State<OrderCenterView> createState() => _OrderCenterViewState();
}

class _OrderCenterViewState extends State<OrderCenterView>
    with TickerProviderStateMixin {
  ///
  late TabController tabController;

  ///tab选项卡
  List<Widget> tabs = [
    Container(
      height: 40.h,
      alignment: Alignment.center,
      child: const Text('会员订单'),
    ),
    Container(
      height: 40.h,
      alignment: Alignment.center,
      child: const Text('充值订单'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '订单中心',
      content: Container(
        color: Colors.white,
        child: Column(
          children: [
            _buildTabBar(),
            Expanded(child: _buildTabView()),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      height: 40.h,
      alignment: Alignment.center,
      color: Colors.white,
      child: SizedBox(
        width: 250.h,
        child: TabBar(
          tabs: tabs,
          controller: tabController,
          dividerHeight: 0,
          labelPadding: EdgeInsets.only(left: 4.w, right: 4.w),
          isScrollable: false,
          labelColor: const Color(0xFFEF3454),
          unselectedLabelColor: Colors.black87,
          unselectedLabelStyle:
              TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
          labelStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
          indicator: const BoxDecoration(),
        ),
      ),
    );
  }

  Widget _buildTabView() {
    return TabBarView(
      controller: tabController,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        OrderListView(type: 1),
        OrderListView(type: 2),
      ],
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
}
