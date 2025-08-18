import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/views/shrink/model/shrink_filter.dart';
import 'package:prize_lottery_app/widgets/modal_sheet_view.dart';

import '../clip_button.dart';

class RoadShrinkView extends StatelessWidget {
  ///
  const RoadShrinkView({
    super.key,
    required this.height,
    required this.model,
    required this.shrink,
    required this.onTap,
    required this.onClear,
  });

  final double height;
  final Road012Model model;
  final Road012Shrink shrink;
  final Function(int road, int value) onTap;
  final Function() onClear;

  @override
  Widget build(BuildContext context) {
    return ModalSheetView(
      title: '012路选择',
      height: height,
      child: _buildRoadContainer(),
    );
  }

  Widget _buildRoadContainer() {
    return Container(
      margin: EdgeInsets.only(top: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRoadX(0),
          _buildRoadX(1),
          _buildRoadX(2),
          _buildClearBtn(),
        ],
      ),
    );
  }

  Widget _buildRoadX(int road) {
    return Container(
      margin: EdgeInsets.only(left: 16.w, top: 16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 22.w,
            padding: EdgeInsets.only(right: 8.w),
            alignment: Alignment.center,
            child: Text(
              '$road路个数',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 12.sp,
              ),
            ),
          ),
          Expanded(
            child: Wrap(
              runSpacing: 12.w,
              children: model.ranges
                  .map(
                    (e) => ClipButton(
                      text: '$e',
                      value: e,
                      width: 34.w,
                      height: 20.w,
                      margin: 8.w,
                      selected: shrink.roads[road]!.contains(e),
                      onTap: (value) {
                        onTap(road, value);
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

  Widget _buildClearBtn() {
    return Container(
      margin: EdgeInsets.only(left: 68.w, top: 16.w),
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
