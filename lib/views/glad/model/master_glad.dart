import 'package:prize_lottery_app/base/model/master_value.dart';

class MasterGlad {
  late int id;
  late String period;
  late MasterValue master;

  MasterGlad.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    period = json['period'];
    master = MasterValue.fromJson(json['master']);
  }
}
