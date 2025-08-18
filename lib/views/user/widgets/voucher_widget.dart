import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/views/user/model/user_voucher.dart';
import 'package:prize_lottery_app/widgets/dash_line.dart';

typedef BarrageItemBuilder = Widget Function(UserDraw item);

class VoucherBarrage extends StatefulWidget {
  ///
  ///
  const VoucherBarrage({
    super.key,
    required this.draws,
    required this.builder,
    required this.height,
  });

  final double height;
  final List<UserDraw> draws;
  final BarrageItemBuilder builder;

  @override
  VoucherBarrageState createState() => VoucherBarrageState();
}

class VoucherBarrageState extends State<VoucherBarrage>
    with WidgetsBindingObserver {
  ///
  ///
  late ScrollController _scrollController;

  ///
  Timer? _timer;

  ///
  double offset = 0;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: widget.height,
          maxHeight: widget.height,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: Get.width * 0.67),
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          itemBuilder: (context, index) {
            return _valueIndex(index);
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _scrollController = ScrollController();
    _initTimer(false);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _initTimer(true);
        break;
      case AppLifecycleState.inactive || AppLifecycleState.paused:
        _cancelTimer();
        break;
      case AppLifecycleState.detached || AppLifecycleState.hidden:
        break;
    }
  }

  void _initTimer(bool autoScroll) {
    if (autoScroll && _scrollController.hasClients) {
      offset += 50;
      _scrollController.animateTo(
        offset,
        curve: Curves.linear,
        duration: const Duration(seconds: 1),
      );
    }
    _timer ??= Timer.periodic(
      const Duration(seconds: 1),
      (_) => _scroll(),
    );
  }

  void _cancelTimer() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
  }

  void _scroll() {
    if (!_scrollController.hasClients) {
      return;
    }
    offset += 50;
    _scrollController.animateTo(
      offset,
      duration: const Duration(seconds: 1),
      curve: Curves.linear,
    );
  }

  Widget _valueIndex(int index) {
    int value =
        index < widget.draws.length ? index : index % widget.draws.length;
    return widget.builder(widget.draws[value]);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cancelTimer();
    super.dispose();
  }
}

class VoucherRecordWidget extends StatelessWidget {
  ///
  ///
  const VoucherRecordWidget({
    super.key,
    required this.voucher,
    required this.top,
  });

  ///领取代金券
  final UserVoucherLog voucher;
  final double top;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: top,
      ),
      child: Row(
        children: [
          Expanded(
            child: Material(
              color: voucher.background,
              shape: const VoucherShapeBorder(
                color: Colors.white,
                radius: 4,
                dashCount: 12,
              ),
              child: Container(
                height: 84.w,
                padding: EdgeInsets.only(left: 16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${voucher.voucher}',
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.white,
                              fontFamily: 'bebas',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          WidgetSpan(
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: 2.w, bottom: 0.5.w),
                              child: Text(
                                '金币',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 2.w),
                      child: Text(
                        voucher.remark(),
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                    Text(
                      '领取时间${voucher.gmtCreate}',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(-3, 0),
            child: Material(
              color: voucher.background,
              shape: const VoucherRightShapeBorder(count: 6),
              child: Container(
                height: 84.w,
                width: 90.w,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      voucher.description[0],
                      style: TextStyle(
                        color: voucher.stateColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      voucher.description[1],
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.4),
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

typedef DrawTapHandle = void Function(VoucherInfo voucher);

class DrawVoucherWidget extends StatelessWidget {
  ///
  ///
  const DrawVoucherWidget({
    super.key,
    required this.voucher,
    required this.onDraw,
  });

  final VoucherInfo voucher;
  final DrawTapHandle onDraw;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 16.w),
      child: Row(
        children: [
          Expanded(
            child: Material(
              color: Colors.white,
              shape: const VoucherShapeBorder(
                color: Color(0xFFCFCFCF),
                radius: 4,
                dashCount: 12,
              ),
              child: Container(
                height: 80.w,
                padding: EdgeInsets.only(left: 16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${voucher.voucher}',
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: const Color(0xFF00C2C2),
                              fontFamily: 'bebas',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          WidgetSpan(
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: 2.w, bottom: 0.5.w),
                              child: Text(
                                '金币',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: const Color(0xFF00C2C2),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 2.w),
                      child: Text(
                        voucher.disposable == 1
                            ? '用户仅允许领取一次'
                            : '用户每隔${voucher.interval}天可领取',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '预计领取时间:',
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.black,
                            ),
                          ),
                          WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.only(left: 2.w),
                              child: Text(
                                voucher.nextDraw.isEmpty
                                    ? '当前即可领取'
                                    : voucher.nextDraw,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: const Color(0xFF00C2C2),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(-3, 0),
            child: Material(
              color: Colors.white,
              shape: const VoucherRightShapeBorder(count: 5),
              child: Container(
                height: 80.w,
                width: 90.w,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (voucher.canDraw) {
                          onDraw(voucher);
                        }
                      },
                      child: Text(
                        voucher.canDraw ? '立即领取' : '不可领取',
                        style: TextStyle(
                          color: voucher.canDraw
                              ? const Color(0xFF00C2C2)
                              : Colors.black26,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      voucher.canDraw ? '赶紧领取吧' : '请耐心等待',
                      style: TextStyle(
                        color: Colors.black38,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
