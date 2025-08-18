import 'package:prize_lottery_app/base/model/enum_value.dart';
import 'package:prize_lottery_app/base/model/master_value.dart';

///
///
class RecommendMaster {
  ///
  late String masterId;

  ///
  late MasterValue master;

  ///
  late EnumValue type;

  ///
  late int series;

  ///
  late double hitRate;

  ///
  late String hitCount;

  RecommendMaster.fromJson(Map<String, dynamic> json) {
    masterId = json['masterId'];
    master = MasterValue.fromJson(json['master']);
    type = EnumValue.fromJson(json['type']);
    series = json['series'];
    hitRate = json['hitRate'];
    hitCount = json['hitCount'];
  }
}
