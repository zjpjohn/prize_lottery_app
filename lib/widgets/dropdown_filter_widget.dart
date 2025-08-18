import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/widgets/tab_filter_view.dart';

class DropdownFilterContainer extends StatefulWidget {
  ///
  final String? title;

  ///
  final Widget? header;

  ///
  ///初始选项值
  final int initialIndex;

  ///
  /// tab选项卡集合
  final List<TabEntry> entries;

  ///
  /// 选中回调操作
  final TabSelectedHandle onSelected;

  ///
  ///
  final Widget child;

  ///
  final bool nested;

  DropdownFilterContainer({
    super.key,
    this.initialIndex = 0,
    this.title,
    this.header,
    this.nested = false,
    required this.entries,
    required this.onSelected,
    required this.child,
  })  : assert(entries.isNotEmpty),
        assert(title != null || header != null),
        assert(initialIndex >= 0);

  @override
  DropdownFilterContainerState createState() => DropdownFilterContainerState();
}

class DropdownFilterContainerState extends State<DropdownFilterContainer>
    with SingleTickerProviderStateMixin {
  ///
  /// 是否展开
  bool _expanded = false;

  ///
  /// 背景层是否影藏
  bool _hide = true;

  ///
  /// 背景层透明度
  double _opacity = 0.0;

  ///
  /// 展开面板高度
  double _height = 0.0;

  ///
  /// 当前选中的tab标识
  late int _current;

  ///
  /// tab面板组件可Key
  final GlobalKey _panelKey = GlobalKey();

  ///
  ///补间动画
  late Animation<double> _animation;

  ///
  /// 动画控制器
  late AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.header != null
                  ? widget.header!
                  : Text(
                      widget.title!,
                      style: TextStyle(
                        fontSize: 17.sp,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    ///点击展开或收起
                    _expanded = !_expanded;

                    ///设置面板高度
                    _height =
                        _expanded ? _panelKey.currentContext!.size!.height : 0;

                    ///展开或收起动画
                    if (_expanded) {
                      _controller.forward();
                      return;
                    }
                    _controller.reverse();
                  });
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.w,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F8F8),
                    borderRadius: BorderRadius.circular(4.w),
                  ),
                  child: Row(
                    children: [
                      Text(
                        widget.entries[_current].value,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14.sp,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 2.w),
                        child: Icon(
                          IconData(
                            _expanded ? 0xe639 : 0xe653,
                            fontFamily: 'iconfont',
                          ),
                          size: 12.sp,
                          color: Colors.black26,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        _childContent(),
      ],
    );
  }

  Widget _childContent() {
    Widget content = Stack(
      children: [
        widget.child,
        Stack(
          alignment: Alignment.topCenter,
          children: [
            _panelBackground(),
            _panelContent(),
          ],
        ),
      ],
    );
    if (widget.nested) {
      return Expanded(
        child: content,
      );
    }
    return content;
  }

  ///
  /// tab展开面板背景层
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
              setState(() {
                _height = 0;
                _expanded = false;
                _controller.reverse();
              });
            },
            child: Container(
              color: Colors.black26,
              height: 750.w,
            ),
          ),
        ),
      ),
    );
  }

  ///
  /// tab展开面板内容层
  Widget _panelContent() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: _height,
      curve: Curves.linear,
      width: double.infinity,
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
          padding: EdgeInsets.only(left: 8.w, right: 8.w),
          decoration: BoxDecoration(
            border: Border(
              top: _expanded
                  ? BorderSide(color: Colors.black12, width: 0.25.w)
                  : BorderSide.none,
            ),
          ),
          child: Container(
            padding: EdgeInsets.only(top: 16.w, bottom: 24.w),
            child: GridView.count(
              crossAxisCount: 4,
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 5.w,
              childAspectRatio: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: _buildPanelTabs(),
            ),
          ),
        ),
      ),
    );
  }

  ///
  /// tab展开面板选项集合
  List<Widget> _buildPanelTabs() {
    List<Widget> items = [];
    for (int i = 0; i < widget.entries.length; i++) {
      items.add(
        GestureDetector(
          onTap: () {
            setState(() {
              _expanded = false;
              _height = 0;
              _controller.reverse();
            });
            _handleTabControllerClick(i);
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _current == i ? Colors.red : Colors.white,
              borderRadius: BorderRadius.circular(30.w),
            ),
            child: Text(
              widget.entries[i].value,
              style: TextStyle(
                fontSize: 14.sp,
                color: _current == i ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ),
      );
    }
    return items;
  }

  ///
  /// 处理点击tab选项
  void _handleTabControllerClick(int index) {
    if (_current != index) {
      setState(() {
        _current = index;
        widget.onSelected(index, widget.entries[index]);
      });
    }
  }

  void _initAnimation() {
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
        if (_expanded && status == AnimationStatus.forward) {
          setState(() {
            _hide = false;
          });
        } else if (status == AnimationStatus.dismissed) {
          setState(() {
            _hide = !_hide;
          });
        }
      });
  }

  @override
  void initState() {
    super.initState();
    _current = widget.initialIndex;
    _initAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
