import 'dart:math';

import 'package:prize_lottery_app/views/census/model/qlc_chart_census.dart';

///
///
class QlcChartCensusDo {
  ///
  late String period;

  Map<String, List<int>> recCensus = {};
  Map<String, List<int>> killCensus = {};
  int recMax = 0;
  int killMax = 0;

  QlcChartCensusDo(QlcChartCensus census) {
    period = census.period;
    _calcCensusTrendNum(census);
  }

  void _calcCensusTrendNum(QlcChartCensus census) {
    recMax = _max(census.r22.values[0]);
    killMax = _max(census.k6.values[0]);
    recCensus = _calcRecNums(
      r3: census.r3.values[0],
      r12: census.r12.values[0],
      r18: census.r18.values[0],
      r22: census.r22.values[0],
    );
    killCensus = _calcKillNums(
      k3: census.k3.values[0],
      k6: census.k6.values[0],
    );
  }

  Map<String, List<int>> _calcRecNums(
      {required List<int> r3,
      required List<int> r12,
      required List<int> r18,
      required List<int> r22}) {
    Map<String, List<int>> recCensus = {};
    for (int i = 1; i <= 30; i++) {
      recCensus[i.toString()] = [r3[i - 1], r12[i - 1], r18[i - 1], r22[i - 1]];
    }
    return recCensus;
  }

  Map<String, List<int>> _calcKillNums(
      {required List<int> k3, required List<int> k6}) {
    Map<String, List<int>> killCensus = {};
    for (int i = 1; i <= 30; i++) {
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
