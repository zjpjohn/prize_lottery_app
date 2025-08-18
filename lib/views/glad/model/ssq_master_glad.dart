import 'package:prize_lottery_app/base/model/stat_hit_value.dart';
import 'package:prize_lottery_app/views/glad/model/master_glad.dart';

///
///
class SsqMasterGlad extends MasterGlad {
  late StatHitValue red3;
  late StatHitValue red25;
  late StatHitValue rk3;
  late StatHitValue bk;
  late int r25Hit;
  late int b5Hit;

  SsqMasterGlad.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    red3 = StatHitValue.fromJson(json['red3']);
    red25 = StatHitValue.fromJson(json['red25']);
    rk3 = StatHitValue.fromJson(json['rk3']);
    bk = StatHitValue.fromJson(json['bk']);
    r25Hit = json['r25Hit'];
    b5Hit = json['b5Hit'];
  }
}
