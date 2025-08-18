import 'dart:math';

import 'package:prize_lottery_app/base/model/enum_value.dart';

Map<int, List<int>> route147 = {
  1: [1, 5, 6, 9],
  4: [0, 2, 4],
  7: [3, 7, 8],
};
Map<int, List<int>> route258 = {
  2: [2, 7, 9],
  5: [0, 3, 5],
  8: [1, 4, 6, 8],
};

///
/// 万能码
///
class LotteryCode {
  ///
  /// 彩种类型
  late EnumValue lotto;

  /// 开奖期号
  late String period;

  ///万能码类型
  late EnumValue type;

  ///万能码位置
  late List<int> positions;

  ///开奖号码
  late String lottery;

  ///尾数
  List<int> tails = [];

  ///尾数012路
  List<int> zot = [];

  ///尾数147路
  List<int> ofs = [];

  ///尾数258路
  List<int> tfe = [];

  ///奇偶
  List<String> oe = [];

  ///大小
  List<String> bs = [];

  ///质合
  List<String> pc = [];

  LotteryCode.fromJson(Map<String, dynamic> json) {
    lotto = EnumValue.fromJson(json['lotto']);
    period = json['period'];
    type = EnumValue.fromJson(json['type']);
    positions = (json['positions'] as List).cast<int>();
    lottery = json['lottery'];

    ///计算尾数
    _calcTails();

    ///计算尾数奇偶
    _calcOddEven();

    ///计算尾数大小
    _calcBigSmall();

    ///计算尾数质合
    _calcPrimeComposite();
  }

  void _calcTails() {
    ///尾数
    tails = positions.map((e) => e % 10).toList();

    ///012路
    zot = List.of(tails.map((e) => e % 3).toSet());

    ///147路
    Set<int> filter147 = {};
    for (var value in tails) {
      for (var entry in route147.entries) {
        if (entry.value.contains(value)) {
          filter147.add(entry.key);
        }
      }
    }
    ofs = List.of(filter147);

    ///258路
    Set<int> filter258 = {};
    for (var value in tails) {
      for (var entry in route258.entries) {
        if (entry.value.contains(value)) {
          filter258.add(entry.key);
        }
      }
    }
    tfe = List.of(filter258);
  }

  void _calcOddEven() {
    Set<String> oddEvens = {};
    for (var value in tails) {
      oddEvens.add(value % 2 == 0 ? '偶' : '奇');
    }
    oe = List.of(oddEvens);
  }

  void _calcBigSmall() {
    Set<String> bigSmall = {};
    for (var value in tails) {
      bigSmall.add(value <= 4 ? '小' : '大');
    }
    bs = List.of(bigSmall);
  }

  void _calcPrimeComposite() {
    Set<String> bigSmall = {};
    for (var value in tails) {
      bigSmall.add(_isComposite(value) ? '合' : '质');
    }
    pc = List.of(bigSmall);
  }

  bool _isComposite(int x) {
    if (x <= 2) {
      return false;
    }
    for (int i = 2; i <= sqrt(x); i++) {
      if (x % i == 0) {
        return true;
      }
    }
    return false;
  }
}
