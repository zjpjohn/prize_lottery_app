import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/views/rank/widgets/channel_tab_indicator.dart';
import 'package:prize_lottery_app/widgets/tab_filter_view.dart';

///
typedef OnTabTap = void Function(int index);

///
typedef OnPanelTap = void Function(bool expanded);

class ChannelTabLayout extends StatelessWidget {
  ///
  const ChannelTabLayout({
    super.key,
    required this.tabs,
    required this.tabTap,
    required this.panelTap,
    required this.expanded,
    required this.tabController,
    required this.margin,
    this.packUpRadius,
    this.packUpShadow,
    this.expandRadius,
    this.expandShadow,
    this.padding,
  });

  ///
  final bool expanded;

  ///
  final OnTabTap tabTap;

  ///
  final OnPanelTap panelTap;

  ///
  final List<TabEntry> tabs;

  ///
  final TabController tabController;

  ///
  final EdgeInsets margin;

  ///
  final EdgeInsets? padding;

  ///
  final BorderRadius? packUpRadius;

  ///收起时shadow
  final List<BoxShadow>? packUpShadow;

  ///
  final BorderRadius? expandRadius;

  ///展开时shadow
  final List<BoxShadow>? expandShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin,
      child: expanded ? _buildExpandedView() : _buildPackUpView(),
    );
  }

  Widget _buildExpandedView() {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: expandRadius,
        boxShadow: expandShadow,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 45.h,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: const Color(0xFFEAEAEA),
                  width: 0.4.h,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15.h),
                  child: Text(
                    '全部频道',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    panelTap(!expanded);
                  },
                  child: Container(
                    width: 48.h,
                    alignment: Alignment.center,
                    child: const Icon(Icons.keyboard_arrow_up),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 12.h,
              bottom: 24.h,
              left: 6.h,
              right: 6.h,
            ),
            child: GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
              childAspectRatio: 3.2,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 10.h),
              children: _buildPanelItems(),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildPanelItems() {
    List<Widget> items = [];
    for (int i = 0; i < tabs.length; i++) {
      TabEntry tab = tabs[i];
      items.add(
        GestureDetector(
          onTap: () {
            panelTap(!expanded);
            tabTap(i);
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: tabController.index == i ? Colors.red : Colors.white,
            ),
            child: Text(
              tab.value,
              style: TextStyle(
                fontSize: 15.sp,
                color: tabController.index == i ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ),
      );
    }
    return items;
  }

  Widget _buildPackUpView() {
    return Container(
      height: 46.h,
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: packUpRadius,
        boxShadow: packUpShadow,
      ),
      child: Stack(
        children: [
          _buildTabBarView(),
          Positioned(
            width: 16.h,
            right: 48.h,
            top: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0x9AFFFFFF),
                    Colors.white,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            width: 48.h,
            child: GestureDetector(
              onTap: () {
                panelTap(!expanded);
              },
              child: Icon(
                expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBarView() {
    return Container(
      margin: EdgeInsets.only(right: 48.h),
      padding: EdgeInsets.only(left: 8.h),
      child: TabBar(
        tabs: _buildTabBarTabs(),
        controller: tabController,
        dividerHeight: 0,
        tabAlignment: TabAlignment.start,
        indicatorPadding: EdgeInsets.only(bottom: 10.h),
        indicator: ChannelTabIndicator(
          width: 10.h,
          borderSide: BorderSide(width: 2.h, color: Colors.redAccent),
        ),
        labelPadding: EdgeInsets.zero,
        indicatorColor: Colors.red,
        unselectedLabelColor: Colors.black,
        labelColor: Colors.red,
        isScrollable: true,
      ),
    );
  }

  List<Widget> _buildTabBarTabs() {
    List<Widget> tabList = [];
    for (int i = 0; i < tabs.length; i++) {
      TabEntry tab = tabs[i];
      tabList.add(
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 6.h),
          child: Text(
            tab.value,
            style: TextStyle(
              fontSize: 15.5.sp,
              fontWeight: FontWeight.w500,
              color: tabController.index == i ? Colors.red : Colors.black87,
            ),
          ),
        ),
      );
    }
    return tabList;
  }
}
