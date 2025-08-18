import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/widgets/custom_tab_indicator.dart';

typedef TabChangeHandle = Function(int index);

class TabBarContainer extends StatefulWidget {
  ///
  ///
  const TabBarContainer({
    super.key,
    this.initialIndex = 0,
    this.onChange,
    this.labelColor,
    this.unselectedLabelColor,
    required this.tabs,
    required this.pages,
    required this.moreIcon,
    required this.tabHeight,
    required this.labeledStyle,
    required this.unselectedStyle,
    this.bottom = BorderSide.none,
  })  : assert(initialIndex >= 0),
        assert(tabs.length == pages.length);

  ///
  /// 初始选项
  final int initialIndex;

  ///
  /// TabBar栏高度
  final double tabHeight;

  ///
  ///
  final Color? labelColor;

  ///
  ///
  final Color? unselectedLabelColor;

  ///
  /// tab选中文字样式
  final TextStyle labeledStyle;

  ///
  /// tab未选中文字样式
  final TextStyle unselectedStyle;

  ///
  /// tab选项集合
  final List<String> tabs;

  ///
  /// 页面集合
  final List<Widget> pages;

  ///
  /// 更多选项icon
  final Icon moreIcon;

  ///
  /// 底部边框
  final BorderSide bottom;

  ///
  /// tab变化监听
  final TabChangeHandle? onChange;

  @override
  TabBarContainerState createState() => TabBarContainerState();
}

class TabBarContainerState extends State<TabBarContainer>
    with TickerProviderStateMixin {
  ///
  /// 是否展开
  bool _expanded = false;

  ///
  /// 背景是否隐藏
  bool _hide = true;

  ///
  /// 背景透明度
  double _opacity = 0.0;

  ///
  /// 展开面板高度
  double _height = 0.0;

  ///
  /// 面板全局标识
  final GlobalKey _panelKey = GlobalKey();

  ///
  /// 当前选中下标
  late int _current;

  ///
  ///补间动画
  late Animation<double> _animation;

  ///
  /// 动画控制器
  late AnimationController _controller;

  ///
  /// TabBar控制器
  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: widget.tabHeight,
          decoration: BoxDecoration(
            border: Border(
              bottom: widget.bottom,
            ),
          ),
          alignment: Alignment.center,
          child: Stack(
            children: [
              _scrollTabBar(),
              Positioned(
                right: 36.w,
                top: 0,
                bottom: 0,
                child: Opacity(
                  opacity: 0.20,
                  child: Container(
                    width: 6.w,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white24,
                          Colors.white12,
                          Colors.white10,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                width: 36.w,
                child: _moreTabBtn(),
              ),
            ],
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              _tabBarView(),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  _panelBackground(),
                  _panelContent(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _scrollTabBar() {
    return Container(
      margin: EdgeInsets.only(right: 36.w),
      padding: EdgeInsets.only(left: 10.w),
      child: TabBar(
        tabs: _buildTabBarTabs(),
        controller: _tabController,
        labelColor: widget.labelColor,
        dividerHeight: 0,
        tabAlignment: TabAlignment.start,
        unselectedLabelColor: widget.unselectedLabelColor,
        labelPadding: EdgeInsets.symmetric(horizontal: 0.w),
        isScrollable: true,
        labelStyle: widget.labeledStyle,
        unselectedLabelStyle: widget.unselectedStyle,
        indicator: ArcUnderlineIndicator(
          width: 16.w,
          height: 16.w,
          angle: 0.833 * pi,
        ),
        onTap: (index) {
          ///面板已经展开，点击tab要收缩面板
          if (mounted && _expanded) {
            setState(() {
              _height = 0;
              _expanded = !_expanded;
            });
            _controller.reverse();
          }
        },
      ),
    );
  }

  List<Widget> _buildTabBarTabs() {
    List<Widget> views = [];
    for (int i = 0; i < widget.tabs.length; i++) {
      String e = widget.tabs[i];
      views.add(
        Container(
          height: 30.w,
          alignment: Alignment.center,
          padding: EdgeInsets.only(
            left: 6.w,
            right: i < widget.tabs.length - 1 ? 6.w : 14.w,
          ),
          child: Text(e),
        ),
      );
    }
    return views;
  }

  Widget _moreTabBtn() {
    return GestureDetector(
      onTap: () {
        setState(() {
          /// 单机展开或收起
          _expanded = !_expanded;

          ///设置面板高度
          _height = _expanded ? _panelKey.currentContext!.size!.height : 0;

          ///展开收起动画
          if (_expanded) {
            _controller.forward();
            return;
          }
          _controller.reverse();
        });
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 36.w,
        height: widget.tabHeight,
        alignment: Alignment.center,
        child: widget.moreIcon,
      ),
    );
  }

  ///
  /// TabBarView
  ///
  Widget _tabBarView() {
    return TabBarView(
      controller: _tabController,
      physics: const NeverScrollableScrollPhysics(),
      children: widget.pages,
    );
  }

  ///
  /// 展开面板背景
  ///
  Widget _panelBackground() {
    return Offstage(
      offstage: _hide,
      child: Opacity(
        opacity: _opacity,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _height = 0;
                _expanded = false;
                _controller.reverse();
              });
            },
            onVerticalDragStart: (drag) {
              _height = 0;
              _expanded = false;
              _controller.reverse();
            },
            child: Container(
              color: Colors.black12.withValues(alpha: 0.15),
            ),
          ),
        ),
      ),
    );
  }

  ///
  /// 展开面板内容
  ///
  Widget _panelContent() {
    return AnimatedContainer(
      height: _height,
      width: double.infinity,
      curve: Curves.linear,
      duration: const Duration(milliseconds: 300),
      constraints: const BoxConstraints(minWidth: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8.w),
          bottomRight: Radius.circular(8.w),
        ),
      ),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          key: _panelKey,
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 16.w),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 8.w),
                child: Text(
                  '全部频道',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 12.w, bottom: 24.w),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 5.w,
                  childAspectRatio: 3,
                  physics: const NeverScrollableScrollPhysics(),
                  children: _buildPanelTabs(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  /// 选项面板选项集合
  ///
  List<Widget> _buildPanelTabs() {
    List<Widget> items = [];
    for (int i = 0; i < widget.tabs.length; i++) {
      items.add(GestureDetector(
        onTap: () {
          setState(() {
            _expanded = false;
            _height = 0;
            _controller.reverse();
            if (_current != i) {
              _current = i;
              _tabController.index = i;
            }
          });
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _current == i ? Colors.red : Colors.white,
            borderRadius: BorderRadius.circular(30.w),
          ),
          child: Text(
            widget.tabs[i],
            style: TextStyle(
              fontSize: 15.sp,
              color: _current == i ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ));
    }
    return items;
  }

  ///
  ///初始化TabBar及动画
  ///
  void _initTabBar() {
    _current = widget.initialIndex;
    _tabController = TabController(
      initialIndex: widget.initialIndex,
      length: widget.tabs.length,
      vsync: this,
    );
    _tabController.addListener(() {
      if (_tabController.index == _tabController.animation!.value) {
        setState(() {
          _current = _tabController.index;
        });
        if (widget.onChange != null) {
          widget.onChange!(_tabController.index);
        }
      }
    });
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _opacity = _animation.value;
        });
      })
      ..addStatusListener((status) {
        /// 面板展开
        if (_expanded && status == AnimationStatus.forward) {
          setState(() {
            _hide = false;
          });
        } else if (status == AnimationStatus.dismissed) {
          ///面板收缩
          setState(() {
            _hide = !_hide;
          });
        }
      });
  }

  @override
  void initState() {
    super.initState();
    _initTabBar();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controller.dispose();
    super.dispose();
  }
}
