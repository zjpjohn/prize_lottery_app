import 'package:prize_lottery_app/base/model/stat_hit_value.dart';
import 'package:prize_lottery_app/views/glad/model/master_glad.dart';

///
///
class QlcMasterGlad extends MasterGlad {
  late StatHitValue red3;
  late StatHitValue red18;
  late StatHitValue red22;
  late StatHitValue kill3;

  QlcMasterGlad.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    red3 = StatHitValue.fromJson(json['red3']);
    red18 = StatHitValue.fromJson(json['red18']);
    red22 = StatHitValue.fromJson(json['red22']);
    kill3 = StatHitValue.fromJson(json['kill3']);
  }
}
