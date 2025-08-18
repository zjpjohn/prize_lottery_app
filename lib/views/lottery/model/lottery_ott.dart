import 'package:prize_lottery_app/base/model/enum_value.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_omit.dart';

class LotteryOtt {
  late EnumValue type;
  late String period;
  late String lottery;
  late OmitValue bott;
  late OmitValue sott;
  late OmitValue gott;

  LotteryOtt.fromJson(Map<String, dynamic> json) {
    period = json['period'];
    lottery = json['lottery'];
    type = EnumValue.fromJson(json['type']);
    bott = OmitValue.fromJson(json['bott']);
    sott = OmitValue.fromJson(json['sott']);
    gott = OmitValue.fromJson(json['gott']);
  }

  List<String> balls() {
    return lottery.split(RegExp('\\s+')).toList();
  }
}
