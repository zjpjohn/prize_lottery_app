import 'dart:async';

import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:prize_lottery_app/resources/colors.dart';
import 'package:prize_lottery_app/widgets/round_net_image.dart';

class LiquidBanner extends StatefulWidget {
  const LiquidBanner({
    super.key,
    this.height = 160,
    this.inner = 5.0,
    this.outer = 8.0,
    required this.children,
    this.backgroundColor = backColor,
    this.interval = 1.5,
  });

  final double height;
  final List<Widget> children;
  final Color backgroundColor;
  final double interval;
  final double outer;
  final double inner;

  @override
  State<LiquidBanner> createState() => _LiquidBannerState();
}

class _LiquidBannerState extends State<LiquidBanner> {
  ///
  int _currentIndex = 0;

  ///
  final LiquidController liquidController = LiquidController();

  late Timer _timer;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      color: widget.backgroundColor,
      child: Stack(
        children: [
          LiquidSwipe.builder(
            itemCount: widget.children.length,
            waveType: WaveType.liquidReveal,
            liquidController: liquidController,
            fullTransitionValue: 200,
            enableLoop: true,
            preferDragFromRevealedArea: true,
            ignoreUserGestureWhileAnimating: true,
            onPageChangeCallback: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return widget.children[index];
            },
          ),
          if (widget.children.length > 1)
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.children.asMap().entries.map((entry) {
                  return _indicator(entry.key);
                }).toList(),
              ),
            )
        ],
      ),
    );
  }

  Widget _indicator(int index) {
    return Container(
      width: widget.outer,
      height: widget.outer,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: widget.interval),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.outer),
        color: _currentIndex != index
            ? Colors.transparent
            : const Color(0x60F6F6F6),
      ),
      child: Container(
        width: widget.inner,
        height: widget.inner,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.inner),
          color:
              _currentIndex == index ? Colors.white : const Color(0x60F6F6F6),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      liquidController.nextPage();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

class BannerImage extends StatelessWidget {
  ///
  const BannerImage({
    super.key,
    required this.url,
    required this.width,
    required this.height,
    this.margin,
    required this.onTap,
  });

  final String url;
  final double width;
  final double height;
  final EdgeInsets? margin;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          color: backColor,
          borderRadius: BorderRadius.circular(0),
        ),
        margin: margin,
        width: width,
        child: RoundNetImage(
          url: url,
          width: width,
          height: height,
          fit: BoxFit.cover,
          corner: 0,
        ),
      ),
    );
  }
}
