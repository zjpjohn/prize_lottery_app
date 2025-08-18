import 'package:prize_lottery_app/views/lottery/model/n3_omit_census.dart';

import 'lottery_omit.dart';

///
///
class SsqOmitCensus {
  ///红球最大遗漏
  late List<OmitValue> redMax;

  ///红球平均遗漏
  late List<OmitValue> redAvg;

  ///红球出现次数
  late List<OmitValue> redFreq;

  ///红球最大连续次数
  late List<OmitValue> redSeries;

  ///蓝球最大遗漏
  late List<OmitValue> blueMax;

  ///蓝球平均遗漏
  late List<OmitValue> blueAvg;

  ///蓝球出现次数
  late List<OmitValue> blueFreq;

  ///蓝球最大连续次数
  late List<OmitValue> blueSeries;

  SsqOmitCensus(List<LotteryOmit> omits) {
    _calcOmitCensus(omits);
  }

  void _calcOmitCensus(List<LotteryOmit> omits) {
    redMax = List.generate(33, (index) {
      List<OmitValue> values = omits.map((e) => e.red!.values[index]).toList();
      int max = calcMax(values);
      return OmitValue(values[0].key, max);
    });
    redAvg = List.generate(33, (index) {
      List<OmitValue> values = omits.map((e) => e.red!.values[index]).toList();
      int max = calcAvg(values);
      return OmitValue(values[0].key, max);
    });
    redFreq = List.generate(33, (index) {
      List<OmitValue> values = omits.map((e) => e.red!.values[index]).toList();
      int max = calcFrequent(values);
      return OmitValue(values[0].key, max);
    });
    redSeries = List.generate(33, (index) {
      List<OmitValue> values = omits.map((e) => e.red!.values[index]).toList();
      int max = calcMaxSeries(values);
      return OmitValue(values[0].key, max);
    });
    blueMax = List.generate(16, (index) {
      List<OmitValue> values = omits.map((e) => e.blue!.values[index]).toList();
      int max = calcMax(values);
      return OmitValue(values[0].key, max);
    });
    blueAvg = List.generate(16, (index) {
      List<OmitValue> values = omits.map((e) => e.blue!.values[index]).toList();
      int max = calcAvg(values);
      return OmitValue(values[0].key, max);
    });
    blueFreq = List.generate(16, (index) {
      List<OmitValue> values = omits.map((e) => e.blue!.values[index]).toList();
      int max = calcFrequent(values);
      return OmitValue(values[0].key, max);
    });
    blueSeries = List.generate(16, (index) {
      List<OmitValue> values = omits.map((e) => e.blue!.values[index]).toList();
      int max = calcMaxSeries(values);
      return OmitValue(values[0].key, max);
    });
  }
}
