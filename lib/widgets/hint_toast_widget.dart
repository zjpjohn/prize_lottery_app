import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/resources/resources.dart';

class HintToast {
  ///
  ///
  static void show({
    required String hint,
    required int duration,
    int delay = 1500,
    int showOrHide = 500,
  }) {
    ///
    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        left: 0,
        right: 0,
        bottom: 54.w,
        child: HintToastView(
          hint: hint,
          duration: duration,
          showOrHide: showOrHide,
          close: () {
            overlayEntry.remove();
          },
        ),
      );
    });

    ///延迟显示动画
    Future.delayed(Duration(milliseconds: delay), () {
      ///加入overlay
      Overlay.of(Get.context!).insert(overlayEntry);
    });
  }
}

typedef HintToastClose = Function();

class HintToastView extends StatefulWidget {
  ///
  ///
  const HintToastView({
    super.key,
    required this.hint,
    required this.duration,
    required this.showOrHide,
    required this.close,
  });

  ///提示文字
  final String hint;

  ///
  final int showOrHide;

  ///持续时长(秒)关闭
  final int duration;

  ///
  final HintToastClose close;

  @override
  HintToastViewState createState() => HintToastViewState();
}

class HintToastViewState extends State<HintToastView> {
  ///当前时长
  late int _seconds;

  ///计时器
  late StreamSubscription _timer;

  ///是否显示
  bool _showing = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _showing ? 1 : 0,
      duration: Duration(milliseconds: widget.showOrHide),
      child: Container(
        color: Colors.transparent,
        margin: EdgeInsets.only(left: 18.w, right: 18.w, bottom: 12.w),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: 12.w,
                right: 12.w,
                top: 18.w,
                bottom: 10.w,
              ),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.w),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  opacity: 0.75,
                  image: AssetImage(R.globalHintBg),
                ),
              ),
              child: Text(
                widget.hint,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: 0.2.w,
              right: 0.2.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(6.w),
                    bottomLeft: Radius.circular(6.w),
                  ),
                ),
                child: RichText(
                  text: TextSpan(
                    text: '$_seconds',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.blueAccent,
                    ),
                    children: [
                      TextSpan(
                        text: 's',
                        style: TextStyle(
                          fontSize: 12.sp,
                        ),
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

  @override
  void initState() {
    super.initState();
    _seconds = widget.duration;
    _timer = Stream.periodic(const Duration(seconds: 1), (i) => i)
        .take(widget.duration)
        .listen((i) {
      if (mounted) {
        setState(() {
          int remain = widget.duration - i;
          if (remain >= 1) {
            _seconds = remain;
          }
          _showing = _seconds >= 1;
          if (_seconds == 1) {
            _showing = false;
            Future.delayed(Duration(milliseconds: widget.showOrHide), () {
              widget.close();
            });
          }
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel;
  }
}
