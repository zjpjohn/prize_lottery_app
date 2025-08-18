import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ToggleExpand extends StatefulWidget {
  const ToggleExpand({super.key});

  @override
  State<ToggleExpand> createState() => ToggleExpandState();
}

class ToggleExpandState extends State<ToggleExpand>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late CurvedAnimation _animation;
  double _angle = 0.0;
  bool _isExpand = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
    _animation.addListener(() {
      if (mounted) {
        setState(() {
          _angle = _isExpand ? _animation.value * pi : -_animation.value * pi;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleExpand() {
    setState(() {
      _isExpand = !_isExpand;
      if (_isExpand) {
        _controller.forward();
        return;
      }
      _controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _angle,
      child: Icon(
        const IconData(0xe67d, fontFamily: 'iconfont'),
        size: 10.sp,
        color: Colors.black,
      ),
    );
  }
}
