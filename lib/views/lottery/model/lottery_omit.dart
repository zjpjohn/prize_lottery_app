import 'package:prize_lottery_app/base/model/enum_value.dart';
import 'package:prize_lottery_app/views/lottery/model/n3_omit_census.dart';

///
///
class LotteryOmit {
  ///
  late EnumValue type;

  ///
  late String period;

  ///
  Omit? red;

  ///
  Omit? blue;

  ///
  Omit? cb1;

  ///
  Omit? cb2;

  ///
  Omit? cb3;

  ///
  Omit? cb4;

  ///
  Omit? cb5;

  ///
  Omit? extra;

  ///
  late String gmtCreate;

  LotteryOmit.fromJson(Map<String, dynamic> json) {
    period = json['period'];
    type = EnumValue.fromJson(json['type']);
    if (json['red'] != null) {
      red = Omit.fromJson(json['red']);
    }
    if (json['blue'] != null) {
      blue = Omit.fromJson(json['blue']);
    }
    if (json['cb1'] != null) {
      cb1 = Omit.fromJson(json['cb1']);
    }
    if (json['cb2'] != null) {
      cb2 = Omit.fromJson(json['cb2']);
    }
    if (json['cb3'] != null) {
      cb3 = Omit.fromJson(json['cb3']);
    }
    if (json['cb4'] != null) {
      cb4 = Omit.fromJson(json['cb4']);
    }
    if (json['cb5'] != null) {
      cb5 = Omit.fromJson(json['cb5']);
    }
    if (json['extra'] != null) {
      extra = Omit.fromJson(json['extra']);
    }
    gmtCreate = json['gmtCreate'];
  }
}

class KuaOmit {
  late String period;
  late EnumValue type;
  late Omit baseOmit;
  late Omit ampOmit;
  late Omit ottOmit;
  late Omit bmsOmit;
  late Omit ampAmp;

  KuaOmit.fromJson(Map<String, dynamic> json) {
    period = json['period'];
    type = EnumValue.fromJson(json['type']);
    baseOmit = Omit.fromJson(json['baseOmit']);
    ampOmit = Omit.fromJson(json['ampOmit']);
    ottOmit = Omit.fromJson(json['ottOmit']);
    bmsOmit = Omit.fromJson(json['bmsOmit']);
    ampAmp = Omit.fromJson(json['ampAmp']);
  }
}

class SumOmit {
  late String period;
  late EnumValue type;
  late Omit baseOmit;
  late Omit tailOmit;
  late Omit ottOmit;
  late Omit bmsOmit;
  late Omit tailAmp;

  SumOmit.fromJson(Map<String, dynamic> json) {
    period = json['period'];
    type = EnumValue.fromJson(json['type']);
    baseOmit = Omit.fromJson(json['baseOmit']);
    tailOmit = Omit.fromJson(json['tailOmit']);
    ottOmit = Omit.fromJson(json['ottOmit']);
    bmsOmit = Omit.fromJson(json['bmsOmit']);
    tailAmp = Omit.fromJson(json['tailAmp']);
  }
}

class Omit {
  ///
  late List<OmitValue> values;

  Omit.fromJson(Map<String, dynamic> json) {
    List result = json['values'];
    values = result.map((e) => OmitValue.fromJson(e)).toList();
  }
}

class OmitValue {
  ///
  late String key;

  ///
  late int value;

  ///附加值
  String extra = '';

  OmitValue(this.key, this.value);

  OmitValue.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
    extra = json['extra'] ?? '';
  }
}

class PianOmit {
  late String period;
  late EnumValue type;
  late String lottery;
  Map<int, Omit> cb1 = {};
  Map<int, Omit> cb2 = {};
  Map<int, Omit> cb3 = {};

  PianOmit.fromJson(Map<String, dynamic> json) {
    period = json['period'];
    type = EnumValue.fromJson(json['type']);
    lottery = json['lottery'] ?? '';
    cb1 = (json['cb1'] as Map)
        .map((k, v) => MapEntry(int.parse(k), Omit.fromJson(v)));
    cb2 = (json['cb2'] as Map)
        .map((k, v) => MapEntry(int.parse(k), Omit.fromJson(v)));
    cb3 = (json['cb3'] as Map)
        .map((k, v) => MapEntry(int.parse(k), Omit.fromJson(v)));
  }
}

class PianCensus {
  late Map<int, PianCensusItem> cb1;
  late Map<int, PianCensusItem> cb2;
  late Map<int, PianCensusItem> cb3;

  PianCensus(List<PianOmit> omits) {
    cb1 = calcItemCensus(omits.map((e) => e.cb1).toList());
    cb2 = calcItemCensus(omits.map((e) => e.cb2).toList());
    cb3 = calcItemCensus(omits.map((e) => e.cb3).toList());
  }

  Map<int, PianCensusItem> calcItemCensus(List<Map<int, Omit>> values) {
    Map<int, List<Omit>> result = {};
    for (var e in values) {
      for (var key in e.keys) {
        result[key] = (result[key] ?? [])..add(e[key]!);
      }
    }
    return result.map((k, v) => MapEntry(k, PianCensusItem(v)));
  }
}

class PianCensusItem {
  late List<OmitValue> max;
  late List<OmitValue> avg;
  late List<OmitValue> freq;
  late List<OmitValue> series;

  PianCensusItem(List<Omit> omits) {
    max = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.values[index]).toList();
      int max = calcMax(values);
      return OmitValue(values[0].key, max);
    });
    avg = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.values[index]).toList();
      int avg = calcAvg(values);
      return OmitValue(values[0].key, avg);
    });
    freq = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.values[index]).toList();
      int freq = calcFrequent(values);
      return OmitValue(values[0].key, freq);
    });
    series = List.generate(10, (index) {
      List<OmitValue> values = omits.map((e) => e.values[index]).toList();
      int series = calcMaxSeries(values);
      return OmitValue(values[0].key, series);
    });
  }
}

class TrendOmit {
  ///
  late EnumValue type;

  ///
  late String period;

  ///
  late Omit formOmit;

  ///
  late Omit ottOmit;

  ///
  late Omit modeOmit;

  ///
  late Omit bsOmit;

  ///
  late Omit oeOmit;

  ///
  late String gmtCreate;

  TrendOmit.fromJson(Map<String, dynamic> json) {
    type = EnumValue.fromJson(json['type']);
    period = json['period'];
    formOmit = Omit.fromJson(json['formOmit']);
    ottOmit = Omit.fromJson(json['ottOmit']);
    modeOmit = Omit.fromJson(json['modeOmit']);
    bsOmit = Omit.fromJson(json['bsOmit']);
    oeOmit = Omit.fromJson(json['oeOmit']);
  }
}

class MatchOmit {
  ///
  late EnumValue type;

  ///
  late String period;

  ///
  late Omit comOmit;

  ///
  late Omit codeOmit;

  ///
  late OmitValue allOmit;

  MatchOmit.fromJson(Map<String, dynamic> json) {
    type = EnumValue.fromJson(json['type']);
    period = json['period'];
    comOmit = Omit.fromJson(json['comOmit']);
    codeOmit = Omit.fromJson(json['codeOmit']);
    allOmit = OmitValue.fromJson(json['allOmit']);
  }
}

class LotteryItemOmit {
  ///
  late EnumValue type;

  ///
  late String period;

  ///
  late String balls;

  ///
  late Omit cb1;

  ///
  late Omit cb1Amp;

  ///
  late Omit cb1Aod;

  ///
  late Omit cb1Bos;

  ///
  late Omit cb1Oe;

  ///
  late Omit cb2;

  ///
  late Omit cb2Amp;

  ///
  late Omit cb2Aod;

  ///
  late Omit cb2Bos;

  ///
  late Omit cb2Oe;

  ///
  late Omit cb3;

  ///
  late Omit cb3Amp;

  ///
  late Omit cb3Aod;

  ///
  late Omit cb3Bos;

  ///
  late Omit cb3Oe;

  ///
  late String gmtCreate;

  LotteryItemOmit.fromJson(Map<String, dynamic> json) {
    type = EnumValue.fromJson(json['type']);
    period = json['period'];
    balls = json['balls'];
    cb1 = Omit.fromJson(json['cb1']);
    cb1Amp = Omit.fromJson(json['cb1Amp']);
    cb1Aod = Omit.fromJson(json['cb1Aod']);
    cb1Bos = Omit.fromJson(json['cb1Bos']);
    cb1Oe = Omit.fromJson(json['cb1Oe']);
    cb2 = Omit.fromJson(json['cb2']);
    cb2Amp = Omit.fromJson(json['cb2Amp']);
    cb2Aod = Omit.fromJson(json['cb2Aod']);
    cb2Bos = Omit.fromJson(json['cb2Bos']);
    cb2Oe = Omit.fromJson(json['cb2Oe']);
    cb3 = Omit.fromJson(json['cb3']);
    cb3Amp = Omit.fromJson(json['cb3Amp']);
    cb3Aod = Omit.fromJson(json['cb3Aod']);
    cb3Bos = Omit.fromJson(json['cb3Bos']);
    cb3Oe = Omit.fromJson(json['cb3Oe']);
    gmtCreate = json['gmtCreate'];
  }
}

class LotteryPl5Omit {
  ///
  late String period;

  ///
  late String balls;

  ///
  late Omit cb1;

  ///
  late Omit cb1Amp;

  ///
  late Omit cb1Aod;

  ///
  late Omit cb1Bos;

  ///
  late Omit cb1Oe;

  ///
  late Omit cb2;

  ///
  late Omit cb2Amp;

  ///
  late Omit cb2Aod;

  ///
  late Omit cb2Bos;

  ///
  late Omit cb2Oe;

  ///
  late Omit cb3;

  ///
  late Omit cb3Amp;

  ///
  late Omit cb3Aod;

  ///
  late Omit cb3Bos;

  ///
  late Omit cb3Oe;

  ///
  late Omit cb4;

  ///
  late Omit cb4Amp;

  ///
  late Omit cb4Aod;

  ///
  late Omit cb4Bos;

  ///
  late Omit cb4Oe;

  ///
  late Omit cb5;

  ///
  late Omit cb5Amp;

  ///
  late Omit cb5Aod;

  ///
  late Omit cb5Bos;

  ///
  late Omit cb5Oe;

  ///
  late String gmtCreate;

  LotteryPl5Omit.fromJson(Map<String, dynamic> json) {
    period = json['period'];
    balls = json['balls'];
    cb1 = Omit.fromJson(json['cb1']);
    cb1Amp = Omit.fromJson(json['cb1Amp']);
    cb1Aod = Omit.fromJson(json['cb1Aod']);
    cb1Bos = Omit.fromJson(json['cb1Bos']);
    cb1Oe = Omit.fromJson(json['cb1Oe']);
    cb2 = Omit.fromJson(json['cb2']);
    cb2Amp = Omit.fromJson(json['cb2Amp']);
    cb2Aod = Omit.fromJson(json['cb2Aod']);
    cb2Bos = Omit.fromJson(json['cb2Bos']);
    cb2Oe = Omit.fromJson(json['cb2Oe']);
    cb3 = Omit.fromJson(json['cb3']);
    cb3Amp = Omit.fromJson(json['cb3Amp']);
    cb3Aod = Omit.fromJson(json['cb3Aod']);
    cb3Bos = Omit.fromJson(json['cb3Bos']);
    cb3Oe = Omit.fromJson(json['cb3Oe']);
    cb4 = Omit.fromJson(json['cb4']);
    cb4Amp = Omit.fromJson(json['cb4Amp']);
    cb4Aod = Omit.fromJson(json['cb4Aod']);
    cb4Bos = Omit.fromJson(json['cb4Bos']);
    cb4Oe = Omit.fromJson(json['cb4Oe']);
    cb5 = Omit.fromJson(json['cb5']);
    cb5Amp = Omit.fromJson(json['cb5Amp']);
    cb5Aod = Omit.fromJson(json['cb5Aod']);
    cb5Bos = Omit.fromJson(json['cb5Bos']);
    cb5Oe = Omit.fromJson(json['cb5Oe']);
    gmtCreate = json['gmtCreate'];
  }
}

class CbItemOmit {
  ///
  late EnumValue type;

  ///
  late String period;

  ///
  late String balls;

  ///
  late Omit cb;

  ///
  late Omit cbAmp;

  ///
  late Omit cbAod;

  ///
  late Omit cbBos;

  ///
  late Omit cbOe;

  CbItemOmit.fromJson(Map<String, dynamic> json) {
    type = EnumValue.fromJson(json['type']);
    period = json['period'];
    balls = json['balls'];
    cb = Omit.fromJson(json['cb']);
    cbAmp = Omit.fromJson(json['cbAmp']);
    cbAod = Omit.fromJson(json['cbAod']);
    cbBos = Omit.fromJson(json['cbBos']);
    cbOe = Omit.fromJson(json['cbOe']);
  }

  static CbItemOmit from(int type, LotteryItemOmit omit) {
    if (type == 1) {
      return CbItemOmit.fromCb1(omit);
    }
    if (type == 2) {
      return CbItemOmit.fromCb2(omit);
    }
    return CbItemOmit.fromCb3(omit);
  }

  CbItemOmit.fromCb1(LotteryItemOmit omit) {
    type = omit.type;
    period = omit.period;
    balls = omit.balls;
    cb = omit.cb1;
    cbAmp = omit.cb1Amp;
    cbAod = omit.cb1Aod;
    cbBos = omit.cb1Bos;
    cbOe = omit.cb1Oe;
  }

  CbItemOmit.fromCb2(LotteryItemOmit omit) {
    type = omit.type;
    period = omit.period;
    balls = omit.balls;
    cb = omit.cb2;
    cbAmp = omit.cb2Amp;
    cbAod = omit.cb2Aod;
    cbBos = omit.cb2Bos;
    cbOe = omit.cb2Oe;
  }

  CbItemOmit.fromCb3(LotteryItemOmit omit) {
    type = omit.type;
    period = omit.period;
    balls = omit.balls;
    cb = omit.cb3;
    cbAmp = omit.cb3Amp;
    cbAod = omit.cb3Aod;
    cbBos = omit.cb3Bos;
    cbOe = omit.cb3Oe;
  }

  List<String> lottery() {
    String trimmed = balls.trim();
    return trimmed.isEmpty ? [] : trimmed.trim().split(RegExp('\\s+'));
  }
}
