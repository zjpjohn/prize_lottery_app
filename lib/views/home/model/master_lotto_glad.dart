import 'package:prize_lottery_app/base/model/enum_value.dart';
import 'package:prize_lottery_app/base/model/master_value.dart';

///
///
class MasterLottoGlad {
  ///
  late MasterValue master;
  late EnumValue lottery;
  late String period;
  late String content;
  late int type;

  MasterLottoGlad.fromJson(Map<String, dynamic> json) {
    master = MasterValue.fromJson(json['master']);
    lottery = EnumValue.fromJson(json['lottery']);
    period = json['period'];
    content = json['content'];
    type = json['type'];
  }
}
