import 'dart:math';

import 'package:prize_lottery_app/base/model/census_value.dart';
import 'package:prize_lottery_app/views/census/model/synthetic_full_census.dart';
import 'package:prize_lottery_app/views/census/model/synthetic_item_census.dart';

int maxVal(List<int> values) {
  int value = 0;
  for (int i = 0; i < values.length; i++) {
    value = max(values[i], value);
  }
  return value;
}

class ChartData {
  int maxValue = 0;
  Map<String, List<int>> census = {};
}

class SyntheticVip3CensusDo {
  ///
  late String period;
  int maxValue = 0;
  Map<String, List<int>> census = {};

  SyntheticVip3CensusDo(SyntheticVipCensus data) {
    period = data.period;
    _calcCensusTrendNum(data);
  }

  ChartData getChart(int level) {
    ChartData data = ChartData();
    List<int> values = [];
    for (var entry in census.entries) {
      data.census[entry.key] = entry.value.sublist(0, level);
      values.add(entry.value[level - 1]);
    }
    data.maxValue = maxVal(values);
    return data;
  }

  void _calcCensusTrendNum(SyntheticVipCensus data) {
    maxValue = maxVal(data.level150.values[0]);
    census = _calcLevelCensus(
      level10: data.level10.values[0],
      level20: data.level20.values[0],
      level50: data.level50.values[0],
      level100: data.level100.values[0],
      level150: data.level150.values[0],
    );
  }

  Map<String, List<int>> _calcLevelCensus({
    required List<int> level10,
    required List<int> level20,
    required List<int> level50,
    required List<int> level100,
    required List<int> level150,
  }) {
    Map<String, List<int>> census = {};
    for (int i = 0; i < 10; i++) {
      census[i.toString()] = [
        level10[i],
        level20[i],
        level50[i],
        level100[i],
        level150[i],
      ];
    }
    return census;
  }
}

class SyntheticItem3CensusDo {
  ///
  late String period;
  int maxValue = 0;
  Map<String, List<int>> census = {};

  SyntheticItem3CensusDo(SyntheticItemCensus data) {
    period = data.period;
    _calcCensusTrendNum(data);
  }

  ChartData getChart(int level) {
    ChartData data = ChartData();
    List<int> values = [];
    for (var entry in census.entries) {
      data.census[entry.key] = entry.value.sublist(0, level);
      values.add(entry.value[level - 1]);
    }
    data.maxValue = maxVal(values);
    return data;
  }

  void _calcCensusTrendNum(SyntheticItemCensus data) {
    maxValue = maxVal(data.level150.values[0]);
    census = _calcLevelCensus(
      level10: data.level10.values[0],
      level20: data.level20.values[0],
      level50: data.level50.values[0],
      level100: data.level100.values[0],
      level150: data.level150.values[0],
    );
  }

  Map<String, List<int>> _calcLevelCensus({
    required List<int> level10,
    required List<int> level20,
    required List<int> level50,
    required List<int> level100,
    required List<int> level150,
  }) {
    Map<String, List<int>> census = {};
    for (int i = 0; i < 10; i++) {
      census[i.toString()] = [
        level10[i],
        level20[i],
        level50[i],
        level100[i],
        level150[i],
      ];
    }
    return census;
  }
}

class SyntheticFull3CensusDo {
  ///
  late String period;
  int maxValue = 0;
  Map<String, List<int>> census = {};

  SyntheticFull3CensusDo(SyntheticFullCensus data) {
    period = data.period;
    _calcCensusTrendNum(data);
  }

  void _calcCensusTrendNum(SyntheticFullCensus data) {
    maxValue = maxVal(data.level800.values[0]);
    census = _calcLevelCensus(
      level100: data.level100.values[0],
      level200: data.level200.values[0],
      level400: data.level400.values[0],
      level600: data.level600.values[0],
      level800: data.level800.values[0],
    );
  }

  Map<String, List<int>> _calcLevelCensus({
    required List<int> level100,
    required List<int> level200,
    required List<int> level400,
    required List<int> level600,
    required List<int> level800,
  }) {
    Map<String, List<int>> census = {};
    for (int i = 0; i < 10; i++) {
      census[i.toString()] = [
        level100[i],
        level200[i],
        level400[i],
        level600[i],
        level800[i],
      ];
    }
    return census;
  }
}

///
///
class SyntheticVipCensus {
  ///
  late String period;

  ///
  late CensusValue level10;

  ///
  late CensusValue level20;

  ///
  late CensusValue level50;

  ///
  late CensusValue level100;

  ///
  late CensusValue level150;

  SyntheticVipCensus.fromJson(Map<String, dynamic> json) {
    period = json['period'] ?? '';
    level10 = CensusValue.fromJson(json['level10']['values']);
    level20 = CensusValue.fromJson(json['level20']['values']);
    level50 = CensusValue.fromJson(json['level50']['values']);
    level100 = CensusValue.fromJson(json['level100']['values']);
    level150 = CensusValue.fromJson(json['level150']['values']);
  }
}
