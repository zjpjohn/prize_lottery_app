import 'package:prize_lottery_app/base/model/master_value.dart';
import 'package:prize_lottery_app/base/model/stat_hit_value.dart';

class Pl3MasterDetail {
  ///
  late String period;

  ///专家信息
  late MasterValue master;

  /// 三胆信息
  StatHitValue? dan3;

  ///六码信息
  StatHitValue? com6;

  ///七码信息
  StatHitValue? com7;

  ///杀一码信息
  StatHitValue? kill1;

  ///杀二码信息
  StatHitValue? kill2;

  ///是否是vip专家
  late int vip;

  ///数据是否更新
  late int modified;

  ///用户是否订阅
  late int subscribed;

  ///追踪专家字段
  late String trace;

  ///追踪专家字段中文名
  late String traceZh;

  ///是否重点关注
  late int special;

  ///时间戳
  late String timestamp;

  Pl3MasterDetail.fromJson(Map<String, dynamic> json) {
    period = json['period'] ?? '';
    vip = json['vip'] ?? 0;
    modified = json['modified'] ?? 0;
    subscribed = json['subscribed'] ?? 0;
    timestamp = json['timestamp'];
    trace = json['trace'] ?? '';
    traceZh = json['traceZh'] ?? '';
    special = json['special'] ?? 0;
    master = MasterValue.fromJson(json['master']);
    if (json['dan3'] != null) {
      dan3 = StatHitValue.fromJson(json['dan3']);
    }
    if (json['com6'] != null) {
      com6 = StatHitValue.fromJson(json['com6']);
    }
    if (json['com7'] != null) {
      com7 = StatHitValue.fromJson(json['com7']);
    }
    if (json['kill1'] != null) {
      kill1 = StatHitValue.fromJson(json['kill1']);
    }
    if (json['kill2'] != null) {
      kill2 = StatHitValue.fromJson(json['kill2']);
    }
  }
}
