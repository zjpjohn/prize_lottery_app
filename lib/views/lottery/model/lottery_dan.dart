import 'dart:math';

import 'package:prize_lottery_app/base/model/enum_value.dart';

///
/// 胆码指数
class DanIndex {
  late int key;
  late int calc;
  late int hit;
  late int omit;

  DanIndex.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    calc = json['calc'];
    hit = json['hit'];
    omit = json['omit'];
  }
}

///
/// 福彩3D和排列三胆码
class LotteryDan {
  late EnumValue type;
  late String period;
  late String lottery;
  late DanIndex index1;
  late DanIndex index2;
  late DanIndex index3;
  late DanIndex index4;
  late DanIndex index5;
  late DanIndex index6;
  late DanIndex index7;
  late DanIndex index8;
  late DanIndex index9;
  List<String> balls = [];
  bool isThree = true;

  List<String> _balls() {
    return lottery.split(RegExp('\\s+'));
  }

  bool _isThree() {
    return balls.toSet().length >= 3;
  }

  int sum() {
    return lottery
        .split(RegExp('\\s+'))
        .map((e) => int.parse(e.trim()))
        .reduce((v, e) => v + e);
  }

  LotteryDan.fromJson(Map<String, dynamic> json) {
    period = json['period'];
    lottery = json['lottery'];
    type = EnumValue.fromJson(json['type']);
    index1 = DanIndex.fromJson(json['index1']);
    index2 = DanIndex.fromJson(json['index2']);
    index3 = DanIndex.fromJson(json['index3']);
    index4 = DanIndex.fromJson(json['index4']);
    index5 = DanIndex.fromJson(json['index5']);
    index6 = DanIndex.fromJson(json['index6']);
    index7 = DanIndex.fromJson(json['index7']);
    index8 = DanIndex.fromJson(json['index8']);
    index9 = DanIndex.fromJson(json['index9']);
    balls = _balls();
    isThree = _isThree();
  }
}

class DanOmitCensus {
  late int index1;
  late int index2;
  late int index3;
  late int index4;
  late int index5;
  late int index6;
  late int index7;
  late int index8;
  late int index9;

  DanOmitCensus.current(List<LotteryDan> list) {
    index1 = list.last.index1.omit;
    index2 = list.last.index2.omit;
    index3 = list.last.index3.omit;
    index4 = list.last.index4.omit;
    index5 = list.last.index5.omit;
    index6 = list.last.index6.omit;
    index7 = list.last.index7.omit;
    index8 = list.last.index8.omit;
    index9 = list.last.index9.omit;
  }

  DanOmitCensus.avgOmit(List<LotteryDan> list) {
    index1 = calcAvg(list.map((e) => e.index1).toList());
    index2 = calcAvg(list.map((e) => e.index2).toList());
    index3 = calcAvg(list.map((e) => e.index3).toList());
    index4 = calcAvg(list.map((e) => e.index4).toList());
    index5 = calcAvg(list.map((e) => e.index5).toList());
    index6 = calcAvg(list.map((e) => e.index6).toList());
    index7 = calcAvg(list.map((e) => e.index7).toList());
    index8 = calcAvg(list.map((e) => e.index8).toList());
    index9 = calcAvg(list.map((e) => e.index9).toList());
  }

  DanOmitCensus.maxOmit(List<LotteryDan> list) {
    index1 = calcMax(list.map((e) => e.index1).toList());
    index2 = calcMax(list.map((e) => e.index2).toList());
    index3 = calcMax(list.map((e) => e.index3).toList());
    index4 = calcMax(list.map((e) => e.index4).toList());
    index5 = calcMax(list.map((e) => e.index5).toList());
    index6 = calcMax(list.map((e) => e.index6).toList());
    index7 = calcMax(list.map((e) => e.index7).toList());
    index8 = calcMax(list.map((e) => e.index8).toList());
    index9 = calcMax(list.map((e) => e.index9).toList());
  }

  DanOmitCensus.total(List<LotteryDan> list) {
    index1 = calcTotal(list.map((e) => e.index1).toList());
    index2 = calcTotal(list.map((e) => e.index2).toList());
    index3 = calcTotal(list.map((e) => e.index3).toList());
    index4 = calcTotal(list.map((e) => e.index4).toList());
    index5 = calcTotal(list.map((e) => e.index5).toList());
    index6 = calcTotal(list.map((e) => e.index6).toList());
    index7 = calcTotal(list.map((e) => e.index7).toList());
    index8 = calcTotal(list.map((e) => e.index8).toList());
    index9 = calcTotal(list.map((e) => e.index9).toList());
  }

  /// 最大遗漏次数
  int calcMax(List<DanIndex> values) {
    return values.map((e) => e.omit).reduce(max);
  }

  /// 平均遗漏
  int calcAvg(List<DanIndex> values) {
    List<int> vList = values
        .where((e) => e.calc == 1)
        .map((e) => e.omit)
        .where((e) => e > 0)
        .toList();
    int value = vList.reduce((v, e) => v + e);
    return value ~/ vList.length;
  }

  ///计算出现总次数
  int calcTotal(List<DanIndex> values) {
    return values.where((e) => e.calc == 1 && e.hit == 1).length;
  }
}
