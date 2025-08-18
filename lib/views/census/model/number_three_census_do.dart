import 'dart:math';

import 'package:prize_lottery_app/views/census/model/number_three_census.dart';

///
///
class NumberThreeCensusDo {
  ///
  late String period;

  ///
  /// 趋势图标数据
  Map<String, List<int>> recCensus = {};
  Map<String, List<int>> killCensus = {};
  int recMax = 0;
  int killMax = 0;

  NumberThreeCensusDo(NumberThreeCensus census) {
    period = census.period;
    _calcCensusTrendNum(census);
  }

  void _calcCensusTrendNum(NumberThreeCensus census) {
    recMax = _max(census.c7.values[0]);
    killMax = _max(census.k2.values[0]);
    recCensus = _calcRecNums(
      d3: census.d3.values[0],
      c5: census.c5.values[0],
      c6: census.c6.values[0],
      c7: census.c7.values[0],
    );
    killCensus = _calcKillNums(
      k1: census.k1.values[0],
      k2: census.k2.values[0],
    );
  }

  Map<String, List<int>> _calcRecNums(
      {required List<int> d3,
      required List<int> c5,
      required List<int> c6,
      required List<int> c7}) {
    Map<String, List<int>> recCensus = {};
    for (int i = 0; i < 10; i++) {
      recCensus[i.toString()] = [d3[i], c5[i], c6[i], c7[i]];
    }
    return recCensus;
  }

  Map<String, List<int>> _calcKillNums(
      {required List<int> k1, required List<int> k2}) {
    Map<String, List<int>> killCensus = {};
    for (int i = 0; i < 10; i++) {
      killCensus[i.toString()] = [k1[i], k2[i]];
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
