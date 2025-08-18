import 'package:prize_lottery_app/base/model/stat_hit_value.dart';
import 'package:prize_lottery_app/views/rank/model/master_item_rank.dart';
import 'package:prize_lottery_app/views/rank/model/master_mul_rank.dart';

///
///
class SsqMasterRank extends MasterItemRank {
  StatHitValue? red3;
  StatHitValue? red25;
  StatHitValue? rk3;
  StatHitValue? b5;
  StatHitValue? bk;

  SsqMasterRank.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    if (json['red3'] != null) {
      red3 = StatHitValue.fromJson(json['red3']);
    }
    if (json['red25'] != null) {
      red25 = StatHitValue.fromJson(json['red25']);
    }
    if (json['rk3'] != null) {
      rk3 = StatHitValue.fromJson(json['rk3']);
    }
    if (json['b5'] != null) {
      b5 = StatHitValue.fromJson(json['b5']);
    }
    if (json['bk'] != null) {
      bk = StatHitValue.fromJson(json['bk']);
    }
  }
}

///
///
class SsqMasterMulRank extends MasterMulRank {
  late StatHitValue red3;
  late StatHitValue red25;
  late StatHitValue rk3;
  late StatHitValue bk;

  SsqMasterMulRank.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    red3 = StatHitValue.fromJson(json['red3']);
    red25 = StatHitValue.fromJson(json['red25']);
    rk3 = StatHitValue.fromJson(json['rk3']);
    bk = StatHitValue.fromJson(json['bk']);
  }

  @override
  MapEntry<String, StatHitValue> redHit() {
    return MapEntry('杀红', rk3);
  }

  @override
  MapEntry<String, StatHitValue>? blueHit() {
    return MapEntry('杀蓝', bk);
  }
}
