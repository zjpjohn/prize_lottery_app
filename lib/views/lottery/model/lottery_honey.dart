import 'package:prize_lottery_app/base/model/enum_value.dart';
import 'package:prize_lottery_app/utils/date_util.dart';

///
///
class HoneyValue {
  late List<List<String>> values;

  HoneyValue.fromJson(Map<String, dynamic> json) {
    values = (json['values'] as List)
        .map((e) => (e as List).cast<String>())
        .toList();
  }
}

///
///
class LotteryHoney {
  late String period;
  late EnumValue type;
  late HoneyValue honey;
  late List<String> balls;
  late DateTime date;

  LotteryHoney.fromJson(Map<String, dynamic> json) {
    period = json['period'];
    type = EnumValue.fromJson(json['type']);
    honey = HoneyValue.fromJson(json['honey']);
    date = DateUtil.parse(json['date'], pattern: 'yyyy/MM/dd');
    if (json['balls'] != null) {
      balls = (json['balls'] as List).cast<String>();
    }
  }

  String dateText() {
    return DateUtil.formatDate(date, format: "yy年MM月dd日");
  }
}
