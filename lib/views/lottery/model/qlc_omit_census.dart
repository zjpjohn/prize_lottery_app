import 'package:prize_lottery_app/views/lottery/model/lottery_omit.dart';
import 'package:prize_lottery_app/views/lottery/model/n3_omit_census.dart';

class QlcOmitCensus {
  ///红球最大遗漏
  late List<OmitValue> redMax;

  ///红球平均遗漏
  late List<OmitValue> redAvg;

  ///红球出现次数
  late List<OmitValue> redFreq;

  ///红球最大连续次数
  late List<OmitValue> redSeries;

  QlcOmitCensus(List<LotteryOmit> omits) {
    _calcOmitCensus(omits);
  }

  void _calcOmitCensus(List<LotteryOmit> omits) {
    redMax = List.generate(30, (index) {
      List<OmitValue> values = omits.map((e) => e.red!.values[index]).toList();
      int max = calcMax(values);
      return OmitValue(values[0].key, max);
    });
    redAvg = List.generate(30, (index) {
      List<OmitValue> values = omits.map((e) => e.red!.values[index]).toList();
      int max = calcAvg(values);
      return OmitValue(values[0].key, max);
    });
    redFreq = List.generate(30, (index) {
      List<OmitValue> values = omits.map((e) => e.red!.values[index]).toList();
      int max = calcFrequent(values);
      return OmitValue(values[0].key, max);
    });
    redSeries = List.generate(30, (index) {
      List<OmitValue> values = omits.map((e) => e.red!.values[index]).toList();
      int max = calcMaxSeries(values);
      return OmitValue(values[0].key, max);
    });
  }
}
