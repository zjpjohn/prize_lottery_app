import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/views/shrink/model/shrink_filter.dart';
import 'package:prize_lottery_app/widgets/modal_sheet_view.dart';

import '../clip_button.dart';

class OddEvenShrinkView extends StatelessWidget {
  ///
  ///
  const OddEvenShrinkView({
    super.key,
    required this.height,
    required this.model,
    required this.shrink,
    required this.onTap,
    required this.onClear,
  });

  final double height;
  final EvenModel model;
  final EvenOddShrink shrink;
  final Function(int value) onTap;
  final Function() onClear;

  @override
  Widget build(BuildContext context) {
    return ModalSheetView(
      title: '奇偶选择',
      height: height,
      child: _buildOeContainer(),
    );
  }

  Widget _buildOeContainer() {
    return Container(
      margin: EdgeInsets.only(left: 16.w, top: 32.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 22.w,
            padding: EdgeInsets.only(right: 8.w),
            alignment: Alignment.center,
            child: Text(
              '奇偶比值',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 12.sp,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  runSpacing: 12.w,
                  children: model.ranges.entries
                      .map(
                        (e) => ClipButton(
                          text: e.value,
                          value: e.key,
                          width: 44.w,
                          height: 22.w,
                          margin: 12.w,
                          selected: shrink.ratios.contains(e.value),
                          onTap: (value) {
                            onTap(value);
                          },
                        ),
                      )
                      .toList(),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16.w),
                  child: GestureDetector(
                    onTap: () {
                      onClear();
                    },
                    child: Container(
                      width: 44.w,
                      height: 22.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: const Color(0xFFF6F6F6),
                          borderRadius: BorderRadius.circular(2.w)),
                      child: Text(
                        '清除',
                        style:
                            TextStyle(color: Colors.black54, fontSize: 12.sp),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
