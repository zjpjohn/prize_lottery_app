import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChannelScrollView extends StatefulWidget {
  ///
  ///
  final List<Widget> channels;

  const ChannelScrollView({super.key, required this.channels});

  @override
  ChannelScrollViewState createState() => ChannelScrollViewState();
}

class ChannelScrollViewState extends State<ChannelScrollView> {
  ///滚动组件Key
  final GlobalKey _scrollKey = GlobalKey();

  ///内容组件Key
  final GlobalKey _contentKey = GlobalKey();

  ///
  final GlobalKey _wrapKey = GlobalKey();

  ///
  final GlobalKey _indicatorKey = GlobalKey();

  ///滚动控制器
  late ScrollController _scrollController;

  ///动画控制器
  late AnimationController _controller;

  ///
  late StreamController<double> _streamController;

  late double contentWidth;
  late double scrollWidth;
  late double wrapperWidth;
  late double indicatorWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          key: _scrollKey,
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          child: Row(
            key: _contentKey,
            children: [
              ...widget.channels,
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 12.w),
          child: Stack(
            children: [
              Container(
                key: _wrapKey,
                width: 24.w,
                height: 3.w,
                decoration: BoxDecoration(
                  color: Colors.black12.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(3.w),
                ),
              ),
              StreamBuilder<double>(
                initialData: 0,
                stream: _streamController.stream,
                builder: (context, snapshot) {
                  double offset = snapshot.data ?? 0;
                  double left = offset == 0
                      ? 0
                      : offset *
                          (wrapperWidth - indicatorWidth) /
                          (contentWidth - scrollWidth);
                  return Positioned(
                    key: _indicatorKey,
                    left: left,
                    top: 0,
                    child: Container(
                      width: 12.w,
                      height: 3.w,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(3.w),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _streamController = StreamController();
    _scrollController.addListener(() {
      _streamController.sink.add(_scrollController.offset);
    });
    _controller = AnimationController(
      vsync: ScrollableState(),
      duration: const Duration(milliseconds: 1000),
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      contentWidth = _contentKey.currentContext!.size!.width;
      scrollWidth = _scrollKey.currentContext!.size!.width;
      wrapperWidth = _wrapKey.currentContext!.size!.width;
      indicatorWidth = _indicatorKey.currentContext!.size!.width;
      Animation<double> scrollAnimation = Tween<double>(
        begin: _scrollController.position.minScrollExtent,
        end: _scrollController.position.maxScrollExtent,
      ).animate(_controller);
      _controller
        ..addListener(() {
          _scrollController.jumpTo(scrollAnimation.value);
        })
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            _controller.reverse();
          }
        });
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _streamController.close();
    _controller.dispose();
    super.dispose();
  }
}
