import 'package:flutter/material.dart';

class RotateWidget extends StatefulWidget {
  const RotateWidget({
    super.key,
    required this.child,
    required this.duration,
    this.repeat = false,
  });

  final Widget child;
  final Duration duration;
  final bool repeat;

  @override
  State<RotateWidget> createState() => RotateWidgetState();
}

class RotateWidgetState extends State<RotateWidget>
    with SingleTickerProviderStateMixin {
  ///
  ///
  late AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: widget.child,
    );
  }

  void rotate() {
    if (widget.repeat) {
      return;
    }
    if (_controller.isCompleted) {
      _controller.reset();
    }
    _controller.forward();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    if (widget.repeat) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
