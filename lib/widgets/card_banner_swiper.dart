import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prize_lottery_app/widgets/cached_avatar.dart';

typedef ImageExtractor<T> = String Function(T data);
typedef BannerCurrentBuilder<T> = Widget Function(BuildContext, T);

class CardBannerSwiper<T> extends StatefulWidget {
  const CardBannerSwiper({
    super.key,
    required this.datas,
    required this.width,
    required this.height,
    this.radius = 3,
    required this.duration,
    required this.extractor,
    required this.builder,
  }) : assert(datas.length >= 4);

  final double width;
  final double height;
  final int duration;
  final double radius;
  final List<T> datas;
  final ImageExtractor<T> extractor;
  final BannerCurrentBuilder<T> builder;

  @override
  State<CardBannerSwiper<T>> createState() => _CardBannerSwiperState<T>();
}

const List<double> ratios = [1.44, 1.2, 1.0, 1.0];

class _CardBannerSwiperState<T> extends State<CardBannerSwiper<T>>
    with SingleTickerProviderStateMixin {
  ///
  /// 动画中的条目
  final List<T> _items = [];

  int _index = 4;

  ///
  late Timer _timer;

  ///动画控制器
  late AnimationController _controller;

  ///放大动画
  late Animation<double> _scaleAnimation;

  ///透明度动画
  late Animation<double> _opacityAnimation;

  ///左移动画
  late Animation<double> _leftAnimation;
  late Animation<double> _left1Animation;
  late Animation<double> _left2Animation;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: widget.width * 1.66,
          height: widget.height * 1.44,
          child: Stack(
            children: [
              _buildBanner3Item(),
              _buildBanner2Item(),
              _buildBanner1Item(),
              _buildBanner0Item(),
            ],
          ),
        ),
        Expanded(
          child: widget.builder(context, _items[0]),
        ),
      ],
    );
  }

  Widget _buildBanner0Item() {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Positioned(
            top: 0,
            left: 0 - _leftAnimation.value,
            child: CachedAvatar(
              radius: widget.radius,
              url: widget.extractor(_items[0]),
              width: widget.width * 1.44,
              height: widget.height * 1.44,
            ),
          );
        });
  }

  Widget _buildBanner1Item() {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Positioned(
            top: 0.12 * widget.height,
            left: 0.34 * widget.width - _left1Animation.value,
            child: ScaleTransition(
              scale: _scaleAnimation,
              alignment: Alignment.centerRight,
              child: CachedAvatar(
                radius: widget.radius,
                opacity: 0.7 + _opacityAnimation.value,
                url: widget.extractor(_items[1]),
                width: widget.width * 1.2,
                height: widget.height * 1.2,
              ),
            ),
          );
        });
  }

  Widget _buildBanner2Item() {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Positioned(
            top: 0.22 * widget.height,
            left: 0.64 * widget.width - _left2Animation.value,
            child: ScaleTransition(
              scale: _scaleAnimation,
              alignment: Alignment.centerRight,
              child: CachedAvatar(
                radius: widget.radius,
                opacity: 0.4 + _opacityAnimation.value,
                url: widget.extractor(_items[2]),
                width: widget.width,
                height: widget.height,
              ),
            ),
          );
        });
  }

  Widget _buildBanner3Item() {
    return Positioned(
      top: 0.22 * widget.height,
      left: 0.64 * widget.width,
      child: CachedAvatar(
        radius: widget.radius,
        opacity: 0.4,
        url: widget.extractor(_items[3]),
        width: widget.width,
        height: widget.height,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _items.addAll(widget.datas.sublist(0, 4));
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    );

    _leftAnimation = Tween(begin: 0.0, end: widget.width * 1.44).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.6, curve: Curves.ease),
      ),
    );
    _scaleAnimation = Tween(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.75, curve: Curves.ease),
      ),
    );
    _opacityAnimation = Tween(begin: 0.0, end: 0.30).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.75, curve: Curves.ease),
      ),
    );
    _left1Animation = Tween(begin: 0.0, end: widget.width * 0.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.60, 1.0, curve: Curves.ease),
      ),
    );
    _left2Animation = Tween(begin: 0.0, end: widget.width * 0.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.60, 1.0, curve: Curves.ease),
      ),
    );
    _controller
      ..forward()
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _index++;
          _items
            ..removeAt(0)
            ..add(widget.datas[_index %= widget.datas.length]);
          setState(() {});
          _controller.reset();
        }
      });
    _timer =
        Timer.periodic(Duration(milliseconds: widget.duration + 1000), (timer) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }
}
