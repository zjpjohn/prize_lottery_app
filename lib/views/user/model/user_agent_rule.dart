import 'package:prize_lottery_app/base/model/enum_value.dart';

///
class UserAgentRule {
  late EnumValue agent;
  late int profited;
  late double ratio;
  late int reward;
  late String startTime;

  UserAgentRule.fromJson(Map<String, dynamic> json) {
    agent = EnumValue.fromJson(json['agent']);
    profited = json['profited'];
    ratio = json['ratio'];
    reward = json['reward'];
    startTime = json['startTime'];
  }
}
