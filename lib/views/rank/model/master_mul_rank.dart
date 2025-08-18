import 'package:prize_lottery_app/base/model/master_value.dart';
import 'package:prize_lottery_app/base/model/stat_hit_value.dart';
import 'package:prize_lottery_app/utils/tools.dart';

abstract class MasterMulRank {
  late int id;
  late String period;
  late int hot;
  late int vip;
  late int rank;
  late int lastRank;
  late int browse;
  late MasterValue master;

  MasterMulRank.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    period = json['period'];
    hot = json['hot'];
    vip = json['vip'];
    rank = json['rank'];
    lastRank = json['lastRank'] ?? 0;
    browse = Tools.randLimit(json['browse'] ?? 0, 100);
    master = MasterValue.fromJson(json['master']);
  }

  MapEntry<String, StatHitValue> redHit();

  MapEntry<String, StatHitValue>? blueHit() {
    return null;
  }
}
