import 'package:prize_lottery_app/base/model/stat_hit_value.dart';
import 'package:prize_lottery_app/views/rank/model/master_item_rank.dart';
import 'package:prize_lottery_app/views/rank/model/master_mul_rank.dart';

///
///
class Pl3MasterRank extends MasterItemRank {
  StatHitValue? dan3;
  StatHitValue? com7;
  StatHitValue? kill1;

  Pl3MasterRank.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    if (json['dan3'] != null) {
      dan3 = StatHitValue.fromJson(json['dan3']);
    }
    if (json['com7'] != null) {
      com7 = StatHitValue.fromJson(json['com7']);
    }
    if (json['kill1'] != null) {
      kill1 = StatHitValue.fromJson(json['kill1']);
    }
  }
}

///
///
class Pl3MasterMulRank extends MasterMulRank {
  late StatHitValue dan3;
  late StatHitValue com6;
  late StatHitValue com7;
  late StatHitValue kill1;

  Pl3MasterMulRank.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    dan3 = StatHitValue.fromJson(json['dan3']);
    com6 = StatHitValue.fromJson(json['com6']);
    com7 = StatHitValue.fromJson(json['com7']);
    kill1 = StatHitValue.fromJson(json['kill1']);
  }

  @override
  MapEntry<String, StatHitValue> redHit() {
    return MapEntry('七码', com7);
  }
}
