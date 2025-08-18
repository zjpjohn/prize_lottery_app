import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/utils/poster_util.dart';
import 'package:prize_lottery_app/views/lottery/controller/lottery_honey_controller.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_honey.dart';
import 'package:prize_lottery_app/views/lottery/widgets/diamond_widget.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class LotteryHoneyView extends StatelessWidget {
  const LotteryHoneyView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '蜂巢配胆',
      content: Container(
        color: const Color(0xFFF8F8FB),
        child: RequestWidget<LotteryHoneyController>(
          builder: (controller) {
            return Column(
              children: [
                _buildHoneyHeader(controller),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: CustomScrollBehavior(),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildHoneyContent(controller),
                          _buildHoneyUsage(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHoneyHeader(LotteryHoneyController controller) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              if (!controller.isFirst()) {
                controller.prevPeriod();
              }
            },
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: Icon(
                    const IconData(0xe676, fontFamily: 'iconfont'),
                    size: 14.sp,
                    color:
                        controller.isFirst() ? Colors.black26 : Colors.black87,
                  ),
                ),
                Text(
                  '上一期',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color:
                        controller.isFirst() ? Colors.black26 : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    '${controller.period}期',
                    style: TextStyle(
                      height: 1.0,
                      color: Colors.black87,
                      fontSize: 14.sp,
                    ),
                  ),
                  Text(
                    controller.honey.dateText(),
                    style: TextStyle(
                      height: 1.0,
                      color: Colors.black87,
                      fontSize: 13.sp,
                    ),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (!controller.isEnd()) {
                controller.nextPeriod();
              }
            },
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '下一期',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: controller.isEnd() ? Colors.black26 : Colors.black87,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: Icon(
                    const IconData(0xe613, fontFamily: 'iconfont'),
                    size: 14.sp,
                    color: controller.isEnd() ? Colors.black26 : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHoneyContent(LotteryHoneyController controller) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10.w, left: 10.w, right: 10.w),
      padding: EdgeInsets.symmetric(vertical: 14.w, horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${controller.honey.type.value == 'fc3d' ? '3D' : 'P3'}蜂巢配胆图',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '${controller.honey.period}期',
            style: TextStyle(
              fontSize: 15.sp,
              color: Colors.black,
            ),
          ),
          GestureDetector(
            onLongPress: () {
              EasyLoading.showToast('长按保存');
              Future.delayed(const Duration(milliseconds: 300), () {
                PosterUtils.saveImage(controller.posterKey);
              });
            },
            behavior: HitTestBehavior.opaque,
            child: RepaintBoundary(
              key: controller.posterKey,
              child: Container(
                alignment: Alignment.center,
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.w),
                child: _buildHoneyView(controller.honey),
              ),
            ),
          ),
          _buildRecommendDan(controller.honey),
          _buildHoneyHint(),
        ],
      ),
    );
  }

  Widget _buildHoneyView(LotteryHoney honey) {
    List<Widget> views = [];
    for (int i = 0; i < honey.honey.values.length; i++) {
      views.add(
          _buildHoneyRows(honey.type.value, 200.w, i, honey.honey.values[i]));
    }
    return Container(
      width: 200.w,
      height: _calcHoneyHeight(honey.honey.values.length),
      margin: EdgeInsets.symmetric(vertical: 12.w),
      child: Stack(
        children: views,
      ),
    );
  }

  double _calcHoneyHeight(int size) {
    return (size - 1) * (52.w - 21.w * tan(pi / 6)) + 52.w;
  }

  Widget _buildHoneyRows(
      String type, double width, int index, List<String> cells) {
    double left = 0;
    if (index <= 3) {
      left = width / 2 - 21.w * (index + 1);
    } else {
      left = width / 2 - 21.w * (6 - index + 1);
    }
    double top = index * (52.w - 21.w * tan(pi / 6));
    return Positioned(
      left: left,
      top: top,
      child: Row(
        children: cells
            .map(
              (e) => HoneyCell(
                value: e,
                width: 42.w,
                height: 52.w,
                color: type == 'fc3d'
                    ? const Color(0xFF1E90FF)
                    : Colors.pinkAccent,
                active: type == 'fc3d'
                    ? Colors.pinkAccent
                    : const Color(0xFF1E90FF),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildRecommendDan(LotteryHoney honey) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/${honey.type.value}/pivot');
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.w),
        decoration: BoxDecoration(
          color: Colors.orangeAccent.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(20.w),
        ),
        child: Text(
          '查看系统推荐定胆',
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.orangeAccent,
          ),
        ),
      ),
    );
  }

  Widget _buildHoneyHint() {
    return Padding(
      padding: EdgeInsets.only(top: 12.w),
      child: Text(
        '仅供参考，谨慎使用，系统不做任何承诺',
        style: TextStyle(
          color: Colors.black26,
          fontSize: 11.sp,
        ),
      ),
    );
  }

  Widget _buildHoneyUsage() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10.w, left: 10.w, right: 10.w, bottom: 16.w),
      padding: EdgeInsets.symmetric(vertical: 14.w, horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '使用说明',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontFamily: 'shuhei',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.w),
            child: Text(
              '蜂巢配胆图由上期开奖号码计算出本期高概率号码的组合图。一般使用方式：首先结合自身选号经验选出一个胆码；'
              '然后在配胆图中与胆码周围相邻号码组合出本期高概率号码组合。',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 13.sp,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.w),
            child: Text(
              '蜂巢配胆图的重点在于确定胆码，需使用者根据自己的选号经验确定胆码。本图表仅供兴趣参考，不做任何承诺。',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 13.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HoneyCell extends StatefulWidget {
  const HoneyCell({
    super.key,
    required this.value,
    required this.width,
    required this.height,
    required this.color,
    required this.active,
  });

  final String value;
  final double width;
  final double height;
  final Color color;
  final Color active;

  @override
  State<HoneyCell> createState() => _HoneyCellState();
}

class _HoneyCellState extends State<HoneyCell> {
  ///
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _selected = !_selected;
        setState(() {});
      },
      behavior: HitTestBehavior.opaque,
      child: DiamondWidget(
        width: widget.width,
        height: widget.height,
        margin: 1.5.w,
        color: _selected ? widget.active : widget.color,
        child: Text(
          widget.value,
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(HoneyCell oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget != context.widget) {
      _selected = false;
      setState(() {});
    }
  }
}
