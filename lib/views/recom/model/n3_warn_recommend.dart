import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/base/model/enum_value.dart';
import 'package:prize_lottery_app/utils/constants.dart';
import 'package:prize_lottery_app/utils/lottery_utils.dart';
import 'package:prize_lottery_app/utils/tools.dart';

///
///
final Map<String, String> warnType = {
  'SUM_WARNING': '和值预警',
  'TAIL_WARNING': '和值尾数预警',
  'KUA_WARNING': '跨度值预警',
  'DAN_WARNING': '胆码预警',
  'KILL_WARNING': '杀码预警',
};

///
///
class Num3ComWarn {
  ///彩种类型
  late EnumValue type;

  ///总浏览次数
  late int browses;

  ///上一期开奖
  late Lottery last;

  ///本期期号
  late String period;

  ///上一期中奖情况
  EnumValue? lastHit;

  ///本期开奖
  Lottery? current;

  ///命中情况
  EnumValue? hit;

  ///杀码推荐
  WarnText? kill;

  ///跨度推荐
  WarnInt? kuaList;

  ///和值推荐
  WarnInt? sumList;

  ///胆码推荐
  WarnComplex? dan;

  ///两码推荐
  WarnComplex? twoMa;

  ///两码推荐
  WarnComplex? zu3;

  ///两码推荐
  WarnComplex? zu6;

  Num3ComWarn.fromJson(Map<String, dynamic> json) {
    type = EnumValue.fromJson(json['type']);
    browses = Tools.randLimit(json['browses'] ?? 0, 1000);
    period = json['period'];
    last = Lottery.fromJson(json['last'], true);
    if (json['hit'] != null) {
      hit = EnumValue.fromJson(json['hit']);
    }
    if (json['kill'] != null) {
      kill = WarnText.fromJson(json['kill']);
    }
    if (json['kuaList'] != null) {
      kuaList = WarnInt.fromJson(json['kuaList']);
    }
    if (json['sumList'] != null) {
      sumList = WarnInt.fromJson(json['sumList']);
    }
    if (json['dan'] != null) {
      dan = WarnComplex.fromJson(json['dan']);
    }
    if (json['twoMa'] != null) {
      twoMa = WarnComplex.fromJson(json['twoMa']);
    }
    if (json['zu3'] != null) {
      zu3 = WarnComplex.fromJson(json['zu3']);
    }
    if (json['zu6'] != null) {
      zu6 = WarnComplex.fromJson(json['zu6']);
    }
    if (json['lastHit'] != null) {
      lastHit = EnumValue.fromJson(json['lastHit']);
    }
    if (json['current'] != null) {
      current = Lottery.fromJson(json['current'], true);
    }
  }
}

///
class N3WarnRecommend {
  ///彩种类型
  late EnumValue type;

  ///总浏览次数
  late int browses;

  ///上一期开奖
  late Lottery last;

  ///本期期号
  late String period;

  ///上一期中奖情况
  EnumValue? lastHit;

  ///是否需要会员查看
  bool feeRequired = false;

  ///本期开奖
  Lottery? current;

  ///组三推荐
  ComRecommend? zu3;

  ///组六推荐
  ComRecommend? zu6;

  ///预警信息
  Map<String, List<String>>? warnings;

  ///是否命中
  int? hit;

  N3WarnRecommend.fromJson(Map<String, dynamic> json) {
    period = json['period'];
    browses = Tools.randLimit(json['browses'] ?? 0, 1000);
    type = EnumValue.fromJson(json['type']);
    feeRequired = json['feeRequired'] ?? false;
    bool isN3 = ['fc3d', 'pl3'].contains(type.value);
    last = Lottery.fromJson(json['last'], isN3);
    if (json['lastHit'] != null) {
      lastHit = EnumValue.fromJson(json['lastHit']);
    }
    if (json['current'] != null) {
      current = Lottery.fromJson(json['current'], isN3);
    }
    if (json['hit'] != null) {
      hit = json['hit'];
    }
    if (json['warnings'] != null) {
      warnings = Map.from(json['warnings'])
          .map((key, value) => MapEntry(key, value.cast<String>()));
    }
    if (json['zu3'] != null) {
      zu3 = ComRecommend.fromJson(json['zu3']);
    }
    if (json['zu6'] != null) {
      zu6 = ComRecommend.fromJson(json['zu6']);
    }
  }

  List<String>? warning({required String key, int? limit}) {
    if (warnings == null) {
      return null;
    }
    List<String>? warning = warnings![key];
    if (warning == null || (limit != null && warning.length >= limit)) {
      return null;
    }
    return warning;
  }
}

///
///
///
class Lottery {
  ///
  late String period;
  List<String> red = [];
  List<String> blue = [];

  ///号码和值
  int? sum;

  ///号码和尾
  int? sumTail;

  ///号码跨度
  int? kua;

  ///号码形态(福彩3D和排列三)
  String? pattern;

  ///号码奇偶比
  String? oddEven;

  ///奖号质合比
  String? primeRatio;

  Lottery.fromJson(Map<String, dynamic> json, bool isN3) {
    period = json['period'];
    red = _splitBall(json['red']);
    blue = _splitBall(json['blue']);
    if (red.isNotEmpty) {
      List<int> balls = red.map((e) => int.parse(e)).toList();
      sum = LotteryUtils.sum(balls);
      sumTail = sum! % 10;
      kua = LotteryUtils.kua(balls);
      oddEven = LotteryUtils.oddEven(balls);
      primeRatio = LotteryUtils.primeComposite(balls);
      if (isN3) {
        pattern = n3Patterns[LotteryUtils.n3Pattern(balls)];
      }
    }
  }

  List<String> _splitBall(String? data) {
    if (data == null) {
      return [];
    }
    String trimmed = data.trim();
    if (trimmed.isEmpty) {
      return [];
    }
    return trimmed.trim().split(RegExp('\\s+'));
  }
}

///
///
///
class ComRecommend {
  late String channel;
  late List<RecValue> items;

  ComRecommend.fromJson(Map<String, dynamic> json) {
    channel = json['channel'];
    List data = json['items'];
    items = data.map((e) => RecValue.fromJson(e)..calcValue()).toList();
  }
}

class WarnText {
  late List<String> values;

  WarnText.fromJson(Map<String, dynamic> json) {
    values = (json['values'] as List).cast<String>();
  }
}

class WarnInt {
  late List<int> values;

  WarnInt.fromJson(Map<String, dynamic> json) {
    values = (json['values'] as List).cast<int>();
  }

  List<String> textList() {
    return values.map((e) => e.toString()).toList();
  }
}

class WarnComplex {
  late int hit;
  late List<RecValue> items;

  WarnComplex.fromJson(Map<String, dynamic> json) {
    hit = json['hit'];
    items = (json['items'] as List)
        .map((e) => RecValue.fromJson(e)..calcValue())
        .toList();
  }
}

///
///
///
class RecValue {
  late String value;
  List<String> values = [];
  String? hitValue;
  List<Model> hitValues = [];
  late int hit;
  int opened = 0;

  RecValue.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    hitValue = json['hitValue'];
    hit = json['hit'];
  }

  void calcValue() {
    if (hitValue != null && hitValue!.isNotEmpty) {
      opened = 1;
      hitValues = Tools.parse(hitValue!);
      return;
    }
    values = Tools.segSplit(value);
  }

  Widget valueView() {
    if (opened == 1) {
      List<Widget> items = [];
      for (var i = 0; i < hitValues.length; i++) {
        var model = hitValues[i];
        items.add(Text(
          model.k,
          style: TextStyle(
            fontSize: 17.sp,
            fontFamily: 'shuhei',
            color: model.v == 1
                ? const Color(0xFFFF0033)
                : const Color(0xCC000000),
          ),
        ));
      }
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items,
      );
    }
    List<Widget> items = [];
    for (var i = 0; i < values.length; i++) {
      items.add(Text(
        values[i],
        style: TextStyle(
          fontSize: 17.sp,
          fontFamily: 'shuhei',
          color: const Color(0xCC000000),
        ),
      ));
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items,
    );
  }
}
