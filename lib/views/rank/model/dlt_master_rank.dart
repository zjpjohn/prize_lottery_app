import 'package:prize_lottery_app/base/model/stat_hit_value.dart';
import 'package:prize_lottery_app/views/rank/model/master_item_rank.dart';
import 'package:prize_lottery_app/views/rank/model/master_mul_rank.dart';

///
///
class DltMasterRank extends MasterItemRank {
  StatHitValue? red3;
  StatHitValue? red20;
  StatHitValue? rk;
  StatHitValue? blue;
  StatHitValue? bk;

  DltMasterRank.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    if (json['red3'] != null) {
      red3 = StatHitValue.fromJson(json['red3']);
    }
    if (json['red20'] != null) {
      red20 = StatHitValue.fromJson(json['red20']);
    }
    if (json['rk'] != null) {
      rk = StatHitValue.fromJson(json['rk']);
    }
    if (json['blue'] != null) {
      blue = StatHitValue.fromJson(json['blue']);
    }
    if (json['bk'] != null) {
      bk = StatHitValue.fromJson(json['bk']);
    }
  }
}

///
///
class DltMasterMulRank extends MasterMulRank {
  late StatHitValue red3;
  late StatHitValue red20;
  late StatHitValue rk;
  late StatHitValue bk;

  DltMasterMulRank.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    red3 = StatHitValue.fromJson(json['red3']);
    red20 = StatHitValue.fromJson(json['red20']);
    rk = StatHitValue.fromJson(json['rk']);
    bk = StatHitValue.fromJson(json['bk']);
  }

  @override
  MapEntry<String, StatHitValue> redHit() {
    return MapEntry('杀红', rk);
  }

  @override
  MapEntry<String, StatHitValue>? blueHit() {
    return MapEntry('杀蓝', bk);
  }
}
