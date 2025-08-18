import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final Map<String, Color> levelColors = {
  '优秀': const Color(0xFFFF0033),
  '良好': Colors.deepOrangeAccent,
  '一般': Colors.blueAccent,
  '普通': Colors.black38,
};

class RateFeatureChart extends StatefulWidget {
  final String title;
  final String level;
  final double delta;
  final double rate;
  final double average;
  final double bottom;
  final double width;

  const RateFeatureChart({
    super.key,
    required this.title,
    required this.level,
    required this.delta,
    required this.rate,
    required this.average,
    this.bottom = 0.0,
    this.width = 250.0,
  });

  @override
  RateFeatureChartState createState() => RateFeatureChartState();
}

class RateFeatureChartState extends State<RateFeatureChart> {
  ///
  ///
  double _rateWidth = 0.0;

  ///
  double _avgWidth = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: widget.bottom),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4.w),
                    child: Text(
                      widget.level,
                      style: TextStyle(
                        color: levelColors[widget.level]!,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                deltaText(),
                style: TextStyle(color: Colors.black26, fontSize: 11.sp),
              )
            ],
          ),
          _buildRateView(),
        ],
      ),
    );
  }

  String deltaText() {
    if (widget.delta > 0) {
      return '超过平均${(widget.delta * 100).toStringAsFixed(0)}%';
    }
    if (widget.delta == 0) {
      return '平均持平';
    }
    return '低于平均${(widget.delta * 100 * -1).toStringAsFixed(0)}%';
  }

  Widget _buildRateView() {
    return Container(
      margin: EdgeInsets.only(left: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _lineChart(
            width: _rateWidth,
            color: Colors.blueAccent,
          ),
          _lineChart(
            width: _avgWidth,
            color: const Color(0xFFF1F1F1),
          ),
        ],
      ),
    );
  }

  Widget _lineChart({required double width, required Color color}) {
    return AnimatedContainer(
      height: 8.w,
      width: width,
      color: color,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 50), () {
      _rateWidth = widget.rate * widget.width.w;
      _avgWidth = widget.average * widget.width.w;
      if (mounted) {
        setState(() {});
      }
    });
  }
}
