import 'package:prize_lottery_app/base/model/enum_value.dart';
import 'package:prize_lottery_app/utils/date_util.dart';

///
///
class AroundCell {
  late String value;
  late int type;

  AroundCell.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    type = json['type'];
  }
}

///
///
class AroundValue {
  late List<AroundCell> cells;

  AroundValue.fromJson(Map<String, dynamic> json) {
    List values = json['cells'] as List;
    cells = values.map((e) => AroundCell.fromJson(e)).toList();
  }
}

///
///
class AroundResult {
  late int lotto;
  late int level1;
  late int level2;
  late int tuo;

  AroundResult.fromJson(Map<String, dynamic> json) {
    lotto = json['lotto'] ?? 0;
    level1 = json['level1'] ?? 0;
    level2 = json['level2'] ?? 0;
    tuo = json['tuo'] ?? 0;
  }
}

///
///
class LotteryAround {
  late String period;
  late EnumValue type;
  late EnumValue lotto;
  late AroundValue around;
  late DateTime date;
  List<String>? balls;
  AroundResult? result;

  LotteryAround.fromJson(Map<String, dynamic> json) {
    period = json['period'];
    type = EnumValue.fromJson(json['type']);
    lotto = EnumValue.fromJson(json['lotto']);
    around = AroundValue.fromJson(json['around']);
    date = DateUtil.parse(json['date'], pattern: 'yyyy/MM/dd');
    if (json['balls'] != null) {
      balls = (json['balls'] as List).cast<String>();
    }
    if (json['result'] != null) {
      result = AroundResult.fromJson(json['result']);
    }
  }

  String dateText() {
    return DateUtil.formatDate(date, format: "yy年MM月dd日");
  }

  ///
  /// 日期偏移
  String timeDelta() {
    TimeDelta delta = DateUtil.dateDeltaText(date);
    if (delta.time == 0) {
      return delta.text;
    }
    return '${delta.time}${delta.text}';
  }
}
