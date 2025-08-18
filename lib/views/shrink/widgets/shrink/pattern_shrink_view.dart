import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/views/shrink/model/shrink_filter.dart';
import 'package:prize_lottery_app/views/shrink/widgets/clip_button.dart';
import 'package:prize_lottery_app/widgets/modal_sheet_view.dart';

class PatternShrinkView extends StatelessWidget {
  ///
  const PatternShrinkView({
    super.key,
    required this.height,
    required this.bigModel,
    required this.bigShrink,
    required this.evenModel,
    required this.eoShrink,
    required this.seriesModel,
    required this.seriesShrink,
    required this.eoTap,
    required this.bigTap,
    required this.seriesTap,
    required this.onClear,
  });

  final double height;
  final BigModel bigModel;
  final BigShrink bigShrink;
  final EvenModel evenModel;
  final EvenOddShrink eoShrink;
  final SeriesModel seriesModel;
  final SeriesShrink seriesShrink;
  final Function(int value) eoTap;
  final Function(int value) bigTap;
  final Function(int value) seriesTap;
  final Function() onClear;

  @override
  Widget build(BuildContext context) {
    return ModalSheetView(
      title: '号码形态',
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSeriesView(),
          _buildBigView(),
          _buildEvenView(),
          _buildClearBtn(),
        ],
      ),
    );
  }

  Widget _buildSeriesView() {
    return Container(
      margin: EdgeInsets.only(left: 12.w, top: 16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 22.w,
            padding: EdgeInsets.only(right: 8.w),
            alignment: Alignment.center,
            child: Text(
              '连号形态',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 12.sp,
              ),
            ),
          ),
          Expanded(
            child: Wrap(
              spacing: 6.w,
              runSpacing: 12.w,
              children: seriesModel.ranges.entries
                  .map(
                    (e) => ClipButton(
                      text: e.value,
                      value: e.key,
                      width: 56.w,
                      height: 22.w,
                      margin: 12.w,
                      selected: seriesShrink.series.containsKey(e.key),
                      onTap: (value) {
                        seriesTap(value);
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

  Widget _buildBigView() {
    return Container(
      margin: EdgeInsets.only(left: 12.w, top: 12.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 22.w,
            padding: EdgeInsets.only(right: 8.w),
            alignment: Alignment.center,
            child: Text(
              '大小形态',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 12.sp,
              ),
            ),
          ),
          Expanded(
            child: Wrap(
              spacing: 6.w,
              runSpacing: 12.w,
              children: bigModel.ranges.entries
                  .map(
                    (e) => ClipButton(
                      text: e.value,
                      value: e.key,
                      width: 56.w,
                      height: 22.w,
                      margin: 12.w,
                      selected: bigShrink.ratios.contains(e.value),
                      onTap: (value) {
                        bigTap(value);
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

  Widget _buildEvenView() {
    return Container(
      margin: EdgeInsets.only(left: 12.w, top: 12.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 22.w,
            padding: EdgeInsets.only(right: 8.w),
            alignment: Alignment.center,
            child: Text(
              '奇偶形态',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 12.sp,
              ),
            ),
          ),
          Expanded(
            child: Wrap(
              spacing: 6.w,
              runSpacing: 12.w,
              children: evenModel.ranges.entries
                  .map(
                    (e) => ClipButton(
                      text: e.value,
                      value: e.key,
                      width: 56.w,
                      height: 22.w,
                      margin: 12.w,
                      selected: eoShrink.ratios.contains(e.value),
                      onTap: (value) {
                        eoTap(value);
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
