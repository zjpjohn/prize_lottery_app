import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/views/census/widgets/census_item_widget.dart';

const Map<String, List<int>> recCensus = {
  '0': [12, 29, 33, 35],
  '1': [13, 17, 26, 32],
  '2': [17, 21, 26, 31],
  '3': [15, 25, 28, 36],
  '4': [14, 23, 33, 39],
  '5': [20, 25, 28, 36],
  '6': [16, 24, 30, 32],
  '7': [16, 30, 30, 36],
  '8': [15, 22, 27, 34]
};
const Map<String, List<int>> killCensus = {
  '0': [5, 6],
  '1': [6, 11],
  '2': [8, 14],
  '3': [4, 16],
  '4': [6, 7],
  '5': [1, 6],
  '6': [7, 15],
  '7': [6, 13],
  '8': [3, 9],
};
const int recMax = 39;
const int killMax = 16;

class FeeMockWidget extends StatelessWidget {
  const FeeMockWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    for (var entry in recCensus.entries) {
      items.add(CensusItemWidget(
        width: 144.w,
        height: 20.w,
        ballWidth: 20.w,
        recMax: 39,
        killMax: 16,
        fontSize: 14,
        ball: entry.key,
        recList: entry.value,
        killList: killCensus[entry.key]!,
      ));
      items.add(SizedBox(height: 10.w));
    }
    return Container(
      height: 400.w,
      padding: EdgeInsets.only(top: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.w),
      ),
      child: Column(
        children: [
          _buildTrendHint(),
          ...items,
        ],
      ),
    );
  }

  Widget _buildTrendHint() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.w),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 12.w),
            child: Text(
              '号码热度趋势示例',
              style: TextStyle(
                fontSize: 17.sp,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 144.w,
                alignment: Alignment.center,
                child: Text(
                  '推荐热度',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 13.sp,
                  ),
                ),
              ),
              SizedBox(width: 20.w),
              Container(
                width: 144.w,
                alignment: Alignment.center,
                child: Text(
                  '杀码热度',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
