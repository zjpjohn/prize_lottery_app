import 'package:prize_lottery_app/base/model/stat_hit_value.dart';
import 'package:prize_lottery_app/views/rank/model/master_mul_rank.dart';

import 'master_item_rank.dart';

///
///
class QlcMasterRank extends MasterItemRank {
  StatHitValue? red3;
  StatHitValue? red18;
  StatHitValue? red22;
  StatHitValue? kill3;

  QlcMasterRank.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
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

///
///
class QlcMasterMulRank extends MasterMulRank {
  late StatHitValue red3;
  late StatHitValue red18;
  late StatHitValue red22;
  late StatHitValue kill3;

  QlcMasterMulRank.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    red3 = StatHitValue.fromJson(json['red3']);
    red18 = StatHitValue.fromJson(json['red18']);
    red22 = StatHitValue.fromJson(json['red22']);
    kill3 = StatHitValue.fromJson(json['kill3']);
  }

  @override
  MapEntry<String, StatHitValue> redHit() {
    return MapEntry('围码', red22);
  }
}
