import 'dart:math';

import 'package:prize_lottery_app/views/census/model/dlt_chart_census.dart';

///
///
class DltChartCensusDo {
  ///
  late String period;

  ///
  /// 趋势图标数据
  Map<String, List<int>> redRecCensus = {};
  Map<String, List<int>> redKillCensus = {};
  int redRecMax = 0;
  int redKillMax = 0;

  Map<String, List<int>> blueRecCensus = {};
  Map<String, List<int>> blueKillCensus = {};
  int blueRecMax = 0;
  int blueKillMax = 0;

  DltChartCensusDo(DltChartCensus census) {
    period = census.period;
    _calcCensusTrendNum(census);
  }

  void _calcCensusTrendNum(DltChartCensus census) {
    redRecMax = _max(census.r20.values[0]);
    redKillMax = _max(census.rk6.values[0]);
    blueRecMax = _max(census.b6.values[0]);
    blueKillMax = _max(census.bk.values[0]);
    redRecCensus = _calcRedRecNums(
      r3: census.r3.values[0],
      r10: census.r10.values[0],
      r20: census.r20.values[0],
    );
    redKillCensus = _calcRedKillNums(
      k3: census.rk3.values[0],
      k6: census.rk6.values[0],
    );
    blueRecCensus = _calcBlueRecNums(
      b2: census.b2.values[0],
      b6: census.b6.values[0],
    );
    blueKillCensus = _calcBlueKillNums(bk: census.bk.values[0]);
  }

  Map<String, List<int>> _calcBlueRecNums({
    required List<int> b2,
    required List<int> b6,
  }) {
    Map<String, List<int>> recCensus = {};
    for (int i = 1; i <= 12; i++) {
      recCensus[i.toString()] = [b2[i - 1], b6[i - 1]];
    }
    return recCensus;
  }

  Map<String, List<int>> _calcBlueKillNums({required List<int> bk}) {
    Map<String, List<int>> killCensus = {};
    for (int i = 1; i <= 12; i++) {
      killCensus[i.toString()] = [bk[i - 1]];
    }
    return killCensus;
  }

  Map<String, List<int>> _calcRedRecNums(
      {required List<int> r3, required List<int> r10, required List<int> r20}) {
    Map<String, List<int>> recCensus = {};
    for (int i = 1; i <= 35; i++) {
      recCensus[i.toString()] = [r3[i - 1], r10[i - 1], r20[i - 1], r20[i - 1]];
    }
    return recCensus;
  }

  Map<String, List<int>> _calcRedKillNums(
      {required List<int> k3, required List<int> k6}) {
    Map<String, List<int>> killCensus = {};
    for (int i = 1; i <= 35; i++) {
      killCensus[i.toString()] = [k3[i - 1], k6[i - 1]];
    }
    return killCensus;
  }

  int _max(List<int> values) {
    int value = 0;
    for (int i = 0; i < values.length; i++) {
      value = max(values[i], value);
    }
    return value;
  }
}
