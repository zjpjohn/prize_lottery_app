import 'package:flutter/material.dart';

typedef TabBuilder = Widget Function(int index);
typedef TabSelected = void Function(int index);

class ScrollableTabs extends StatefulWidget {
  const ScrollableTabs({
    super.key,
    this.initialIndex = 0,
    required this.length,
    required this.onSelected,
    required this.builder,
    this.crossAxisAlignment = CrossAxisAlignment.end,
  });

  ///
  ///初始选项值
  final int initialIndex;

  ///
  /// tab选项卡集合
  final int length;

  ///
  /// 选中回调操作
  final TabSelected onSelected;

  ///
  /// 选项卡构造器
  final TabBuilder builder;

  ///
  /// 垂直方向对齐
  final CrossAxisAlignment crossAxisAlignment;

  @override
  State<ScrollableTabs> createState() => _ScrollableTabsState();
}

class _ScrollableTabsState extends State<ScrollableTabs> {
  ///
  /// 当前选中的tab标识
  late int _current;

  ///
  /// 组件偏移量集合
  final List<double> _offsets = [];

  ///
  /// tab选项卡key集合
  List<GlobalKey> _keys = [];

  ///
  /// 活动控制器
  late ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [];
    for (int i = 0; i < widget.length; i++) {
      tabs.add(_buildTabItem(_keys[i], i));
    }
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: widget.crossAxisAlignment,
        children: tabs,
      ),
    );
  }

  ///
  /// tab选项卡组件
  Widget _buildTabItem(GlobalKey key, int index) {
    return GestureDetector(
      onTap: () {
        _handleTabControllerClick(index);
      },
      child: Container(
        key: key,
        child: widget.builder(index),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    /// 当前选中下标初始化
    _current = widget.initialIndex;

    ///初始化滚动组件
    _initTabScroll();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  ///
  /// 初始化
  void _initTabScroll() {
    ///设置各个tab选项卡key
    _keys = List.generate(widget.length, (index) => GlobalKey());

    ///初始化scroll控制器
    _scrollController = ScrollController();

    ///组件渲染完成后计算各tab选项卡宽度
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _saveWidgetOffsets();
      _scrollToCurrentIndex(_current);
    });
  }

  ///
  /// 保存tab选项卡各个绝对偏移量
  void _saveWidgetOffsets() {
    for (int i = 0; i < widget.length; i++) {
      _offsets.add(
          i == 0 ? 0 : _offsets[i - 1] + _keys[i].currentContext!.size!.width);
    }
  }

  ///
  /// 计算指定tab选项偏移坐标
  double centerOf(int index) {
    int idx = index < widget.length - 2 ? index : widget.length - 2;
    return (_offsets[idx] + _offsets[idx + 1]) / 2.0;
  }

  ///
  /// 计算tab选项滚动偏移量
  double tabScrollOffset(
      int index, double viewportWidth, double minExtent, double maxExtent) {
    return (centerOf(index) - viewportWidth / 2.0).clamp(minExtent, maxExtent);
  }

  ///
  /// 滚动到指定位置
  void _scrollToCurrentIndex(int index) {
    ScrollPosition position = _scrollController.position;
    double offset = tabScrollOffset(index, position.viewportDimension,
        position.minScrollExtent, position.maxScrollExtent);
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  ///
  /// 处理点击tab选项
  void _handleTabControllerClick(int index) {
    if (_current != index) {
      setState(() {
        _current = index;
        widget.onSelected(index);
      });
      _scrollToCurrentIndex(index);
    }
  }
}
