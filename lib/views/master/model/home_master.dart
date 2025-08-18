import 'package:prize_lottery_app/base/model/master_value.dart';
import 'package:prize_lottery_app/base/model/stat_hit_value.dart';

class HomeMaster {
  ///
  late String period;

  ///
  late String type;

  ///
  late MasterValue master;

  ///
  late int rank;

  ///
  late StatHitValue rate;

  ///
  late String gmtCreate;

  HomeMaster.fromJson(Map<String, dynamic> json) {
    period = json['period'];
    type = json['type'];
    rank = json['rank'];
    master = MasterValue.fromJson(json['master']);
    rate = StatHitValue.fromJson(json['rate']);
    gmtCreate = json['gmtCreate'];
  }
}
