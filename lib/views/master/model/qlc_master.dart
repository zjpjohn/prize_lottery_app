import 'package:prize_lottery_app/base/model/master_value.dart';
import 'package:prize_lottery_app/base/model/stat_hit_value.dart';

class QlcMasterDetail {
  ///
  late String period;

  ///
  late MasterValue master;

  ///
  StatHitValue? red3;

  ///
  StatHitValue? red18;

  ///
  StatHitValue? red22;

  ///
  StatHitValue? kill3;

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

  QlcMasterDetail.fromJson(Map<String, dynamic> json) {
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
    if (json['red18'] != null) {
      red18 = StatHitValue.fromJson(json['red18']);
    }
    if (json['red22'] != null) {
      red22 = StatHitValue.fromJson(json['red22']);
    }
    if (json['kill3'] != null) {
      kill3 = StatHitValue.fromJson(json['kill3']);
    }
  }
}
