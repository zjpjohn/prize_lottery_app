import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/utils/combine_utils.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_info.dart';
import 'package:prize_lottery_app/views/lottery/repository/lottery_info_repository.dart';

List<int> getLimits(int start, int end) {
  return [for (int i = start; i <= end; i++) i];
}

final List<int> ruleIndices = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

final Map<int, PlayRule> rules = {
  10: PlayRule(
    name: '选十',
    size: 10,
    limits: getLimits(10, 17),
    levels: {
      0: AwardInfo(level: '中0', award: 2),
      5: AwardInfo(level: '中5', award: 3),
      6: AwardInfo(level: '中6', award: 5),
      7: AwardInfo(level: '中7', award: 80),
      8: AwardInfo(level: '中8', award: 800),
      9: AwardInfo(level: '中9', award: 8000),
      10: AwardInfo(level: '中10', fix: false, floats: 'A'),
    },
  ),
  9: PlayRule(
    name: '选九',
    size: 9,
    limits: getLimits(9, 16),
    levels: {
      0: AwardInfo(level: '中0', award: 2),
      4: AwardInfo(level: '中4', award: 3),
      5: AwardInfo(level: '中5', award: 5),
      6: AwardInfo(level: '中6', award: 20),
      7: AwardInfo(level: '中7', award: 200),
      8: AwardInfo(level: '中8', award: 2000),
      9: AwardInfo(level: '中9', award: 300000),
    },
  ),
  8: PlayRule(
    name: '选八',
    size: 8,
    limits: getLimits(8, 16),
    levels: {
      0: AwardInfo(level: '中0', award: 2),
      4: AwardInfo(level: '中4', award: 3),
      5: AwardInfo(level: '中5', award: 10),
      6: AwardInfo(level: '中6', award: 88),
      7: AwardInfo(level: '中7', award: 800),
      8: AwardInfo(level: '中8', award: 50000),
    },
  ),
  7: PlayRule(
    name: '选七',
    size: 7,
    limits: getLimits(7, 16),
    levels: {
      0: AwardInfo(level: '中0', award: 2),
      4: AwardInfo(level: '中4', award: 4),
      5: AwardInfo(level: '中5', award: 28),
      6: AwardInfo(level: '中6', award: 288),
      7: AwardInfo(level: '中7', award: 10000),
    },
  ),
  6: PlayRule(
    name: '选六',
    size: 6,
    limits: getLimits(6, 17),
    levels: {
      3: AwardInfo(level: '中3', award: 3),
      4: AwardInfo(level: '中4', award: 10),
      5: AwardInfo(level: '中5', award: 30),
      6: AwardInfo(level: '中6', award: 3000),
    },
  ),
  5: PlayRule(
    name: '选五',
    size: 5,
    limits: getLimits(5, 19),
    levels: {
      3: AwardInfo(level: '中3', award: 3),
      4: AwardInfo(level: '中4', award: 21),
      5: AwardInfo(level: '中5', award: 1000),
    },
  ),
  4: PlayRule(
    name: '选四',
    size: 4,
    limits: getLimits(4, 24),
    levels: {
      2: AwardInfo(level: '中2', award: 3),
      3: AwardInfo(level: '中3', award: 5),
      4: AwardInfo(level: '中4', award: 100),
    },
  ),
  3: PlayRule(
    name: '选三',
    size: 3,
    limits: getLimits(3, 42),
    levels: {
      2: AwardInfo(level: '中2', award: 3),
      3: AwardInfo(level: '中3', award: 53),
    },
  ),
  2: PlayRule(
    name: '选二',
    size: 2,
    limits: getLimits(2, 80),
    levels: {
      2: AwardInfo(level: '中2', award: 19),
    },
  ),
  1: PlayRule(
    name: '选一',
    size: 1,
    limits: getLimits(1, 80),
    levels: {
      1: AwardInfo(level: '中1', award: 4.6),
    },
  ),
};

class Kl8CalculatorController extends AbsRequestController {
  ///
  ///最新开奖信息
  late LotteryInfo lottery;

  ///
  /// 中奖计算结果
  AwardCounter awardCounter = AwardCounter(
    ruleIdx: 10,
    selected: 10,
  );

  ///
  /// 选择玩法
  void playRule(int ruleIdx) {
    awardCounter.pickPlayRule(ruleIdx);
    update();
  }

  ///
  /// 选择基本号码个数
  void selectedBase(int selected) {
    awardCounter.pickBase(selected);
    update();
  }

  ///
  /// 选择命中号码个数
  void selectedHit(int hit) {
    awardCounter.pickHitBalls(hit);
    update();
  }

  ///
  /// 计算奖金
  void calcAwardCount() {
    EasyLoading.show(status: '计算中');
    Future.delayed(const Duration(milliseconds: 250), () {
      awardCounter.calcCounter();
      update();
    }).then((value) => EasyLoading.dismiss());
  }

  @override
  Future<void> request() async {
    showLoading();
    LotteryInfoRepository.latestLottery('kl8').then((value) {
      lottery = value;
      Future.delayed(const Duration(milliseconds: 250), () {
        showSuccess(lottery);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}

///
/// 玩法
///
class AwardCounter {
  ///
  /// 规则标识
  int ruleIdx;

  ///选择的基础号码个数
  int selected;

  ///命中号码个数
  int hit;

  ///总注数
  int total;

  ///
  late PlayRule playRule;

  ///计算后中奖详情
  Map<int, AwardHit> awardHits = {};

  AwardCounter({
    required this.ruleIdx,
    required this.selected,
    this.hit = 0,
    this.total = 0,
  }) {
    playRule = rules[ruleIdx]!;
  }

  ///
  /// 选择玩法规则
  void pickPlayRule(int rule) {
    ruleIdx = rule;
    playRule = rules[rule]!;
    pickBase(rule);
  }

  ///
  /// 选择基础号码个数
  void pickBase(int balls) {
    selected = balls;
    pickHitBalls(0);
  }

  ///
  /// 选择命中号码个数
  void pickHitBalls(int balls) {
    hit = balls;
    total = 0;
    awardHits = {};
  }

  int getTotalHit() {
    return selected > 20 ? 20 : selected;
  }

  ///
  /// 计算选号中奖
  void calcCounter() {
    total = Combination.combine(selected, ruleIdx);
    Map<int, AwardInfo> levels = playRule.levels;
    levels.forEach((key, value) {
      if (key <= hit && (selected - hit >= ruleIdx - key)) {
        int count = Combination.combine(hit, key) *
            Combination.combine(selected - hit, ruleIdx - key);
        String award = value.fix
            ? (value.award * count).toStringAsFixed(1)
            : '$count*${value.floats}';
        awardHits[key] = AwardHit(level: key, count: count, award: award);
      }
    });
  }
}

///
/// 计算中奖命中信息
///
class AwardHit {
  ///
  /// 中奖等级
  int level;

  ///中奖注数
  int count;

  ///中奖金额
  String award;

  AwardHit({
    required this.level,
    this.count = 0,
    this.award = '0',
  });
}

///
/// 玩法信息
///
class PlayRule {
  ///玩法名称
  final String name;

  ///每注选号个数
  final int size;

  ///允许投注号码个数
  final List<int> limits;

  /// 中奖等级条件
  final Map<int, AwardInfo> levels;

  PlayRule({
    required this.name,
    required this.size,
    required this.limits,
    required this.levels,
  });
}

class AwardInfo {
  ///
  /// 中奖条件
  final String level;

  /// 单注奖金
  final double award;

  ///是否为固定奖金
  final bool fix;

  ///浮动奖金是单注金额
  final String? floats;

  AwardInfo({
    required this.level,
    this.award = 0,
    this.fix = true,
    this.floats = '',
  });
}
