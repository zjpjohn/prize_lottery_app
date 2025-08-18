import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/tooltip/tooltip.dart';
import 'package:another_xlider/models/tooltip/tooltip_position_offset.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/utils/constants.dart';
import 'package:prize_lottery_app/views/shrink/model/shrink_filter.dart';
import 'package:prize_lottery_app/widgets/modal_sheet_view.dart';

import '../clip_button.dart';

class SumShrinkView extends StatelessWidget {
  ///
  const SumShrinkView({
    super.key,
    required this.shrink,
    required this.height,
    required this.onRange,
    required this.onOddEven,
    required this.onRoad,
    required this.onTail,
  });

  final SumShrink shrink;
  final double height;
  final Function(RangeValues) onRange;
  final Function(int value) onOddEven;
  final Function(int value) onRoad;
  final Function(int) onTail;

  @override
  Widget build(BuildContext context) {
    return ModalSheetView(
      title: '和值过滤',
      height: height,
      child: Column(
        children: [
          _buildSumRange(),
          _buildOddEven(),
          _buildTailView(),
        ],
      ),
    );
  }

  Widget _buildSumRange() {
    return Container(
      margin: EdgeInsets.only(top: 24.w),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 16.w, right: 8.w),
            child: Text(
              '和值范围',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.black54,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(Get.context!).size.width * 0.72,
            alignment: Alignment.centerLeft,
            child: FlutterSlider(
              values: [shrink.ranges.start, shrink.ranges.end],
              rangeSlider: true,
              max: shrink.max,
              min: shrink.min,
              handlerHeight: 20.w,
              handlerWidth: 20.w,
              trackBar: FlutterSliderTrackBar(
                inactiveTrackBarHeight: 2.w,
                inactiveTrackBar: const BoxDecoration(color: Colors.black12),
                activeTrackBarHeight: 2.w,
                activeTrackBar: const BoxDecoration(color: Color(0xFFFF0045)),
              ),
              handler: FlutterSliderHandler(
                child: Material(
                  type: MaterialType.canvas,
                  color: Colors.white,
                  shadowColor: Colors.black12,
                  borderRadius: BorderRadius.circular(12.w),
                  child: Icon(
                    const IconData(0xe644, fontFamily: 'iconfont'),
                    size: 16.w,
                    color: Colors.black26,
                  ),
                ),
              ),
              rightHandler: FlutterSliderHandler(
                child: Material(
                  type: MaterialType.canvas,
                  color: Colors.white,
                  shadowColor: Colors.black12,
                  borderRadius: BorderRadius.circular(12.w),
                  child: Icon(
                    const IconData(0xe644, fontFamily: 'iconfont'),
                    size: 16.w,
                    color: Colors.black26,
                  ),
                ),
              ),
              tooltip: FlutterSliderTooltip(
                positionOffset: FlutterSliderTooltipPositionOffset(top: 4.w),
                custom: (value) => Container(
                  width: 44.w,
                  height: 22.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F8F8),
                    borderRadius: BorderRadius.circular(20.w),
                  ),
                  child: Text(
                    '${value.toInt()}',
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),
              onDragging: (index, lower, upper) {
                onRange(RangeValues(lower, upper));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOddEven() {
    return Container(
      margin: EdgeInsets.only(top: 12.w),
      padding: EdgeInsets.only(left: 16.w, right: 16.w),
      child: Row(
        children: [
          Container(
            height: 20.w,
            padding: EdgeInsets.only(right: 8.w),
            alignment: Alignment.center,
            child: Text(
              '和值形态',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 12.sp,
              ),
            ),
          ),
          ClipButton(
            text: '奇数',
            value: 1,
            width: 46.w,
            height: 20.w,
            margin: 8.w,
            selected: shrink.oddEven.contains(1),
            onTap: (value) {
              onOddEven(value);
            },
          ),
          ClipButton(
            text: '偶数',
            value: 0,
            width: 46.w,
            height: 20.w,
            margin: 8.w,
            selected: shrink.oddEven.contains(0),
            onTap: (value) {
              onOddEven(value);
            },
          ),
          ClipButton(
            text: '0路',
            value: 0,
            width: 46.w,
            height: 20.w,
            margin: 8.w,
            selected: shrink.roads.contains(0),
            onTap: (value) {
              onRoad(value);
            },
          ),
          ClipButton(
            text: '1路',
            value: 1,
            width: 46.w,
            height: 20.w,
            margin: 8.w,
            selected: shrink.roads.contains(1),
            onTap: (value) {
              onRoad(value);
            },
          ),
          ClipButton(
            text: '2路',
            value: 2,
            width: 46.w,
            height: 20.w,
            margin: 8.w,
            selected: shrink.roads.contains(2),
            onTap: (value) {
              onRoad(value);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTailView() {
    return Container(
      margin: EdgeInsets.only(top: 20.w),
      padding: EdgeInsets.only(left: 16.w, right: 16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 20.w,
            padding: EdgeInsets.only(right: 8.w),
            alignment: Alignment.center,
            child: Text(
              '和值尾数',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 12.w,
              ),
            ),
          ),
          Expanded(
            child: Wrap(
              runSpacing: 8.w,
              children: ball09
                  .map(
                    (i) => ClipButton(
                      text: '$i',
                      value: i,
                      width: 38.w,
                      height: 20.w,
                      margin: 8.w,
                      selected: shrink.tail.contains(i),
                      onTap: (value) {
                        onTail(value);
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
