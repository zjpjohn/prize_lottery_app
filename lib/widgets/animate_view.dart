import 'package:flutter/material.dart';

class AnimateView extends StatelessWidget {
  final Animation<double> animation;
  final AnimationController controller;
  final Widget child;
  final bool vertical;

  const AnimateView({
    super.key,
    required this.animation,
    required this.controller,
    required this.child,
    this.vertical = true,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
              !vertical ? 50 * (1.0 - animation.value) : 0.0,
              vertical ? 50 * (1.0 - animation.value) : 0,
              0.0,
            ),
            child: this.child,
          ),
        );
      },
    );
  }
}
