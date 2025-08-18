import 'package:prize_lottery_app/base/model/master_value.dart';
import 'package:prize_lottery_app/base/model/stat_hit_value.dart';

class SsqMasterDetail {
  ///
  late String period;

  ///
  late MasterValue master;

  ///
  StatHitValue? red3;

  ///
  StatHitValue? red25;

  ///
  StatHitValue? rk3;

  ///
  StatHitValue? bk;

  ///
  StatHitValue? b5;

  ///
  late int vip;

  ///
  late int modified;

  ///
  late int subscribed;

  ///追踪专家字段
  late String trace;

  ///追踪专家字段中文名
  late String traceZh;

  ///是否重点关注
  late int special;

  ///
  late String timestamp;

  SsqMasterDetail.fromJson(Map<String, dynamic> json) {
    period = json['period'] ?? '';
    vip = json['vip'] ?? 0;
    modified = json['modified'] ?? 0;
    subscribed = json['subscribed'] ?? 0;
    timestamp = json['timestamp'];
    trace = json['trace'] ?? '';
    traceZh = json['traceZh'] ?? '';
    special = json['special'] ?? 0;
    master = MasterValue.fromJson(json['master']);
    if (json['red3'] != null) {
      red3 = StatHitValue.fromJson(json['red3']);
    }
    if (json['red25'] != null) {
      red25 = StatHitValue.fromJson(json['red25']);
    }
    if (json['rk3'] != null) {
      rk3 = StatHitValue.fromJson(json['rk3']);
    }
    if (json['bk'] != null) {
      bk = StatHitValue.fromJson(json['bk']);
    }
    if (json['b5'] != null) {
      b5 = StatHitValue.fromJson(json['b5']);
    }
  }
}
