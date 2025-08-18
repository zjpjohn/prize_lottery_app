import 'package:prize_lottery_app/utils/quick_table.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_info.dart';

///
///
class FastTable {
  ///本期开奖信息
  late LotteryInfo current;

  ///上一期开奖信息
  late LotteryInfo last;

  /// 上上一期开奖信息
  late LotteryInfo before;

  /// 上上一期开奖信息
  late LotteryInfo lastBefore;

  ///速查表信息
  late List<List<RenderCell>> fastTable;

  FastTable.fromJson(Map<String, dynamic> json) {
    ///本期开奖信息
    current = LotteryInfo.fromJson(json['current']);

    ///上一期开奖信息
    last = LotteryInfo.fromJson(json['last']);

    ///上上一期开奖信息
    before = LotteryInfo.fromJson(json['before']);

    ///上上一期开奖信息
    lastBefore = LotteryInfo.fromJson(json['lastBefore']);

    ///速查表信息
    fastTable = QuickTable.fastTable(
      last: last.redBalls(),
      before: before.redBalls(),
      lastBefore: lastBefore.redBalls(),
      currentShi: current.shiBalls(),
      current: current.redBalls(),
    );
  }
}

class TrialTable {
  ///本期开奖信息
  late FairTrial current;

  ///上一期开奖信息
  late FairTrial last;

  /// 上上一期开奖信息
  late FairTrial before;

  TrialTable.fromJson(Map<String, dynamic> json) {
    ///本期开奖信息
    current = FairTrial.fromJson(json['current']);

    ///上一期开奖信息
    last = FairTrial.fromJson(json['last']);

    ///上上一期开奖信息
    before = FairTrial.fromJson(json['before']);
  }
}
