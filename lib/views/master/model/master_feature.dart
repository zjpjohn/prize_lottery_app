import 'package:flutter/material.dart';

///
///
/// 计算平均命中率差距量
double calcDelta(double rate, double average) {
  return (rate - average) / average;
}

String _calcLevel(double rate, List<RatePair> pairs) {
  for (var value in pairs) {
    if (calcLevel(rate, value) != null) {
      return value.message;
    }
  }
  return '普通';
}

///
/// 计算专家级别
String? calcLevel(double rate, RatePair throttle) {
  if (rate >= throttle.rate) {
    return throttle.message;
  }
  return null;
}

class RatePair {
  double rate;
  String message;

  RatePair({
    required this.rate,
    required this.message,
  });
}

class HitPair {
  late String hit;
  late Color color;

  HitPair({required this.hit, required this.color});
}

List<RatePair> fc3dD3Rates = [
  RatePair(rate: 0.85, message: '优秀'),
  RatePair(rate: 0.8, message: '良好'),
  RatePair(rate: 0.75, message: '一般'),
];
List<RatePair> fc3dC5Rates = [
  RatePair(rate: 0.75, message: '优秀'),
  RatePair(rate: 0.70, message: '良好'),
  RatePair(rate: 0.65, message: '一般'),
];
List<RatePair> fc3dC6Rates = [
  RatePair(rate: 0.80, message: '优秀'),
  RatePair(rate: 0.75, message: '良好'),
  RatePair(rate: 0.67, message: '一般'),
];
List<RatePair> fc3dC7Rates = [
  RatePair(rate: 0.85, message: '优秀'),
  RatePair(rate: 0.78, message: '良好'),
  RatePair(rate: 0.70, message: '一般'),
];
List<RatePair> fc3dK1Rates = [
  RatePair(rate: 0.90, message: '优秀'),
  RatePair(rate: 0.82, message: '良好'),
  RatePair(rate: 0.76, message: '一般'),
];
List<RatePair> fc3dK2Rates = [
  RatePair(rate: 0.75, message: '优秀'),
  RatePair(rate: 0.70, message: '良好'),
  RatePair(rate: 0.66, message: '一般'),
];

///
///
class Fc3dMasterRate {
  ///
  late String period;
  late String masterId;

  ///
  late double dan3;
  late double d3Avg;

  ///
  late double com5;
  late double c5Avg;

  ///
  late double com6;
  late double c6Avg;

  ///
  late double com7;
  late double c7Avg;

  ///
  late double kill1;
  late double k1Avg;

  ///
  late double kill2;
  late double k2Avg;

  double d3Delta() {
    return calcDelta(dan3, d3Avg);
  }

  double c5Delta() {
    return calcDelta(com5, c5Avg);
  }

  double c6Delta() {
    return calcDelta(com6, c6Avg);
  }

  double c7Delta() {
    return calcDelta(com7, c7Avg);
  }

  double k1Delta() {
    return calcDelta(kill1, k1Avg);
  }

  double k2Delta() {
    return calcDelta(kill2, k2Avg);
  }

  String d3Level() {
    return _calcLevel(dan3, fc3dD3Rates);
  }

  String c5Level() {
    return _calcLevel(com5, fc3dC5Rates);
  }

  String c6Level() {
    return _calcLevel(com6, fc3dC6Rates);
  }

  String c7Level() {
    return _calcLevel(com7, fc3dC7Rates);
  }

  String k1Level() {
    return _calcLevel(kill1, fc3dK1Rates);
  }

  String k2Level() {
    return _calcLevel(kill2, fc3dK2Rates);
  }

  Fc3dMasterRate.fromJson(Map<String, dynamic> json) {
    period = json['period'];
    masterId = json['masterId'];
    dan3 = json['dan3'];
    d3Avg = json['d3Avg'];
    com5 = json['com5'];
    c5Avg = json['c5Avg'];
    com6 = json['com6'];
    c6Avg = json['c6Avg'];
    com7 = json['com7'];
    c7Avg = json['c7Avg'];
    kill1 = json['kill1'];
    k1Avg = json['k1Avg'];
    kill2 = json['kill2'];
    k2Avg = json['k2Avg'];
  }
}

///
class Fc3dICaiHit {
  late String period;
  late String masterId;
  late int dan3;
  late int com5;
  late int com6;
  late int com7;
  late int kill1;
  late int kill2;

  String hitPeriod() {
    return period.substring(4);
  }

  HitPair d3Hit() {
    if (dan3 == 0) {
      return HitPair(hit: '未命中', color: Colors.black38);
    }
    return HitPair(hit: '命中', color: const Color(0xFFFF0033));
  }

  HitPair c5Hit() {
    if (com5 == 0) {
      return HitPair(hit: '未命中', color: Colors.black38);
    }
    if (com5 == 3) {
      return HitPair(hit: '命中', color: const Color(0xFFFF0033));
    }
    return HitPair(hit: '中$com5', color: Colors.deepOrangeAccent);
  }

  HitPair c6Hit() {
    if (com6 == 0) {
      return HitPair(hit: '未命中', color: Colors.black38);
    }
    if (com6 == 3) {
      return HitPair(hit: '命中', color: const Color(0xFFFF0033));
    }
    return HitPair(hit: '中$com6', color: Colors.deepOrangeAccent);
  }

  HitPair c7Hit() {
    if (com7 == 0) {
      return HitPair(hit: '未命中', color: Colors.black38);
    }
    if (com7 == 3) {
      return HitPair(hit: '命中', color: const Color(0xFFFF0033));
    }
    return HitPair(hit: '中$com7', color: Colors.deepOrangeAccent);
  }

  HitPair k1Hit() {
    if (kill1 == 0) {
      return HitPair(hit: '未命中', color: Colors.black38);
    }
    return HitPair(hit: '命中', color: const Color(0xFFFF0033));
  }

  HitPair k2Hit() {
    if (kill2 == 0) {
      return HitPair(hit: '未命中', color: Colors.black38);
    }
    return HitPair(hit: '命中', color: const Color(0xFFFF0033));
  }

  Fc3dICaiHit.fromJson(Map<String, dynamic> json) {
    period = json['period'];
    masterId = json['masterId'];
    dan3 = json['dan3'];
    com5 = json['com5'];
    com6 = json['com6'];
    com7 = json['com7'];
    kill1 = json['kill1'];
    kill2 = json['kill2'];
  }
}

List<RatePair> pl3D3Rates = [
  RatePair(rate: 0.85, message: '优秀'),
  RatePair(rate: 0.8, message: '良好'),
  RatePair(rate: 0.75, message: '一般'),
];
List<RatePair> pl3C5Rates = [
  RatePair(rate: 0.80, message: '优秀'),
  RatePair(rate: 0.75, message: '良好'),
  RatePair(rate: 0.65, message: '一般'),
];
List<RatePair> pl3C6Rates = [
  RatePair(rate: 0.80, message: '优秀'),
  RatePair(rate: 0.75, message: '良好'),
  RatePair(rate: 0.68, message: '一般'),
];
List<RatePair> pl3C7Rates = [
  RatePair(rate: 0.85, message: '优秀'),
  RatePair(rate: 0.78, message: '良好'),
  RatePair(rate: 0.70, message: '一般'),
];
List<RatePair> pl3K1Rates = [
  RatePair(rate: 0.90, message: '优秀'),
  RatePair(rate: 0.82, message: '良好'),
  RatePair(rate: 0.76, message: '一般'),
];
List<RatePair> pl3K2Rates = [
  RatePair(rate: 0.75, message: '优秀'),
  RatePair(rate: 0.70, message: '良好'),
  RatePair(rate: 0.66, message: '一般'),
];

///
class Pl3MasterRate {
  ///
  late String period;
  late String masterId;

  ///
  late double dan3;
  late double d3Avg;

  ///
  late double com5;
  late double c5Avg;

  ///
  late double com6;
  late double c6Avg;

  ///
  late double com7;
  late double c7Avg;

  ///
  late double kill1;
  late double k1Avg;

  ///
  late double kill2;
  late double k2Avg;

  double d3Delta() {
    return calcDelta(dan3, d3Avg);
  }

  double c5Delta() {
    return calcDelta(com5, c5Avg);
  }

  double c6Delta() {
    return calcDelta(com6, c6Avg);
  }

  double c7Delta() {
    return calcDelta(com7, c7Avg);
  }

  double k1Delta() {
    return calcDelta(kill1, k1Avg);
  }

  double k2Delta() {
    return calcDelta(kill2, k2Avg);
  }

  String d3Level() {
    return _calcLevel(dan3, fc3dD3Rates);
  }

  String c5Level() {
    return _calcLevel(com5, fc3dC5Rates);
  }

  String c6Level() {
    return _calcLevel(com6, fc3dC6Rates);
  }

  String c7Level() {
    return _calcLevel(com7, fc3dC7Rates);
  }

  String k1Level() {
    return _calcLevel(kill1, fc3dK1Rates);
  }

  String k2Level() {
    return _calcLevel(kill2, fc3dK2Rates);
  }

  Pl3MasterRate.fromJson(Map<String, dynamic> json) {
    period = json['period'];
    masterId = json['masterId'];
    dan3 = json['dan3'];
    d3Avg = json['d3Avg'];
    com5 = json['com5'];
    c5Avg = json['c5Avg'];
    com6 = json['com6'];
    c6Avg = json['c6Avg'];
    com7 = json['com7'];
    c7Avg = json['c7Avg'];
    kill1 = json['kill1'];
    k1Avg = json['k1Avg'];
    kill2 = json['kill2'];
    k2Avg = json['k2Avg'];
  }
}

///
class Pl3ICaiHit {
  ///
  ///
  late String period;
  late String masterId;

  ///
  late int dan3;
  late int com5;
  late int com6;
  late int com7;
  late int kill1;
  late int kill2;

  String hitPeriod() {
    return period.substring(4);
  }

  HitPair d3Hit() {
    if (dan3 == 0) {
      return HitPair(hit: '未命中', color: Colors.black38);
    }
    return HitPair(hit: '命中', color: const Color(0xFFFF0033));
  }

  HitPair c5Hit() {
    if (com5 == 0) {
      return HitPair(hit: '未命中', color: Colors.black38);
    }
    if (com5 == 3) {
      return HitPair(hit: '命中', color: const Color(0xFFFF0033));
    }
    return HitPair(hit: '中$com5', color: Colors.deepOrangeAccent);
  }

  HitPair c6Hit() {
    if (com6 == 0) {
      return HitPair(hit: '未命中', color: Colors.black38);
    }
    if (com6 == 3) {
      return HitPair(hit: '命中', color: const Color(0xFFFF0033));
    }
    return HitPair(hit: '中$com6', color: Colors.deepOrangeAccent);
  }

  HitPair c7Hit() {
    if (com7 == 0) {
      return HitPair(hit: '未命中', color: Colors.black38);
    }
    if (com7 == 3) {
      return HitPair(hit: '命中', color: const Color(0xFFFF0033));
    }
    return HitPair(hit: '中$com7', color: Colors.deepOrangeAccent);
  }

  HitPair k1Hit() {
    if (kill1 == 0) {
      return HitPair(hit: '未命中', color: Colors.black38);
    }
    return HitPair(hit: '命中', color: const Color(0xFFFF0033));
  }

  HitPair k2Hit() {
    if (kill2 == 0) {
      return HitPair(hit: '未命中', color: Colors.black38);
    }
    return HitPair(hit: '命中', color: const Color(0xFFFF0033));
  }

  Pl3ICaiHit.fromJson(Map<String, dynamic> json) {
    period = json['period'];
    masterId = json['masterId'];
    dan3 = json['dan3'];
    com5 = json['com5'];
    com6 = json['com6'];
    com7 = json['com7'];
    kill1 = json['kill1'];
    kill2 = json['kill2'];
  }
}

List<RatePair> ssqR3Rates = [
  RatePair(rate: 0.85, message: '优秀'),
  RatePair(rate: 0.80, message: '良好'),
  RatePair(rate: 0.75, message: '一般'),
];
List<RatePair> ssqR20Rates = [
  RatePair(rate: 0.90, message: '优秀'),
  RatePair(rate: 0.85, message: '良好'),
  RatePair(rate: 0.76, message: '一般'),
];
List<RatePair> ssqR25Rates = [
  RatePair(rate: 0.87, message: '优秀'),
  RatePair(rate: 0.80, message: '良好'),
  RatePair(rate: 0.75, message: '一般'),
];
List<RatePair> ssqRk3Rates = [
  RatePair(rate: 0.87, message: '优秀'),
  RatePair(rate: 0.80, message: '良好'),
  RatePair(rate: 0.75, message: '一般'),
];
List<RatePair> ssqB5Rates = [
  RatePair(rate: 0.80, message: '优秀'),
  RatePair(rate: 0.70, message: '良好'),
  RatePair(rate: 0.66, message: '一般'),
];
List<RatePair> ssqBkRates = [
  RatePair(rate: 0.90, message: '优秀'),
  RatePair(rate: 0.85, message: '良好'),
  RatePair(rate: 0.77, message: '一般'),
];

class SsqMasterRate {
  late String period;
  late String masterId;
  late double red3;
  late double red3Avg;
  late double red20;
  late double red20Avg;
  late double red25;
  late double red25Avg;
  late double rk3;
  late double rk3Avg;
  late double blue5;
  late double blue5Avg;
  late double bk;
  late double bkAvg;

  double red3Delta() {
    return calcDelta(red3, red3Avg);
  }

  String red3Level() {
    return _calcLevel(red3, ssqR3Rates);
  }

  double red20Delta() {
    return calcDelta(red20, red20Avg);
  }

  String red20Level() {
    return _calcLevel(red20, ssqR20Rates);
  }

  double red25Delta() {
    return calcDelta(red25, red25Avg);
  }

  String red25Level() {
    return _calcLevel(red25, ssqR25Rates);
  }

  double rk3Delta() {
    return calcDelta(rk3, rk3Avg);
  }

  String rk3Level() {
    return _calcLevel(rk3, ssqRk3Rates);
  }

  double blue5Delta() {
    return calcDelta(blue5, blue5Avg);
  }

  String blue5Level() {
    return _calcLevel(blue5, ssqB5Rates);
  }

  double bkDelta() {
    return calcDelta(bk, bkAvg);
  }

  String bkLevel() {
    return _calcLevel(bk, ssqBkRates);
  }

  SsqMasterRate.fromJson(Map<String, dynamic> json) {
    period = json['period'];
    masterId = json['masterId'];
    red3 = json['red3'];
    red3Avg = json['red3Avg'];
    red20 = json['red20'];
    red20Avg = json['red20Avg'];
    red25 = json['red25'];
    red25Avg = json['red25Avg'];
    rk3 = json['rk3'];
    rk3Avg = json['rk3Avg'];
    blue5 = json['blue5'];
    blue5Avg = json['blue5Avg'];
    bk = json['bk'];
    bkAvg = json['bkAvg'];
  }
}

class SsqICaiHit {
  late String period;
  late String masterId;
  late int red3;
  late int red20;
  late int red25;
  late int rk3;
  late int blue5;
  late int bk;

  String hitPeriod() {
    return period.substring(4);
  }

  HitPair r3Hit() {
    if (red3 == 0) {
      return HitPair(hit: '未命中', color: Colors.black38);
    }
    return HitPair(hit: '命中', color: const Color(0xFFFF0033));
  }

  HitPair r20Hit() {
    if (red20 < 4) {
      return HitPair(hit: '未命中', color: Colors.black38);
    }
    if (red20 >= 5) {
      return HitPair(hit: '命中', color: const Color(0xFFFF0033));
    }
    return HitPair(hit: '中$red20', color: Colors.deepOrangeAccent);
  }

  HitPair r25Hit() {
    if (red25 < 4) {
      return HitPair(hit: '未命中', color: Colors.black38);
    }
    if (red25 > 5) {
      return HitPair(hit: '命中', color: const Color(0xFFFF0033));
    }
    return HitPair(hit: '中$red25', color: Colors.deepOrangeAccent);
  }

  HitPair rk3Hit() {
    if (rk3 == 0) {
      return HitPair(hit: '未命中', color: Colors.black38);
    }
    return HitPair(hit: '命中', color: const Color(0xFFFF0033));
  }

  HitPair b5Hit() {
    if (blue5 == 0) {
      return HitPair(hit: '未命中', color: Colors.black38);
    }
    return HitPair(hit: '命中', color: const Color(0xFFFF0033));
  }

  HitPair bkHit() {
    if (bk == 0) {
      return HitPair(hit: '未命中', color: Colors.black38);
    }
    return HitPair(hit: '命中', color: const Color(0xFFFF0033));
  }

  SsqICaiHit.fromJson(Map<String, dynamic> json) {
    period = json['period'];
    masterId = json['masterId'];
    red3 = json['red3'];
    red20 = json['red20'];
    red25 = json['red25'];
    rk3 = json['rk3'];
    blue5 = json['blue5'];
    bk = json['bk'];
  }
}

List<RatePair> dltR3Rates = [
  RatePair(rate: 0.80, message: '优秀'),
  RatePair(rate: 0.73, message: '良好'),
  RatePair(rate: 0.66, message: '一般'),
];
List<RatePair> dltR10Rates = [
  RatePair(rate: 0.87, message: '优秀'),
  RatePair(rate: 0.80, message: '良好'),
  RatePair(rate: 0.73, message: '一般'),
];
List<RatePair> dltR20Rates = [
  RatePair(rate: 0.73, message: '优秀'),
  RatePair(rate: 0.66, message: '良好'),
  RatePair(rate: 0.60, message: '一般'),
];
List<RatePair> dltRk3Rates = [
  RatePair(rate: 0.93, message: '优秀'),
  RatePair(rate: 0.80, message: '良好'),
  RatePair(rate: 0.73, message: '一般'),
];
List<RatePair> dltB6Rates = [
  RatePair(rate: 0.93, message: '优秀'),
  RatePair(rate: 0.80, message: '良好'),
  RatePair(rate: 0.73, message: '一般'),
];
List<RatePair> dltBkRates = [
  RatePair(rate: 0.93, message: '优秀'),
  RatePair(rate: 0.80, message: '良好'),
  RatePair(rate: 0.73, message: '一般'),
];

class DltMasterRate {
  late String period;
  late String masterId;
  late double red3;
  late double red3Avg;
  late double red10;
  late double red10Avg;
  late double red20;
  late double red20Avg;
  late double rk3;
  late double rk3Avg;
  late double blue6;
  late double blue6Avg;
  late double bk;
  late double bkAvg;

  double r3Delta() {
    return calcDelta(red3, red3Avg);
  }

  String r3Level() {
    return _calcLevel(red3, dltR3Rates);
  }

  double r10Delta() {
    return calcDelta(red10, red10Avg);
  }

  String r10Level() {
    return _calcLevel(red10, dltR10Rates);
  }

  double r20Delta() {
    return calcDelta(red20, red20Avg);
  }

  String r20Level() {
    return _calcLevel(red20, dltR20Rates);
  }

  double rk3Delta() {
    return calcDelta(rk3, rk3Avg);
  }

  String rk3Level() {
    return _calcLevel(rk3, dltRk3Rates);
  }

  double b6Delta() {
    return calcDelta(blue6, blue6Avg);
  }

  String b6Level() {
    return _calcLevel(blue6, dltB6Rates);
  }

  double bkDelta() {
    return calcDelta(bk, bkAvg);
  }

  String bkLevel() {
    return _calcLevel(bk, dltBkRates);
  }

  DltMasterRate.fromJson(Map<String, dynamic> json) {
    period = json['period'];
    masterId = json['masterId'];
    red3 = json['red3'];
    red3Avg = json['red3Avg'];
    red10 = json['red10'];
    red10Avg = json['red10Avg'];
    red20 = json['red20'];
    red20Avg = json['red20Avg'];
    rk3 = json['rk3'];
    rk3Avg = json['rk3Avg'];
    blue6 = json['blue6'];
    blue6Avg = json['blue6Avg'];
    bk = json['bk'];
    bkAvg = json['bkAvg'];
  }
}

class DltICaiHit {
  late String period;
  late String masterId;
  late int red3;
  late int red10;
  late int red20;
  late int rk3;
  late int blue6;
  late int bk;

  String hitPeriod() {
    return period.substring(4);
  }

  HitPair r3Hit() {
    if (red3 == 0) {
      return HitPair(hit: '未命中', color: Colors.black38);
    }
    return HitPair(hit: '命中', color: const Color(0xFFFF0033));
  }

  HitPair r10Hit() {
    if (red10 < 2) {
      return HitPair(hit: '未命中', color: Colors.black38);
    }
    if (red10 >= 5) {
      return HitPair(hit: '命中', color: const Color(0xFFFF0033));
    }
    return HitPair(hit: '中$red10', color: Colors.deepOrangeAccent);
  }

  HitPair r20Hit() {
    if (red20 < 4) {
      return HitPair(hit: '未命中', color: Colors.black38);
    }
    if (red20 >= 5) {
      return HitPair(hit: '命中', color: const Color(0xFFFF0033));
    }
    return HitPair(hit: '中$red20', color: Colors.deepOrangeAccent);
  }

  HitPair rk3Hit() {
    if (rk3 == 0) {
      return HitPair(hit: '未命中', color: Colors.black38);
    }
    return HitPair(hit: '命中', color: const Color(0xFFFF0033));
  }

  HitPair b6Hit() {
    if (blue6 < 1) {
      return HitPair(hit: '未命中', color: Colors.black38);
    }
    if (blue6 >= 2) {
      return HitPair(hit: '命中', color: const Color(0xFFFF0033));
    }
    return HitPair(hit: '中$blue6', color: Colors.deepOrangeAccent);
  }

  HitPair bkHit() {
    if (bk == 0) {
      return HitPair(hit: '未命中', color: Colors.black38);
    }
    return HitPair(hit: '命中', color: const Color(0xFFFF0033));
  }

  DltICaiHit.fromJson(Map<String, dynamic> json) {
    period = json['period'];
    masterId = json['masterId'];
    red3 = json['red3'];
    red10 = json['red10'];
    red20 = json['red20'];
    rk3 = json['rk3'];
    blue6 = json['blue6'];
    bk = json['bk'];
  }
}

List<RatePair> qlcR2Rates = [
  RatePair(rate: 0.87, message: '优秀'),
  RatePair(rate: 0.73, message: '良好'),
  RatePair(rate: 0.60, message: '一般'),
];

List<RatePair> qlcR3Rates = [
  RatePair(rate: 0.93, message: '优秀'),
  RatePair(rate: 0.80, message: '良好'),
  RatePair(rate: 0.66, message: '一般'),
];

List<RatePair> qlcR12Rates = [
  RatePair(rate: 0.87, message: '优秀'),
  RatePair(rate: 0.80, message: '良好'),
  RatePair(rate: 0.73, message: '一般'),
];

List<RatePair> qlcR18Rates = [
  RatePair(rate: 0.93, message: '优秀'),
  RatePair(rate: 0.80, message: '良好'),
  RatePair(rate: 0.73, message: '一般'),
];
List<RatePair> qlcR22Rates = [
  RatePair(rate: 0.93, message: '优秀'),
  RatePair(rate: 0.80, message: '良好'),
  RatePair(rate: 0.73, message: '一般'),
];

List<RatePair> qlcK3Rates = [
  RatePair(rate: 0.80, message: '优秀'),
  RatePair(rate: 0.73, message: '良好'),
  RatePair(rate: 0.66, message: '一般'),
];

class QlcMasterRate {
  late String period;
  late String masterId;
  late double red2;
  late double red2Avg;
  late double red3;
  late double red3Avg;
  late double red12;
  late double red12Avg;
  late double red18;
  late double red18Avg;
  late double red22;
  late double red22Avg;
  late double kill3;
  late double kill3Avg;

  double r2Delta() {
    return calcDelta(red2, red2Avg);
  }

  String r2Level() {
    return _calcLevel(red2, qlcR2Rates);
  }

  double r3Delta() {
    return calcDelta(red3, red3Avg);
  }

  String r3Level() {
    return _calcLevel(red3, qlcR3Rates);
  }

  double r12Delta() {
    return calcDelta(red12, red12Avg);
  }

  String r12Level() {
    return _calcLevel(red12, qlcR12Rates);
  }

  double r18Delta() {
    return calcDelta(red18, red18Avg);
  }

  String r18Level() {
    return _calcLevel(red18, qlcR18Rates);
  }

  double r22Delta() {
    return calcDelta(red22, red22Avg);
  }

  String r22Level() {
    return _calcLevel(red22, qlcR22Rates);
  }

  double k3Delta() {
    return calcDelta(kill3, kill3Avg);
  }

  String k3Level() {
    return _calcLevel(kill3, qlcK3Rates);
  }

  QlcMasterRate.fromJson(Map<String, dynamic> json) {
    period = json['period'];
    masterId = json['masterId'];
    red2 = json['red2'];
    red2Avg = json['red2Avg'];
    red3 = json['red3'];
    red3Avg = json['red3Avg'];
    red12 = json['red12'];
    red12Avg = json['red12Avg'];
    red18 = json['red18'];
    red18Avg = json['red18Avg'];
    red22 = json['red22'];
    red22Avg = json['red22Avg'];
    kill3 = json['kill3'];
    kill3Avg = json['kill3Avg'];
  }
}

class QlcICaiHit {
  late String period;
  late String masterId;
  late int red2;
  late int red3;
  late int red12;
  late int red18;
  late int red22;
  late int kill3;

  String hitPeriod() {
    return period.substring(4);
  }

  HitPair r2Hit() {
    if (red2 == 0) {
      return HitPair(hit: '未命中', color: Colors.black38);
    }
    return HitPair(hit: '命中', color: const Color(0xFFFF0033));
  }

  HitPair r3Hit() {
    if (red3 == 0) {
      return HitPair(hit: '未命中', color: Colors.black38);
    }
    return HitPair(hit: '命中', color: const Color(0xFFFF0033));
  }

  HitPair r12Hit() {
    if (red12 < 3) {
      return HitPair(hit: '未命中', color: Colors.black38);
    }
    if (red12 >= 5) {
      return HitPair(hit: '命中', color: const Color(0xFFFF0033));
    }
    return HitPair(hit: '中$red12', color: Colors.deepOrangeAccent);
  }

  HitPair r18Hit() {
    if (red18 < 4) {
      return HitPair(hit: '未命中', color: Colors.black38);
    }
    if (red18 >= 6) {
      return HitPair(hit: '命中', color: const Color(0xFFFF0033));
    }
    return HitPair(hit: '中$red18', color: Colors.deepOrangeAccent);
  }

  HitPair r22Hit() {
    if (red22 < 5) {
      return HitPair(hit: '未命中', color: Colors.black38);
    }
    if (red22 >= 6) {
      return HitPair(hit: '命中', color: const Color(0xFFFF0033));
    }
    return HitPair(hit: '中$red22', color: Colors.deepOrangeAccent);
  }

  HitPair k3Hit() {
    if (kill3 == 0) {
      return HitPair(hit: '未命中', color: Colors.black38);
    }
    return HitPair(hit: '命中', color: Colors.deepOrangeAccent);
  }

  QlcICaiHit.fromJson(Map<String, dynamic> json) {
    period = json['period'];
    masterId = json['masterId'];
    red2 = json['red2'];
    red3 = json['red3'];
    red12 = json['red12'];
    red18 = json['red18'];
    red22 = json['red22'];
    kill3 = json['kill3'];
  }
}
