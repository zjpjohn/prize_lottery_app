import 'dart:math';

import 'package:prize_lottery_app/views/lottery/model/lottery_omit.dart';

/// 最大遗漏次数
int calcMax(List<OmitValue> values) {
  return values.map((e) => e.value).toList().reduce(max);
}

/// 平均遗漏
int calcAvg(List<OmitValue> values) {
  List<int> vList = values.map((e) => e.value).where((e) => e > 0).toList();
  int value = vList.reduce((v, e) => v + e);
  return value ~/ vList.length;
}

///出现次数
int calcFrequent(List<OmitValue> values) {
  return values.map((e) => e.value).where((e) => e == 0).length;
}

///计算连出最大次数
int calcMaxSeries(List<OmitValue> values) {
  int count = 0, max = 0;
  for (int i = 0; i < values.length; i++) {
    OmitValue value = values[i];
    if (value.value == 0) {
      count = count + 1;
      continue;
    }
    if (count > max) {
      max = count;
    }
    count = 0;
  }
  return count > max ? count : max;
}

///
///
class N3OmitCensus {
  ///
  late int g6Max;

  ///
  late int g6Avg;

  ///
  late int g6Freq;

  ///
  late int g6Series;

  ///
  late int g3Max;

  ///
  late int g3Avg;

  ///
  late int g3Freq;

  ///
  late int g3Series;

  ///
  late int g1Max;

  ///
  late int g1Avg;

  ///
  late int g1Freq;

  ///
  late int g1Series;

  ///
  late List<OmitValue> ballMax;

  ///
  late List<OmitValue> ballAvg;

  ///
  late List<OmitValue> ballFreq;

  ///
  late List<OmitValue> ballSeries;

  ///
  late List<OmitValue> baiMax;

  ///
  late List<OmitValue> baiAvg;

  ///
  late List<OmitValue> baiFreq;

  ///
  late List<OmitValue> baiSeries;

  ///
  late List<OmitValue> shiMax;

  ///
  late List<OmitValue> shiAvg;

  ///
  late List<OmitValue> shiFreq;

  ///
  late List<OmitValue> shiSeries;

  ///
  late List<OmitValue> geMax;

  ///
  late List<OmitValue> geAvg;

  ///
  late List<OmitValue> geFreq;

  ///
  late List<OmitValue> geSeries;

  N3OmitCensus(List<LotteryOmit> omits) {
    _calcCensus(omits);
  }

  void _calcCensus(List<LotteryOmit> omits) {
    g6Max = calcMax(omits.map((e) => e.extra!.values[0]).toList());
    g6Avg = calcAvg(omits.map((e) => e.extra!.values[0]).toList());
    g6Freq = calcFrequent(omits.map((e) => e.extra!.values[0]).toList());
    g6Series = calcMaxSeries(omits.map((e) => e.extra!.values[0]).toList());

    ///
    g3Max = calcMax(omits.map((e) => e.extra!.values[1]).toList());
    g3Avg = calcAvg(omits.map((e) => e.extra!.values[1]).toList());
    g3Freq = calcFrequent(omits.map((e) => e.extra!.values[1]).toList());
    g3Series = calcMaxSeries(omits.map((e) => e.extra!.values[1]).toList());

    ///
    g1Max = calcMax(omits.map((e) => e.extra!.values[2]).toList());
    g1Avg = calcAvg(omits.map((e) => e.extra!.values[2]).toList());
    g1Freq = calcFrequent(omits.map((e) => e.extra!.values[2]).toList());
    g1Series = calcMaxSeries(omits.map((e) => e.extra!.values[2]).toList());

    ///
    ballMax = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.red!.values[index]).toList();
      int max = calcMax(values);
      return OmitValue(values[0].key, max);
    });
    ballAvg = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.red!.values[index]).toList();
      int max = calcAvg(values);
      return OmitValue(values[0].key, max);
    });
    ballFreq = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.red!.values[index]).toList();
      int max = calcFrequent(values);
      return OmitValue(values[0].key, max);
    });
    ballSeries = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.red!.values[index]).toList();
      int max = calcMaxSeries(values);
      return OmitValue(values[0].key, max);
    });

    ///
    baiMax = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cb1!.values[index]).toList();
      int max = calcMax(values);
      return OmitValue(values[0].key, max);
    });
    baiAvg = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cb1!.values[index]).toList();
      int max = calcAvg(values);
      return OmitValue(values[0].key, max);
    });
    baiFreq = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cb1!.values[index]).toList();
      int max = calcFrequent(values);
      return OmitValue(values[0].key, max);
    });
    baiSeries = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cb1!.values[index]).toList();
      int max = calcMaxSeries(values);
      return OmitValue(values[0].key, max);
    });

    ///
    shiMax = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cb2!.values[index]).toList();
      int max = calcMax(values);
      return OmitValue(values[0].key, max);
    });
    shiAvg = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cb2!.values[index]).toList();
      int max = calcAvg(values);
      return OmitValue(values[0].key, max);
    });
    shiFreq = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cb2!.values[index]).toList();
      int max = calcFrequent(values);
      return OmitValue(values[0].key, max);
    });
    shiSeries = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cb2!.values[index]).toList();
      int max = calcMaxSeries(values);
      return OmitValue(values[0].key, max);
    });

    ///
    geMax = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cb3!.values[index]).toList();
      int max = calcMax(values);
      return OmitValue(values[0].key, max);
    });
    geAvg = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cb3!.values[index]).toList();
      int max = calcAvg(values);
      return OmitValue(values[0].key, max);
    });
    geFreq = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cb3!.values[index]).toList();
      int max = calcFrequent(values);
      return OmitValue(values[0].key, max);
    });
    geSeries = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cb3!.values[index]).toList();
      int max = calcMaxSeries(values);
      return OmitValue(values[0].key, max);
    });
  }
}

///
/// 和值遗漏统计
class N3SumCensus {
  ///和值基础遗漏统计
  late List<OmitValue> baseAvg;
  late List<OmitValue> baseMax;
  late List<OmitValue> baseFreq;
  late List<OmitValue> baseSeries;

  ///和值尾数遗漏统计
  late List<OmitValue> tailAvg;
  late List<OmitValue> tailMax;
  late List<OmitValue> tailFreq;
  late List<OmitValue> tailSeries;

  ///和值尾数振幅遗漏统计
  late List<OmitValue> ampAvg;
  late List<OmitValue> ampMax;
  late List<OmitValue> ampFreq;
  late List<OmitValue> ampSeries;

  ///和值012路遗漏统计
  late List<OmitValue> ottAvg;
  late List<OmitValue> ottMax;
  late List<OmitValue> ottFreq;
  late List<OmitValue> ottSeries;

  ///和值大中小遗漏统计
  late List<OmitValue> bmsAvg;
  late List<OmitValue> bmsMax;
  late List<OmitValue> bmsFreq;
  late List<OmitValue> bmsSeries;

  N3SumCensus(List<SumOmit> omits) {
    _calcOmitCensus(omits);
  }

  void _calcOmitCensus(List<SumOmit> omits) {
    baseAvg = List.generate(28, (index) {
      List<OmitValue> values =
          omits.map((e) => e.baseOmit.values[index]).toList();
      int avg = calcAvg(values);
      return OmitValue(values[0].key, avg);
    });
    baseMax = List.generate(28, (index) {
      List<OmitValue> values =
          omits.map((e) => e.baseOmit.values[index]).toList();
      int max = calcMax(values);
      return OmitValue(values[0].key, max);
    });
    baseFreq = List.generate(28, (index) {
      List<OmitValue> values =
          omits.map((e) => e.baseOmit.values[index]).toList();
      int frequent = calcFrequent(values);
      return OmitValue(values[0].key, frequent);
    });
    baseSeries = List.generate(28, (index) {
      List<OmitValue> values =
          omits.map((e) => e.baseOmit.values[index]).toList();
      int series = calcMaxSeries(values);
      return OmitValue(values[0].key, series);
    });
    tailAvg = List.generate(10, (index) {
      List<OmitValue> values =
          omits.map((e) => e.tailOmit.values[index]).toList();
      int avg = calcAvg(values);
      return OmitValue(values[0].key, avg);
    });
    tailMax = List.generate(10, (index) {
      List<OmitValue> values =
          omits.map((e) => e.tailOmit.values[index]).toList();
      int max = calcMax(values);
      return OmitValue(values[0].key, max);
    });
    tailFreq = List.generate(10, (index) {
      List<OmitValue> values =
          omits.map((e) => e.tailOmit.values[index]).toList();
      int frequent = calcFrequent(values);
      return OmitValue(values[0].key, frequent);
    });
    tailSeries = List.generate(10, (index) {
      List<OmitValue> values =
          omits.map((e) => e.tailOmit.values[index]).toList();
      int series = calcMaxSeries(values);
      return OmitValue(values[0].key, series);
    });
    ampAvg = List.generate(10, (index) {
      List<OmitValue> values =
          omits.map((e) => e.tailAmp.values[index]).toList();
      int avg = calcAvg(values);
      return OmitValue(values[0].key, avg);
    });
    ampMax = List.generate(10, (index) {
      List<OmitValue> values =
          omits.map((e) => e.tailAmp.values[index]).toList();
      int max = calcMax(values);
      return OmitValue(values[0].key, max);
    });
    ampFreq = List.generate(10, (index) {
      List<OmitValue> values =
          omits.map((e) => e.tailAmp.values[index]).toList();
      int frequent = calcFrequent(values);
      return OmitValue(values[0].key, frequent);
    });
    ampSeries = List.generate(10, (index) {
      List<OmitValue> values =
          omits.map((e) => e.tailAmp.values[index]).toList();
      int series = calcMaxSeries(values);
      return OmitValue(values[0].key, series);
    });
    ottAvg = List.generate(3, (index) {
      List<OmitValue> values =
          omits.map((e) => e.ottOmit.values[index]).toList();
      int avg = calcAvg(values);
      return OmitValue(values[0].key, avg);
    });
    ottMax = List.generate(3, (index) {
      List<OmitValue> values =
          omits.map((e) => e.ottOmit.values[index]).toList();
      int max = calcMax(values);
      return OmitValue(values[0].key, max);
    });
    ottFreq = List.generate(3, (index) {
      List<OmitValue> values =
          omits.map((e) => e.ottOmit.values[index]).toList();
      int frequent = calcFrequent(values);
      return OmitValue(values[0].key, frequent);
    });
    ottSeries = List.generate(3, (index) {
      List<OmitValue> values =
          omits.map((e) => e.ottOmit.values[index]).toList();
      int series = calcMaxSeries(values);
      return OmitValue(values[0].key, series);
    });
    bmsAvg = List.generate(3, (index) {
      List<OmitValue> values =
          omits.map((e) => e.bmsOmit.values[index]).toList();
      int avg = calcAvg(values);
      return OmitValue(values[0].key, avg);
    });
    bmsMax = List.generate(3, (index) {
      List<OmitValue> values =
          omits.map((e) => e.bmsOmit.values[index]).toList();
      int max = calcMax(values);
      return OmitValue(values[0].key, max);
    });
    bmsFreq = List.generate(3, (index) {
      List<OmitValue> values =
          omits.map((e) => e.bmsOmit.values[index]).toList();
      int frequent = calcFrequent(values);
      return OmitValue(values[0].key, frequent);
    });
    bmsSeries = List.generate(3, (index) {
      List<OmitValue> values =
          omits.map((e) => e.bmsOmit.values[index]).toList();
      int series = calcMaxSeries(values);
      return OmitValue(values[0].key, series);
    });
  }
}

///
/// 跨度遗漏统计
class N3KuaCensus {
  ///跨度基础遗漏统计
  late List<OmitValue> baseAvg;
  late List<OmitValue> baseMax;
  late List<OmitValue> baseFreq;
  late List<OmitValue> baseSeries;

  ///跨度振幅遗漏统计
  late List<OmitValue> ampAvg;
  late List<OmitValue> ampMax;
  late List<OmitValue> ampFreq;
  late List<OmitValue> ampSeries;

  ///跨度振幅的振幅遗漏统计
  late List<OmitValue> ampAmpAvg;
  late List<OmitValue> ampAmpMax;
  late List<OmitValue> ampAmpFreq;
  late List<OmitValue> ampAmpSeries;

  ///跨度012路遗漏统计
  late List<OmitValue> ottAvg;
  late List<OmitValue> ottMax;
  late List<OmitValue> ottFreq;
  late List<OmitValue> ottSeries;

  ///跨度大中小遗漏统计
  late List<OmitValue> bmsAvg;
  late List<OmitValue> bmsMax;
  late List<OmitValue> bmsFreq;
  late List<OmitValue> bmsSeries;

  N3KuaCensus(List<KuaOmit> omits) {
    _calcOmitCensus(omits);
  }

  void _calcOmitCensus(List<KuaOmit> omits) {
    baseAvg = List.generate(10, (index) {
      List<OmitValue> values =
          omits.map((e) => e.baseOmit.values[index]).toList();
      int avg = calcAvg(values);
      return OmitValue(values[0].key, avg);
    });
    baseMax = List.generate(10, (index) {
      List<OmitValue> values =
          omits.map((e) => e.baseOmit.values[index]).toList();
      int max = calcMax(values);
      return OmitValue(values[0].key, max);
    });
    baseFreq = List.generate(10, (index) {
      List<OmitValue> values =
          omits.map((e) => e.baseOmit.values[index]).toList();
      int frequent = calcFrequent(values);
      return OmitValue(values[0].key, frequent);
    });
    baseSeries = List.generate(10, (index) {
      List<OmitValue> values =
          omits.map((e) => e.baseOmit.values[index]).toList();
      int series = calcMaxSeries(values);
      return OmitValue(values[0].key, series);
    });
    ampAvg = List.generate(10, (index) {
      List<OmitValue> values =
          omits.map((e) => e.ampOmit.values[index]).toList();
      int avg = calcAvg(values);
      return OmitValue(values[0].key, avg);
    });
    ampMax = List.generate(10, (index) {
      List<OmitValue> values =
          omits.map((e) => e.ampOmit.values[index]).toList();
      int max = calcMax(values);
      return OmitValue(values[0].key, max);
    });
    ampFreq = List.generate(10, (index) {
      List<OmitValue> values =
          omits.map((e) => e.ampOmit.values[index]).toList();
      int frequent = calcFrequent(values);
      return OmitValue(values[0].key, frequent);
    });
    ampSeries = List.generate(10, (index) {
      List<OmitValue> values =
          omits.map((e) => e.ampOmit.values[index]).toList();
      int series = calcMaxSeries(values);
      return OmitValue(values[0].key, series);
    });
    ampAmpAvg = List.generate(10, (index) {
      List<OmitValue> values =
          omits.map((e) => e.ampAmp.values[index]).toList();
      int avg = calcAvg(values);
      return OmitValue(values[0].key, avg);
    });
    ampAmpMax = List.generate(10, (index) {
      List<OmitValue> values =
          omits.map((e) => e.ampAmp.values[index]).toList();
      int max = calcMax(values);
      return OmitValue(values[0].key, max);
    });
    ampAmpFreq = List.generate(10, (index) {
      List<OmitValue> values =
          omits.map((e) => e.ampAmp.values[index]).toList();
      int frequent = calcFrequent(values);
      return OmitValue(values[0].key, frequent);
    });
    ampAmpSeries = List.generate(10, (index) {
      List<OmitValue> values =
          omits.map((e) => e.ampAmp.values[index]).toList();
      int series = calcMaxSeries(values);
      return OmitValue(values[0].key, series);
    });
    ottAvg = List.generate(3, (index) {
      List<OmitValue> values =
          omits.map((e) => e.ottOmit.values[index]).toList();
      int avg = calcAvg(values);
      return OmitValue(values[0].key, avg);
    });
    ottMax = List.generate(3, (index) {
      List<OmitValue> values =
          omits.map((e) => e.ottOmit.values[index]).toList();
      int max = calcMax(values);
      return OmitValue(values[0].key, max);
    });
    ottFreq = List.generate(3, (index) {
      List<OmitValue> values =
          omits.map((e) => e.ottOmit.values[index]).toList();
      int frequent = calcFrequent(values);
      return OmitValue(values[0].key, frequent);
    });
    ottSeries = List.generate(3, (index) {
      List<OmitValue> values =
          omits.map((e) => e.ottOmit.values[index]).toList();
      int series = calcMaxSeries(values);
      return OmitValue(values[0].key, series);
    });
    bmsAvg = List.generate(3, (index) {
      List<OmitValue> values =
          omits.map((e) => e.bmsOmit.values[index]).toList();
      int avg = calcAvg(values);
      return OmitValue(values[0].key, avg);
    });
    bmsMax = List.generate(3, (index) {
      List<OmitValue> values =
          omits.map((e) => e.bmsOmit.values[index]).toList();
      int max = calcMax(values);
      return OmitValue(values[0].key, max);
    });
    bmsFreq = List.generate(3, (index) {
      List<OmitValue> values =
          omits.map((e) => e.bmsOmit.values[index]).toList();
      int frequent = calcFrequent(values);
      return OmitValue(values[0].key, frequent);
    });
    bmsSeries = List.generate(3, (index) {
      List<OmitValue> values =
          omits.map((e) => e.bmsOmit.values[index]).toList();
      int series = calcMaxSeries(values);
      return OmitValue(values[0].key, series);
    });
  }
}

class MatchCensus {
  ///
  late List<OmitValue> codeMax;
  late List<OmitValue> codeAvg;
  late List<OmitValue> codeFreq;
  late List<OmitValue> codeSeries;

  ///
  late List<OmitValue> comMax;
  late List<OmitValue> comAvg;
  late List<OmitValue> comFreq;
  late List<OmitValue> comSeries;

  ///
  late OmitValue allMax;
  late OmitValue allAvg;
  late OmitValue allFreq;
  late OmitValue allSeries;

  MatchCensus(List<MatchOmit> omits) {
    _calcMatchCensus(omits);
  }

  void _calcMatchCensus(List<MatchOmit> omits) {
    ///对码遗漏统计
    codeAvg = List.generate(5, (index) {
      List<OmitValue> values =
          omits.map((e) => e.codeOmit.values[index]).toList();
      int avg = calcAvg(values);
      return OmitValue(values[0].key, avg);
    });
    codeMax = List.generate(5, (index) {
      List<OmitValue> values =
          omits.map((e) => e.codeOmit.values[index]).toList();
      int max = calcMax(values);
      return OmitValue(values[0].key, max);
    });
    codeFreq = List.generate(5, (index) {
      List<OmitValue> values =
          omits.map((e) => e.codeOmit.values[index]).toList();
      int frequent = calcFrequent(values);
      return OmitValue(values[0].key, frequent);
    });
    codeSeries = List.generate(5, (index) {
      List<OmitValue> values =
          omits.map((e) => e.codeOmit.values[index]).toList();
      int series = calcMaxSeries(values);
      return OmitValue(values[0].key, series);
    });

    ///组选对码遗漏统计
    comAvg = List.generate(5, (index) {
      List<OmitValue> values =
          omits.map((e) => e.comOmit.values[index]).toList();
      int avg = calcAvg(values);
      return OmitValue(values[0].key, avg);
    });
    comMax = List.generate(5, (index) {
      List<OmitValue> values =
          omits.map((e) => e.comOmit.values[index]).toList();
      int max = calcMax(values);
      return OmitValue(values[0].key, max);
    });
    comFreq = List.generate(5, (index) {
      List<OmitValue> values =
          omits.map((e) => e.comOmit.values[index]).toList();
      int frequent = calcFrequent(values);
      return OmitValue(values[0].key, frequent);
    });
    comSeries = List.generate(5, (index) {
      List<OmitValue> values =
          omits.map((e) => e.comOmit.values[index]).toList();
      int series = calcMaxSeries(values);
      return OmitValue(values[0].key, series);
    });

    ///对码总遗漏统计
    List<OmitValue> allOmits = omits.map((e) => e.allOmit).toList();
    allAvg = OmitValue('', calcAvg(allOmits));
    allMax = OmitValue('', calcMax(allOmits));
    allFreq = OmitValue('', calcFrequent(allOmits));
    allSeries = OmitValue('', calcMaxSeries(allOmits));
  }
}

class TrendCensus {
  ///
  late List<OmitValue> formMax;

  ///
  late List<OmitValue> formAvg;

  ///
  late List<OmitValue> formFreq;

  ///
  late List<OmitValue> formSeries;

  ///
  late List<OmitValue> ottMax;

  ///
  late List<OmitValue> ottAvg;

  ///
  late List<OmitValue> ottFreq;

  ///
  late List<OmitValue> ottSeries;

  ///
  late List<OmitValue> modeMax;

  ///
  late List<OmitValue> modeAvg;

  ///
  late List<OmitValue> modeFreq;

  ///
  late List<OmitValue> modeSeries;

  ///
  late List<OmitValue> bsMax;

  ///
  late List<OmitValue> bsAvg;

  ///
  late List<OmitValue> bsFreq;

  ///
  late List<OmitValue> bsSeries;

  ///
  late List<OmitValue> oeMax;

  ///
  late List<OmitValue> oeAvg;

  ///
  late List<OmitValue> oeFreq;

  ///
  late List<OmitValue> oeSeries;

  TrendCensus(List<TrendOmit> omits) {
    _calcOmitCensus(omits);
  }

  void _calcOmitCensus(List<TrendOmit> omits) {
    ///版型走势统计
    formAvg = List.generate(5, (index) {
      List<OmitValue> values =
          omits.map((e) => e.formOmit.values[index]).toList();
      int avg = calcAvg(values);
      return OmitValue(values[0].key, avg);
    });
    formMax = List.generate(5, (index) {
      List<OmitValue> values =
          omits.map((e) => e.formOmit.values[index]).toList();
      int max = calcMax(values);
      return OmitValue(values[0].key, max);
    });
    formFreq = List.generate(5, (index) {
      List<OmitValue> values =
          omits.map((e) => e.formOmit.values[index]).toList();
      int frequent = calcFrequent(values);
      return OmitValue(values[0].key, frequent);
    });
    formSeries = List.generate(5, (index) {
      List<OmitValue> values =
          omits.map((e) => e.formOmit.values[index]).toList();
      int series = calcMaxSeries(values);
      return OmitValue(values[0].key, series);
    });

    ///012路形态统计
    ottAvg = List.generate(7, (index) {
      List<OmitValue> values =
          omits.map((e) => e.ottOmit.values[index]).toList();
      int avg = calcAvg(values);
      return OmitValue(values[0].key, avg);
    });
    ottMax = List.generate(7, (index) {
      List<OmitValue> values =
          omits.map((e) => e.ottOmit.values[index]).toList();
      int max = calcMax(values);
      return OmitValue(values[0].key, max);
    });
    ottFreq = List.generate(7, (index) {
      List<OmitValue> values =
          omits.map((e) => e.ottOmit.values[index]).toList();
      int frequent = calcFrequent(values);
      return OmitValue(values[0].key, frequent);
    });
    ottSeries = List.generate(7, (index) {
      List<OmitValue> values =
          omits.map((e) => e.ottOmit.values[index]).toList();
      int series = calcMaxSeries(values);
      return OmitValue(values[0].key, series);
    });

    ///凹凸形态统计
    modeAvg = List.generate(5, (index) {
      List<OmitValue> values =
          omits.map((e) => e.modeOmit.values[index]).toList();
      int avg = calcAvg(values);
      return OmitValue(values[0].key, avg);
    });
    modeMax = List.generate(5, (index) {
      List<OmitValue> values =
          omits.map((e) => e.modeOmit.values[index]).toList();
      int max = calcMax(values);
      return OmitValue(values[0].key, max);
    });
    modeFreq = List.generate(5, (index) {
      List<OmitValue> values =
          omits.map((e) => e.modeOmit.values[index]).toList();
      int frequent = calcFrequent(values);
      return OmitValue(values[0].key, frequent);
    });
    modeSeries = List.generate(5, (index) {
      List<OmitValue> values =
          omits.map((e) => e.modeOmit.values[index]).toList();
      int series = calcMaxSeries(values);
      return OmitValue(values[0].key, series);
    });

    ///大小形态统计
    bsAvg = List.generate(4, (index) {
      List<OmitValue> values =
          omits.map((e) => e.bsOmit.values[index]).toList();
      int avg = calcAvg(values);
      return OmitValue(values[0].key, avg);
    });
    bsMax = List.generate(4, (index) {
      List<OmitValue> values =
          omits.map((e) => e.bsOmit.values[index]).toList();
      int max = calcMax(values);
      return OmitValue(values[0].key, max);
    });
    bsFreq = List.generate(4, (index) {
      List<OmitValue> values =
          omits.map((e) => e.bsOmit.values[index]).toList();
      int frequent = calcFrequent(values);
      return OmitValue(values[0].key, frequent);
    });
    bsSeries = List.generate(4, (index) {
      List<OmitValue> values =
          omits.map((e) => e.bsOmit.values[index]).toList();
      int series = calcMaxSeries(values);
      return OmitValue(values[0].key, series);
    });

    ///奇偶形态统计
    oeAvg = List.generate(4, (index) {
      List<OmitValue> values =
          omits.map((e) => e.oeOmit.values[index]).toList();
      int avg = calcAvg(values);
      return OmitValue(values[0].key, avg);
    });
    oeMax = List.generate(4, (index) {
      List<OmitValue> values =
          omits.map((e) => e.oeOmit.values[index]).toList();
      int max = calcMax(values);
      return OmitValue(values[0].key, max);
    });
    oeFreq = List.generate(4, (index) {
      List<OmitValue> values =
          omits.map((e) => e.oeOmit.values[index]).toList();
      int frequent = calcFrequent(values);
      return OmitValue(values[0].key, frequent);
    });
    oeSeries = List.generate(4, (index) {
      List<OmitValue> values =
          omits.map((e) => e.oeOmit.values[index]).toList();
      int series = calcMaxSeries(values);
      return OmitValue(values[0].key, series);
    });
  }
}

class ItemOmitCensus {
  ///基础遗漏统计
  late List<OmitValue> cbAvg;
  late List<OmitValue> cbMax;
  late List<OmitValue> cbFreq;
  late List<OmitValue> cbSeries;

  ///振幅遗漏统计
  late List<OmitValue> ampAvg;
  late List<OmitValue> ampMax;
  late List<OmitValue> ampFreq;
  late List<OmitValue> ampSeries;

  ///升平降遗漏统计
  late List<OmitValue> aodAvg;
  late List<OmitValue> aodMax;
  late List<OmitValue> aodFreq;
  late List<OmitValue> aodSeries;

  ///大小遗漏统计
  late List<OmitValue> bosAvg;
  late List<OmitValue> bosMax;
  late List<OmitValue> bosFreq;
  late List<OmitValue> bosSeries;

  ///奇偶遗漏统计
  late List<OmitValue> oeAvg;
  late List<OmitValue> oeMax;
  late List<OmitValue> oeFreq;
  late List<OmitValue> oeSeries;

  ItemOmitCensus(List<CbItemOmit> omits) {
    _calcItemCensus(omits);
  }

  void _calcItemCensus(List<CbItemOmit> omits) {
    cbAvg = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cb.values[index]).toList();
      int avg = calcAvg(values);
      return OmitValue(values[0].key, avg);
    });
    cbMax = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cb.values[index]).toList();
      int max = calcMax(values);
      return OmitValue(values[0].key, max);
    });
    cbFreq = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cb.values[index]).toList();
      int frequent = calcFrequent(values);
      return OmitValue(values[0].key, frequent);
    });
    cbSeries = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cb.values[index]).toList();
      int series = calcMaxSeries(values);
      return OmitValue(values[0].key, series);
    });

    ///
    ampAvg = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cbAmp.values[index]).toList();
      int avg = calcAvg(values);
      return OmitValue(values[0].key, avg);
    });
    ampMax = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cbAmp.values[index]).toList();
      int max = calcMax(values);
      return OmitValue(values[0].key, max);
    });
    ampFreq = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cbAmp.values[index]).toList();
      int frequent = calcFrequent(values);
      return OmitValue(values[0].key, frequent);
    });
    ampSeries = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cbAmp.values[index]).toList();
      int series = calcMaxSeries(values);
      return OmitValue(values[0].key, series);
    });

    ///
    aodAvg = List.generate(3, (index) {
      List<OmitValue> values = omits.map((e) => e.cbAod.values[index]).toList();
      int avg = calcAvg(values);
      return OmitValue(values[0].key, avg);
    });
    aodMax = List.generate(3, (index) {
      List<OmitValue> values = omits.map((e) => e.cbAod.values[index]).toList();
      int max = calcMax(values);
      return OmitValue(values[0].key, max);
    });
    aodFreq = List.generate(3, (index) {
      List<OmitValue> values = omits.map((e) => e.cbAod.values[index]).toList();
      int frequent = calcFrequent(values);
      return OmitValue(values[0].key, frequent);
    });
    aodSeries = List.generate(3, (index) {
      List<OmitValue> values = omits.map((e) => e.cbAod.values[index]).toList();
      int series = calcMaxSeries(values);
      return OmitValue(values[0].key, series);
    });

    ///
    bosAvg = List.generate(2, (index) {
      List<OmitValue> values = omits.map((e) => e.cbBos.values[index]).toList();
      int avg = calcAvg(values);
      return OmitValue(values[0].key, avg);
    });
    bosMax = List.generate(2, (index) {
      List<OmitValue> values = omits.map((e) => e.cbBos.values[index]).toList();
      int max = calcMax(values);
      return OmitValue(values[0].key, max);
    });
    bosFreq = List.generate(2, (index) {
      List<OmitValue> values = omits.map((e) => e.cbBos.values[index]).toList();
      int frequent = calcFrequent(values);
      return OmitValue(values[0].key, frequent);
    });
    bosSeries = List.generate(2, (index) {
      List<OmitValue> values = omits.map((e) => e.cbBos.values[index]).toList();
      int series = calcMaxSeries(values);
      return OmitValue(values[0].key, series);
    });

    ///
    oeAvg = List.generate(2, (index) {
      List<OmitValue> values = omits.map((e) => e.cbOe.values[index]).toList();
      int avg = calcAvg(values);
      return OmitValue(values[0].key, avg);
    });
    oeMax = List.generate(2, (index) {
      List<OmitValue> values = omits.map((e) => e.cbOe.values[index]).toList();
      int max = calcMax(values);
      return OmitValue(values[0].key, max);
    });
    oeFreq = List.generate(2, (index) {
      List<OmitValue> values = omits.map((e) => e.cbOe.values[index]).toList();
      int frequent = calcFrequent(values);
      return OmitValue(values[0].key, frequent);
    });
    oeSeries = List.generate(2, (index) {
      List<OmitValue> values = omits.map((e) => e.cbOe.values[index]).toList();
      int series = calcMaxSeries(values);
      return OmitValue(values[0].key, series);
    });
  }
}

///
/// 排列五遗漏统计
class Pl5OmitCensus {
  ///
  late List<OmitValue> ballMax;

  ///
  late List<OmitValue> ballAvg;

  ///
  late List<OmitValue> ballFreq;

  ///
  late List<OmitValue> ballSeries;

  ///
  late List<OmitValue> cb1Max;

  ///
  late List<OmitValue> cb1Avg;

  ///
  late List<OmitValue> cb1Freq;

  ///
  late List<OmitValue> cb1Series;

  ///
  late List<OmitValue> cb2Max;

  ///
  late List<OmitValue> cb2Avg;

  ///
  late List<OmitValue> cb2Freq;

  ///
  late List<OmitValue> cb2Series;

  ///
  late List<OmitValue> cb3Max;

  ///
  late List<OmitValue> cb3Avg;

  ///
  late List<OmitValue> cb3Freq;

  ///
  late List<OmitValue> cb3Series;

  ///
  late List<OmitValue> cb4Max;

  ///
  late List<OmitValue> cb4Avg;

  ///
  late List<OmitValue> cb4Freq;

  ///
  late List<OmitValue> cb4Series;

  ///
  late List<OmitValue> cb5Max;

  ///
  late List<OmitValue> cb5Avg;

  ///
  late List<OmitValue> cb5Freq;

  ///
  late List<OmitValue> cb5Series;

  Pl5OmitCensus(List<LotteryOmit> omits) {
    _calcOmitCensus(omits);
  }

  void _calcOmitCensus(List<LotteryOmit> omits) {
    ///
    ballMax = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.red!.values[index]).toList();
      int max = calcMax(values);
      return OmitValue(values[0].key, max);
    });
    ballAvg = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.red!.values[index]).toList();
      int max = calcAvg(values);
      return OmitValue(values[0].key, max);
    });
    ballFreq = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.red!.values[index]).toList();
      int max = calcFrequent(values);
      return OmitValue(values[0].key, max);
    });
    ballSeries = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.red!.values[index]).toList();
      int max = calcMaxSeries(values);
      return OmitValue(values[0].key, max);
    });

    ///
    cb1Max = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cb1!.values[index]).toList();
      int max = calcMax(values);
      return OmitValue(values[0].key, max);
    });
    cb1Avg = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cb1!.values[index]).toList();
      int max = calcAvg(values);
      return OmitValue(values[0].key, max);
    });
    cb1Freq = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cb1!.values[index]).toList();
      int max = calcFrequent(values);
      return OmitValue(values[0].key, max);
    });
    cb1Series = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cb1!.values[index]).toList();
      int max = calcMaxSeries(values);
      return OmitValue(values[0].key, max);
    });

    ///
    cb2Max = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cb2!.values[index]).toList();
      int max = calcMax(values);
      return OmitValue(values[0].key, max);
    });
    cb2Avg = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cb2!.values[index]).toList();
      int max = calcAvg(values);
      return OmitValue(values[0].key, max);
    });
    cb2Freq = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cb2!.values[index]).toList();
      int max = calcFrequent(values);
      return OmitValue(values[0].key, max);
    });
    cb2Series = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cb2!.values[index]).toList();
      int max = calcMaxSeries(values);
      return OmitValue(values[0].key, max);
    });

    ///
    cb3Max = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cb3!.values[index]).toList();
      int max = calcMax(values);
      return OmitValue(values[0].key, max);
    });
    cb3Avg = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cb3!.values[index]).toList();
      int max = calcAvg(values);
      return OmitValue(values[0].key, max);
    });
    cb3Freq = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cb3!.values[index]).toList();
      int max = calcFrequent(values);
      return OmitValue(values[0].key, max);
    });
    cb3Series = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cb3!.values[index]).toList();
      int max = calcMaxSeries(values);
      return OmitValue(values[0].key, max);
    });

    ///
    cb4Max = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cb4!.values[index]).toList();
      int max = calcMax(values);
      return OmitValue(values[0].key, max);
    });
    cb4Avg = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cb4!.values[index]).toList();
      int max = calcAvg(values);
      return OmitValue(values[0].key, max);
    });
    cb4Freq = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cb4!.values[index]).toList();
      int max = calcFrequent(values);
      return OmitValue(values[0].key, max);
    });
    cb4Series = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cb4!.values[index]).toList();
      int max = calcMaxSeries(values);
      return OmitValue(values[0].key, max);
    });

    ///
    cb5Max = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cb5!.values[index]).toList();
      int max = calcMax(values);
      return OmitValue(values[0].key, max);
    });
    cb5Avg = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cb5!.values[index]).toList();
      int max = calcAvg(values);
      return OmitValue(values[0].key, max);
    });
    cb5Freq = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cb5!.values[index]).toList();
      int max = calcFrequent(values);
      return OmitValue(values[0].key, max);
    });
    cb5Series = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.cb5!.values[index]).toList();
      int max = calcMaxSeries(values);
      return OmitValue(values[0].key, max);
    });
  }
}
