import 'package:prize_lottery_app/base/model/master_value.dart';
import 'package:prize_lottery_app/base/model/stat_hit_value.dart';

class DltMasterDetail {
  ///
  late String period;

  ///
  late MasterValue master;

  ///
  StatHitValue? red3;

  ///
  StatHitValue? red20;

  ///
  StatHitValue? redKill;

  ///
  StatHitValue? blue;

  ///
  StatHitValue? blueKill;

  ///
  late int vip;

  ///
  late int modified;

  ///追踪专家字段
  late String trace;

  ///追踪专家字段中文名
  late String traceZh;

  ///是否重点关注
  late int special;

  ///
  late int subscribed;

  ///
  late String timestamp;

  DltMasterDetail.fromJson(Map<String, dynamic> json) {
    period = json['period'] ?? '';
    master = MasterValue.fromJson(json['master']);
    vip = json['vip'] ?? 0;
    modified = json['modified'] ?? 0;
    subscribed = json['subscribed'] ?? 0;
    trace = json['trace'] ?? '';
    traceZh = json['traceZh'] ?? '';
    special = json['special'] ?? 0;
    timestamp = json['timestamp'];
    if (json['red3'] != null) {
      red3 = StatHitValue.fromJson(json['red3']);
    }
    if (json['red20'] != null) {
      red20 = StatHitValue.fromJson(json['red20']);
    }
    if (json['redKill'] != null) {
      redKill = StatHitValue.fromJson(json['redKill']);
    }
    if (json['blue'] != null) {
      blue = StatHitValue.fromJson(json['blue']);
    }
    if (json['blueKill'] != null) {
      blueKill = StatHitValue.fromJson(json['blueKill']);
    }
  }
}
