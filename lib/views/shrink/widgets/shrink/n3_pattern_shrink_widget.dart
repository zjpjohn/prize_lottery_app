import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/views/shrink/model/shrink_filter.dart';
import 'package:prize_lottery_app/widgets/modal_sheet_view.dart';

import '../clip_button.dart';

class N3PatternShrinkView extends StatelessWidget {
  ///
  const N3PatternShrinkView({
    super.key,
    required this.height,
    required this.patternModel,
    required this.patternShrink,
    required this.seriesModel,
    required this.seriesShrink,
    required this.onPattern,
    required this.onSeries,
  });

  final double height;
  final N3PatternModel patternModel;
  final N3PatternShrink patternShrink;
  final SeriesModel seriesModel;
  final SeriesShrink seriesShrink;
  final Function(int value) onPattern;
  final Function(int value) onSeries;

  @override
  Widget build(BuildContext context) {
    return ModalSheetView(
      title: '号码形态',
      height: height,
      child: Column(
        children: [
          _buildPatternView(),
          _buildSeriesView(),
        ],
      ),
    );
  }

  Widget _buildPatternView() {
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
              '组码形态',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 12.sp,
              ),
            ),
          ),
          Wrap(
            runSpacing: 12.w,
            children: patternModel.patterns.entries
                .map(
                  (e) => ClipButton(
                    text: e.value,
                    value: e.key,
                    width: 60.w,
                    height: 22.w,
                    margin: 12.w,
                    selected: patternShrink.pattern.containsKey(e.key),
                    onTap: (value) {
                      onPattern(value);
                    },
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSeriesView() {
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
              '连号形态',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 12.sp,
              ),
            ),
          ),
          Wrap(
            runSpacing: 12.w,
            children: seriesModel.ranges.entries
                .map(
                  (e) => ClipButton(
                    text: e.value,
                    value: e.key,
                    width: 60.w,
                    height: 22.w,
                    margin: 12.w,
                    selected: seriesShrink.series.containsKey(e.key),
                    onTap: (value) {
                      onSeries(value);
                    },
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
