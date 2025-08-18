import 'package:prize_lottery_app/base/model/stat_hit_value.dart';
import 'package:prize_lottery_app/views/glad/model/master_glad.dart';

///
///
class Pl3MasterGlad extends MasterGlad {
  late StatHitValue dan3;
  late StatHitValue com6;
  late StatHitValue com7;
  late StatHitValue kill1;

  Pl3MasterGlad.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    dan3 = StatHitValue.fromJson(json['dan3']);
    com6 = StatHitValue.fromJson(json['com6']);
    com7 = StatHitValue.fromJson(json['com7']);
    kill1 = StatHitValue.fromJson(json['kill1']);
  }
}
