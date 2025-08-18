import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChartLegend {
  final String name;
  final int level;
  final Color color;

  ChartLegend({
    required this.name,
    required this.level,
    required this.color,
  });
}

const List<Color> levelColors = [
  Color(0xff168c8c),
  Color(0xff99c53b),
  Color(0xffbcd97e),
  Color(0xffb4d9c4),
  Color(0xffb5e6d9),
];

final List<ChartLegend> levelLegends = [
  ChartLegend(name: '前10名', level: 1, color: const Color(0xff168c8c)),
  ChartLegend(name: '前20名', level: 2, color: const Color(0xff99c53b)),
  ChartLegend(name: '前50名', level: 3, color: const Color(0xffbcd97e)),
  ChartLegend(name: '前100名', level: 4, color: const Color(0xffb4d9c4)),
  ChartLegend(name: '前150名', level: 5, color: const Color(0xffb5e6d9)),
];

List<Color> recColors = [
  const Color(0xFF1980FF),
  const Color(0xFF52A7FF),
  const Color(0xFF75BFFF),
  const Color(0xFFA3D8FF),
];
List<Color> killColors = [
  const Color(0xFFFF3F60),
  const Color(0xFFFFD2CC),
];

const Map<String, Color> n3Legends = {
  '三胆': Color(0xFF1980FF),
  '五码': Color(0xFF52A7FF),
  '六码': Color(0xFF75BFFF),
  '七码': Color(0xFFA3D8FF),
  '杀一码': Color(0xFFFF3F60),
  '杀二码': Color(0xFFFFD2CC),
};

const Map<String, Color> qlcLegends = {
  '三胆': Color(0xFF1980FF),
  '12码': Color(0xFF52A7FF),
  '18码': Color(0xFF75BFFF),
  '22码': Color(0xFFA3D8FF),
  '杀三码': Color(0xFFFF3F60),
  '杀六码': Color(0xFFFFD2CC),
};
const Map<String, Color> ssqRedLegends = {
  '三胆': Color(0xFF1980FF),
  '12码': Color(0xFF52A7FF),
  '20码': Color(0xFF75BFFF),
  '25码': Color(0xFFA3D8FF),
  '杀三码': Color(0xFFFF3F60),
  '杀六码': Color(0xFFFFD2CC),
};
const Map<String, Color> ssqBlueLegends = {
  '蓝球三胆': Color(0xFF1980FF),
  '蓝球五码': Color(0xFF52A7FF),
  '蓝球杀码': Color(0xFFFF3F60),
};
const Map<String, Color> dltRedLegends = {
  '三胆': Color(0xFF1980FF),
  '10码': Color(0xFF52A7FF),
  '20码': Color(0xFF75BFFF),
  '杀三码': Color(0xFFFF3F60),
  '杀六码': Color(0xFFFFD2CC),
};
const Map<String, Color> dltBlueLegends = {
  '蓝球双胆': Color(0xFF1980FF),
  '蓝球六码': Color(0xFF52A7FF),
  '蓝球杀码': Color(0xFFFF3F60),
};

class SyntheticItemWidget extends StatelessWidget {
  const SyntheticItemWidget({
    super.key,
    required this.width,
    required this.height,
    required this.ballWidth,
    required this.max,
    required this.ball,
    required this.census,
    this.fontSize = 14.0,
  });

  final double width;
  final double height;
  final double ballWidth;
  final int max;
  final String ball;
  final List<int> census;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildBallView(),
        _buildCensusView(),
      ],
    );
  }

  Widget _buildBallView() {
    return Container(
      width: ballWidth,
      height: height,
      alignment: Alignment.center,
      color: Colors.white,
      child: Text(
        ball,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'bebas',
          fontSize: fontSize.sp,
        ),
      ),
    );
  }

  Widget _buildCensusView() {
    List<Widget> widgets = [];
    for (int i = 0; i < census.length; i++) {
      int value = census[i];
      double percent = value / max;
      double realWidth = percent * width;
      Color color = levelColors[i];
      widgets.add(
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            height: height,
            width: realWidth,
            color: color,
          ),
        ),
      );
    }
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: widgets.reversed.toList(),
      ),
    );
  }
}

class CensusItemWidget extends StatelessWidget {
  const CensusItemWidget({
    super.key,
    required this.width,
    required this.height,
    required this.ballWidth,
    required this.recMax,
    required this.killMax,
    required this.ball,
    required this.recList,
    required this.killList,
    this.fontSize = 14.0,
  });

  final double width;
  final double height;
  final double ballWidth;
  final int recMax;
  final int killMax;
  final double fontSize;
  final String ball;
  final List<int> recList;
  final List<int> killList;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildRecView(),
        _buildBallView(),
        _buildKillView(),
      ],
    );
  }

  Widget _buildRecView() {
    List<Widget> widgets = [];
    for (int i = 0; i < recList.length; i++) {
      int value = recList[i];
      double percent = value / recMax;
      double realWidth = percent * width;
      Color color = recColors[i];
      widgets.add(
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            height: height,
            width: realWidth,
            color: color,
          ),
        ),
      );
    }
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: widgets.reversed.toList(),
      ),
    );
  }

  Widget _buildKillView() {
    List<Widget> widgets = [];
    for (int i = 0; i < killList.length; i++) {
      int value = killList[i];
      double percent = value / killMax;
      double realWidth = percent * width;
      Color color = killColors[i];
      widgets.add(
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            color: color,
            height: height,
            width: realWidth,
          ),
        ),
      );
    }
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: widgets.reversed.toList(),
      ),
    );
  }

  Widget _buildBallView() {
    return Container(
      width: ballWidth,
      height: height,
      alignment: Alignment.center,
      color: Colors.white,
      child: Text(
        ball,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'bebas',
          fontSize: fontSize.sp,
        ),
      ),
    );
  }
}
