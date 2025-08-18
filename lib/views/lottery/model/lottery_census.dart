import 'dart:math';

import 'package:prize_lottery_app/views/lottery/model/lottery_info.dart';

class LotteryCensus {
  ///彩种
  late String type;

  ///号码
  late List<String> balls;

  ///期号
  late String period;

  ///历史同号期号
  late String last;

  ///历史遗漏
  late int lastDelta;

  ///和值
  late int sum;

  ///跨度
  late int kua;

  ///大小比
  late ItemRatio bs;

  ///012路
  late ItemRatio ott;

  ///奇偶比
  late ItemRatio oe;

  ///质合比
  late ItemRatio pc;

  LotteryCensus(LotteryInfo lottery, int max) {
    type = lottery.type;
    balls = lottery.redBalls();
    period = lottery.period;
    last = lottery.last;
    lastDelta = lottery.lastDelta;
    _calcLotteryCensus(max);
  }

  List<int> get intBalls => balls.map((e) => int.parse(e)).toList();

  void _calcLotteryCensus(int max) {
    List<int> intBalls = balls.map((e) => int.parse(e)).toList();

    ///计算和值
    sum = intBalls.reduce((v, e) => v + e);

    ///计算质合
    pc = _calcPc(intBalls);

    ///计算012形态
    ott = _calc012(intBalls);

    ///计算大小
    bs = _calcBs(intBalls, max);

    ///计算奇偶
    oe = _calcOe(intBalls);

    ///计算跨度
    intBalls.sort((a, b) => a.compareTo(b));
    kua = intBalls.last - intBalls.first;
  }

  ItemRatio _calcPc(List<int> balls) {
    Map<String, int> groups = {};
    List<String> primes = balls.map((e) {
      String pc = _isComposite(e) ? '合' : '质';
      groups[pc] = groups.containsKey(pc) ? groups[pc]! + 1 : 1;
      return pc;
    }).toList();
    String ratio = '${groups['质'] ?? 0}:${groups['合'] ?? 0}';
    return ItemRatio(trend: primes, ratio: ratio);
  }

  ItemRatio _calcBs(List<int> balls, int max) {
    int half = max ~/ 2;
    Map<String, int> groups = {};
    List<String> bsList = balls.map((e) {
      String bs = e <= half ? '小' : '大';
      groups[bs] = groups.containsKey(bs) ? groups[bs]! + 1 : 1;
      return bs;
    }).toList();
    String ratio = '${groups['大'] ?? 0}:${groups['小'] ?? 0}';
    return ItemRatio(trend: bsList, ratio: ratio);
  }

  ///
  ItemRatio _calc012(List<int> balls) {
    List<String> trend = balls.map((e) => '${e % 3}').toList();
    String ratio = trend.join('');
    return ItemRatio(trend: trend, ratio: ratio);
  }

  ItemRatio _calcOe(List<int> balls) {
    Map<String, int> groups = {};
    List<String> evens = balls.map((e) {
      String even = _isEven(e) ? '偶' : '奇';
      groups[even] = groups.containsKey(even) ? groups[even]! + 1 : 1;
      return even;
    }).toList();
    String ratio = '${groups['奇'] ?? 0}:${groups['偶'] ?? 0}';
    return ItemRatio(trend: evens, ratio: ratio);
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

  bool _isEven(int x) {
    return x % 2 == 0;
  }
}

class ItemRatio {
  ///
  ///
  late List<String> trend;

  ///
  late String ratio;

  ItemRatio({
    required this.trend,
    required this.ratio,
  });

  bool get isSame {
    return Set.from(trend).length == 1;
  }
}

class CensusCell {
  ///
  late String title;

  ///
  late double width;

  ///
  late double height;

  CensusCell({
    required this.title,
    required this.width,
    required this.height,
  });
}
