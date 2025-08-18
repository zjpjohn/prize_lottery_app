import 'package:prize_lottery_app/base/model/stat_hit_value.dart';
import 'package:prize_lottery_app/views/glad/model/master_glad.dart';

///
///
class DltMasterGlad extends MasterGlad {
  late StatHitValue red3;
  late StatHitValue red20;
  late StatHitValue rk;
  late StatHitValue bk;
  late int r20Hit;
  late int b6Hit;

  DltMasterGlad.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    red3 = StatHitValue.fromJson(json['red3']);
    red20 = StatHitValue.fromJson(json['red20']);
    rk = StatHitValue.fromJson(json['rk']);
    bk = StatHitValue.fromJson(json['bk']);
    r20Hit = json['r20Hit'];
    b6Hit = json['b6Hit'];
  }
}
