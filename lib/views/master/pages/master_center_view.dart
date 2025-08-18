import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/env/env_profile.dart';
import 'package:prize_lottery_app/resources/colors.dart';
import 'package:prize_lottery_app/resources/styles.dart';
import 'package:prize_lottery_app/views/master/pages/center/dlt_master_view.dart';
import 'package:prize_lottery_app/views/master/pages/center/fc3d_master_view.dart';
import 'package:prize_lottery_app/views/master/pages/center/focus_master_view.dart';
import 'package:prize_lottery_app/views/master/pages/center/pl3_master_view.dart';
import 'package:prize_lottery_app/views/master/pages/center/qlc_master_view.dart';
import 'package:prize_lottery_app/views/master/pages/center/ssq_master_view.dart';
import 'package:prize_lottery_app/views/master/widgets/search_header.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';

class MasterCenterView extends StatefulWidget {
  ///
  ///
  const MasterCenterView({super.key});

  @override
  MasterCenterViewState createState() => MasterCenterViewState();
}

class MasterCenterViewState extends State<MasterCenterView>
    with TickerProviderStateMixin {
  ///
  /// tab选项
  final List<String> _tabs = [
    '关 注',
    '双色球',
    '大乐透',
    '福彩3D',
    '排列三',
    '七乐彩',
  ];

  ///
  /// tab选项页面
  final List<Widget> _pages = [
    const FocusMasterView(),
    const SsqMasterView(),
    const DltMasterView(),
    const Fc3dMasterView(),
    const Pl3MasterView(),
    const QlcMasterView(),
  ];

  ///
  ///
  List<List<Color>> gradients = [
    mRecomColors,
    mSsqColors,
    mDltColors,
    mFc3dColors,
    mPl3Colors,
    mQlcColors,
  ];

  late List<Color> colors;

  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: UiStyle.light,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              height: 160.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: colors,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: ScrollConfiguration(
                behavior: CustomScrollBehavior(),
                child: ExtendedNestedScrollView(
                  onlyOneScrollInBody: true,
                  pinnedHeaderSliverHeightBuilder: () => 38.w,
                  headerSliverBuilder: (context, scrolled) {
                    return [
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: SearchHeader(
                          title: Profile.props.appName,
                          masters: 2000,
                        ),
                      ),
                    ];
                  },
                  body: Column(
                    children: [
                      SizedBox(
                        height: 36.w,
                        child: _buildScrollTabBar(),
                      ),
                      Expanded(
                        child: _buildTabBarView(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      physics: const NeverScrollableScrollPhysics(),
      children: _pages,
    );
  }

  Widget _buildScrollTabBar() {
    return Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w),
      child: TabBar(
        tabs: _buildTabBarTabs(),
        controller: _tabController,
        labelColor: Colors.white,
        dividerHeight: 0,
        tabAlignment: TabAlignment.start,
        unselectedLabelColor: Colors.white70,
        labelPadding: EdgeInsets.symmetric(horizontal: 0.w),
        isScrollable: true,
        labelStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
        ),
        indicator: const BoxDecoration(),
      ),
    );
  }

  List<Widget> _buildTabBarTabs() {
    return _tabs
        .asMap()
        .map(
          (key, value) => MapEntry(
            key,
            Container(
              height: 28.w,
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                left: 6.w,
                right: key < _tabs.length - 1 ? 6.w : 12.w,
              ),
              child: Text(value),
            ),
          ),
        )
        .values
        .toList();
  }

  void _initialTabBar() {
    colors = gradients[0];
    _tabController =
        TabController(initialIndex: 0, length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.index == _tabController.animation!.value) {
        if (mounted) {
          setState(() {
            colors = gradients[_tabController.index];
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _initialTabBar();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
