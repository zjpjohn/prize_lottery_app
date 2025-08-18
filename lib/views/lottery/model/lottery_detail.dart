import 'package:prize_lottery_app/views/lottery/model/lottery_info.dart';

///
///
class LotteryDetail {
  late LotteryInfo lottery;
  late LotteryAward award;
  late List<LotteryLevel> levels;

  LotteryDetail.fromJson(Map<String, dynamic> json) {
    lottery = LotteryInfo.fromJson(json['lottery']);
    award = LotteryAward.fromJson(json['award']);
    List levelJson = json['levels'];
    levels = levelJson.map((e) => LotteryLevel.fromJson(e)).toList();
  }
}

class LotteryAward {
  ///
  late String type;

  ///
  late String period;

  ///
  int sales = 0;

  ///
  int award = 0;

  ///
  int pool = 0;

  LotteryAward.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    period = json['period'];
    sales = json['sales'] != null ? int.parse(json['sales']) : 0;
    award = json['award'] != null ? int.parse(json['award']) : 0;
    pool = json['pool'] != null ? int.parse(json['pool']) : 0;
  }
}

class LotteryLevel {
  late String type;
  late String period;
  late int level;
  int quantity = 0;
  double bonus = 0;
  double amount = 0;

  LotteryLevel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    period = json['period'];
    level = json['level'];
    quantity = json['quantity'] ?? 0;
    bonus = json['bonus'] ?? 0;
    amount = json['amount'] ?? 0;
  }
}
