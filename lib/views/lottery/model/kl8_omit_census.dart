import 'dart:math';

import 'package:prize_lottery_app/views/lottery/model/lottery_omit.dart';

import 'n3_omit_census.dart';

class Kl8BaseOmit {
  ///统计期号
  late String period;

  ///开奖号码遗漏
  late Omit ballOmit;

  Kl8BaseOmit.fromJson(Map<String, dynamic> json) {
    period = json['period'];
    ballOmit = Omit.fromJson(json['ballOmit']);
  }

  ///
  /// 将期号拆成单个字符
  List<String> get periods {
    return period.split('');
  }

  ///
  /// 获取基础遗漏每行数据
  List<OmitValue> row(int row) {
    int start = row * 10;
    int end = min((row + 1) * 10, ballOmit.values.length);
    return ballOmit.values.sublist(start, end);
  }
}

///
/// 快乐8遗漏数据
///
class Kl8Omit {
  ///统计期号
  late String period;

  ///开奖号码遗漏
  late Omit ballOmit;

  ///大小值遗漏
  late Omit bsOmit;

  ///奇偶遗漏
  late Omit oeOmit;

  ///跨度遗漏
  late Omit kuaOmit;

  ///和值遗漏
  late Omit sumOmit;

  Kl8Omit.fromJson(Map<String, dynamic> json) {
    period = json['period'];
    ballOmit = Omit.fromJson(json['ballOmit']);
    bsOmit = Omit.fromJson(json['bsOmit']);
    oeOmit = Omit.fromJson(json['oeOmit']);
    kuaOmit = Omit.fromJson(json['kuaOmit']);
    sumOmit = Omit.fromJson(json['sumOmit']);
  }
}

///
/// 快乐遗漏统计
class Kl8OmitCensus {
  ///基础号码遗漏统计
  late List<OmitValue> ballMax;
  late List<OmitValue> ballAvg;
  late List<OmitValue> ballFreq;
  late List<OmitValue> ballSeries;

  ///大小值遗漏统计
  late List<OmitValue> bsMax;
  late List<OmitValue> bsAvg;
  late List<OmitValue> bsFreq;
  late List<OmitValue> bsSeries;

  /// 跨度遗漏统计
  late List<OmitValue> kuaMax;
  late List<OmitValue> kuaAvg;
  late List<OmitValue> kuaFreq;
  late List<OmitValue> kuaSeries;

  ///奇偶遗漏统计
  late List<OmitValue> oeMax;
  late List<OmitValue> oeAvg;
  late List<OmitValue> oeFreq;
  late List<OmitValue> oeSeries;

  ///和值遗漏统计
  late List<OmitValue> sumMax;
  late List<OmitValue> sumAvg;
  late List<OmitValue> sumFreq;
  late List<OmitValue> sumSeries;

  Kl8OmitCensus(List<Kl8Omit> omits) {
    _calcOmitCensus(omits);
  }

  void _calcOmitCensus(List<Kl8Omit> omits) {
    ///基础号码遗漏统计
    final int ballLength = omits[0].ballOmit.values.length;
    ballMax = List.generate(ballLength, (index) {
      List<OmitValue> values =
          omits.map((e) => e.ballOmit.values[index]).toList();
      return OmitValue(values[0].key, calcMax(values));
    });
    ballAvg = List.generate(ballLength, (index) {
      List<OmitValue> values =
          omits.map((e) => e.ballOmit.values[index]).toList();
      return OmitValue(values[0].key, calcAvg(values));
    });
    ballFreq = List.generate(ballLength, (index) {
      List<OmitValue> values =
          omits.map((e) => e.ballOmit.values[index]).toList();
      return OmitValue(values[0].key, calcFrequent(values));
    });
    ballSeries = List.generate(ballLength, (index) {
      List<OmitValue> values =
          omits.map((e) => e.ballOmit.values[index]).toList();
      return OmitValue(values[0].key, calcMaxSeries(values));
    });

    ///大小比值遗漏统计
    final int bsLength = omits[0].bsOmit.values.length;
    bsMax = List.generate(bsLength, (index) {
      List<OmitValue> values =
          omits.map((e) => e.bsOmit.values[index]).toList();
      return OmitValue(values[0].key, calcMax(values));
    });
    bsAvg = List.generate(bsLength, (index) {
      List<OmitValue> values =
          omits.map((e) => e.bsOmit.values[index]).toList();
      return OmitValue(values[0].key, calcAvg(values));
    });
    bsFreq = List.generate(bsLength, (index) {
      List<OmitValue> values =
          omits.map((e) => e.bsOmit.values[index]).toList();
      return OmitValue(values[0].key, calcFrequent(values));
    });
    bsSeries = List.generate(bsLength, (index) {
      List<OmitValue> values =
          omits.map((e) => e.bsOmit.values[index]).toList();
      return OmitValue(values[0].key, calcMaxSeries(values));
    });

    /// 跨度遗漏统计
    final int kuaLength = omits[0].kuaOmit.values.length;
    kuaMax = List.generate(kuaLength, (index) {
      List<OmitValue> values =
          omits.map((e) => e.kuaOmit.values[index]).toList();
      return OmitValue(values[0].key, calcMax(values));
    });
    kuaAvg = List.generate(kuaLength, (index) {
      List<OmitValue> values =
          omits.map((e) => e.kuaOmit.values[index]).toList();
      return OmitValue(values[0].key, calcAvg(values));
    });
    kuaFreq = List.generate(kuaLength, (index) {
      List<OmitValue> values =
          omits.map((e) => e.kuaOmit.values[index]).toList();
      return OmitValue(values[0].key, calcFrequent(values));
    });
    kuaSeries = List.generate(kuaLength, (index) {
      List<OmitValue> values =
          omits.map((e) => e.kuaOmit.values[index]).toList();
      return OmitValue(values[0].key, calcMaxSeries(values));
    });

    ///奇偶遗漏统计
    final int oeLength = omits[0].oeOmit.values.length;
    oeMax = List.generate(oeLength, (index) {
      List<OmitValue> values =
          omits.map((e) => e.oeOmit.values[index]).toList();
      return OmitValue(values[0].key, calcMax(values));
    });
    oeAvg = List.generate(oeLength, (index) {
      List<OmitValue> values =
          omits.map((e) => e.oeOmit.values[index]).toList();
      return OmitValue(values[0].key, calcAvg(values));
    });
    oeFreq = List.generate(oeLength, (index) {
      List<OmitValue> values =
          omits.map((e) => e.oeOmit.values[index]).toList();
      return OmitValue(values[0].key, calcFrequent(values));
    });
    oeSeries = List.generate(oeLength, (index) {
      List<OmitValue> values =
          omits.map((e) => e.oeOmit.values[index]).toList();
      return OmitValue(values[0].key, calcMaxSeries(values));
    });

    ///和值遗漏统计
    final int sumLength = omits[0].sumOmit.values.length;
    sumMax = List.generate(sumLength, (index) {
      List<OmitValue> values =
          omits.map((e) => e.sumOmit.values[index]).toList();
      return OmitValue(values[0].key, calcMax(values));
    });
    sumAvg = List.generate(sumLength, (index) {
      List<OmitValue> values =
          omits.map((e) => e.sumOmit.values[index]).toList();
      return OmitValue(values[0].key, calcAvg(values));
    });
    sumFreq = List.generate(sumLength, (index) {
      List<OmitValue> values =
          omits.map((e) => e.sumOmit.values[index]).toList();
      return OmitValue(values[0].key, calcFrequent(values));
    });
    sumSeries = List.generate(sumLength, (index) {
      List<OmitValue> values =
          omits.map((e) => e.sumOmit.values[index]).toList();
      return OmitValue(values[0].key, calcMaxSeries(values));
    });
  }
}
