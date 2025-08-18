import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/views/shrink/model/shrink_filter.dart';
import 'package:prize_lottery_app/views/shrink/widgets/clip_button.dart';
import 'package:prize_lottery_app/widgets/modal_sheet_view.dart';

class SegShrinkView extends StatelessWidget {
  ///
  ///
  const SegShrinkView({
    super.key,
    required this.height,
    required this.shrink,
    required this.onTap,
    required this.onClear,
  });

  final double height;
  final SegmentShrink shrink;
  final Function(int seg, int value) onTap;
  final Function() onClear;

  @override
  Widget build(BuildContext context) {
    return ModalSheetView(
      title: '分区出号',
      height: height,
      child: Container(
        padding: EdgeInsets.only(top: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSegmentX(1, '一区个数', shrink.lower),
            _buildSegmentX(2, '二区个数', shrink.middle),
            _buildSegmentX(3, '三区个数', shrink.higher),
            _buildClearBtn(),
          ],
        ),
      ),
    );
  }

  Widget _buildSegmentX(int seg, String title, List<int> ranges) {
    return Container(
      margin: EdgeInsets.only(left: 12.w, right: 12.w, top: 8.w, bottom: 8.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 20.w,
            padding: EdgeInsets.only(right: 8.w),
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(color: Colors.black54, fontSize: 12.sp),
            ),
          ),
          Expanded(
            child: Wrap(
              runSpacing: 12.w,
              children: [
                ...List.generate(
                  shrink.segMax + 1,
                  (index) => ClipButton(
                    text: '$index',
                    value: index,
                    width: 44.w,
                    height: 22.w,
                    margin: 12.w,
                    selected: shrink.segs[seg]!.contains(index),
                    onTap: (value) {
                      onTap(seg, value);
                    },
                  ),
                ),
                SizedBox(
                  height: 22.w,
                  child: Text(
                    '(号码范围${ranges.first}-${ranges.last})',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black54,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClearBtn() {
    return Container(
      margin: EdgeInsets.only(left: 68.w, top: 8.w),
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
            borderRadius: BorderRadius.circular(2.w),
          ),
          child: Text(
            '清除',
            style: TextStyle(color: Colors.black54, fontSize: 12.sp),
          ),
        ),
      ),
    );
  }
}
