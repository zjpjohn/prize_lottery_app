import 'package:prize_lottery_app/base/model/master_value.dart';
import 'package:prize_lottery_app/base/model/stat_hit_value.dart';
import 'package:prize_lottery_app/utils/tools.dart';

class MasterItemRank {
  late int id;
  late String period;
  late int vip;
  late int hot;
  late int rank;
  late int lastRank;
  late int browse;
  late MasterValue master;
  late StatHitValue rate;

  MasterItemRank.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    period = json['period'];
    rank = json['rank'];
    vip = json['vip'] ?? 0;
    hot = json['hot'] ?? 0;
    lastRank = json['lastRank'] ?? 0;
    browse = Tools.randLimit(json['browse'] ?? 0, 100);
    master = MasterValue.fromJson(json['master']);
    rate = StatHitValue.fromJson(json['rate']);
  }
}
