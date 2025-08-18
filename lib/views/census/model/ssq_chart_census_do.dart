import 'dart:math';

import 'package:prize_lottery_app/views/census/model/ssq_chart_census.dart';

///
///
class SsqChartCensusDo {
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

  SsqChartCensusDo(SsqChartCensus census) {
    period = census.period;
    _calcCensusTrendNum(census);
  }

  void _calcCensusTrendNum(SsqChartCensus census) {
    redRecMax = _max(census.r25.values[0]);
    redKillMax = _max(census.rk6.values[0]);
    blueRecMax = _max(census.b5.values[0]);
    blueKillMax = _max(census.bk.values[0]);
    redRecCensus = _calcRedRecNums(
      r3: census.r3.values[0],
      r12: census.r12.values[0],
      r20: census.r20.values[0],
      r25: census.r25.values[0],
    );
    redKillCensus = _calcRedKillNums(
      k3: census.rk3.values[0],
      k6: census.rk6.values[0],
    );
    blueRecCensus = _calcBlueRecNums(
      b3: census.b3.values[0],
      b5: census.b5.values[0],
    );
    blueKillCensus = _calcBlueKillNums(bk: census.bk.values[0]);
  }

  Map<String, List<int>> _calcBlueRecNums({
    required List<int> b3,
    required List<int> b5,
  }) {
    Map<String, List<int>> recCensus = {};
    for (int i = 1; i <= 16; i++) {
      recCensus[i.toString()] = [b3[i - 1], b5[i - 1]];
    }
    return recCensus;
  }

  Map<String, List<int>> _calcBlueKillNums({required List<int> bk}) {
    Map<String, List<int>> killCensus = {};
    for (int i = 1; i <= 16; i++) {
      killCensus[i.toString()] = [bk[i - 1]];
    }
    return killCensus;
  }

  Map<String, List<int>> _calcRedRecNums(
      {required List<int> r3,
      required List<int> r12,
      required List<int> r20,
      required List<int> r25}) {
    Map<String, List<int>> recCensus = {};
    for (int i = 1; i <= 33; i++) {
      recCensus[i.toString()] = [r3[i - 1], r12[i - 1], r20[i - 1], r25[i - 1]];
    }
    return recCensus;
  }

  Map<String, List<int>> _calcRedKillNums(
      {required List<int> k3, required List<int> k6}) {
    Map<String, List<int>> killCensus = {};
    for (int i = 1; i <= 33; i++) {
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
