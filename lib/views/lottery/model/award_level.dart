import 'package:prize_lottery_app/utils/combine_utils.dart';
import 'package:prize_lottery_app/utils/constants.dart';

class AwardLevel {
  ///
  ///
  late int idx;

  ///中奖等级
  late String level;

  ///红球中奖个数
  late int red;

  ///篮球中奖个数
  late int blue;

  ///奖金
  late int award;

  ///红球总个数
  late int tRed;

  ///蓝球总个数
  late int tBlue;

  AwardLevel({
    required this.idx,
    required this.level,
    required this.red,
    required this.blue,
    required this.award,
    required this.tRed,
    required this.tBlue,
  });
}

class AwardCounter {
  ///中奖等级
  AwardLevel level;

  ///中奖注数
  int count;

  ///中奖金额
  int award;

  AwardCounter({
    required this.level,
    this.count = 0,
    this.award = 0,
  });

  String getAward(int limit) {
    if (level.idx <= limit) {
      return count > 0 ? '$count*${levelAwards[level.idx]!}' : '0';
    }
    return '$award';
  }

  void calcAward(
      {required int pRed,
      required int pBlue,
      required int hitRed,
      required int hitBlue}) {
    count = Combination.combine(pRed - hitRed, level.tRed - level.red) *
        Combination.combine(hitRed, level.red) *
        Combination.combine(pBlue - hitBlue, level.tBlue - level.blue) *
        Combination.combine(hitBlue, level.blue);
    award = count * level.award;
  }

  void qlcCalcAward(
      {required int nRed, required int hitRed, required int hitBlue}) {
    count = Combination.combine(
            nRed - hitRed - hitBlue, level.tRed - level.red - level.blue) *
        Combination.combine(hitRed, level.red);
    award = count * level.award;
  }
}
