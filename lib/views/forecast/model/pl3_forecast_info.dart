import 'package:prize_lottery_app/base/model/forecast_value.dart';
import 'package:prize_lottery_app/base/model/stat_hit_value.dart';

class Pl3ForecastInfo {
  late int id;
  late String period;
  late String masterId;
  late ForecastValue dan1;
  StatHitValue? dan1Hit;
  late ForecastValue dan2;
  StatHitValue? dan2Hit;
  late ForecastValue dan3;
  StatHitValue? dan3Hit;
  late ForecastValue com5;
  StatHitValue? com5Hit;
  late ForecastValue com6;
  StatHitValue? com6Hit;
  late ForecastValue com7;
  StatHitValue? com7Hit;
  late ForecastValue kill1;
  StatHitValue? kill1Hit;
  late ForecastValue kill2;
  StatHitValue? kill2Hit;
  late ForecastValue comb3;
  StatHitValue? comb3Hit;
  late ForecastValue comb4;
  StatHitValue? comb4Hit;
  late ForecastValue comb5;
  StatHitValue? comb5Hit;
  String? calcTime;
  String? gmtCreate;

  Pl3ForecastInfo.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    period = json['period'];
    masterId = json['masterId'];
    calcTime = json['calcTime'] ?? '';
    gmtCreate = json['gmtCreate'] ?? '';
    dan1 = ForecastValue.fromJson(json['dan1']);
    if (json['dan1Hit'] != null) {
      dan1Hit = StatHitValue.fromJson(json['dan1Hit']);
    }
    dan2 = ForecastValue.fromJson(json['dan2']);
    if (json['dan2Hit'] != null) {
      dan2Hit = StatHitValue.fromJson(json['dan2Hit']);
    }
    dan3 = ForecastValue.fromJson(json['dan3']);
    if (json['dan3Hit'] != null) {
      dan3Hit = StatHitValue.fromJson(json['dan3Hit']);
    }
    com5 = ForecastValue.fromJson(json['com5']);
    if (json['com5Hit'] != null) {
      com5Hit = StatHitValue.fromJson(json['com5Hit']);
    }
    com6 = ForecastValue.fromJson(json['com6']);
    if (json['com6Hit'] != null) {
      com6Hit = StatHitValue.fromJson(json['com6Hit']);
    }
    com7 = ForecastValue.fromJson(json['com7']);
    if (json['com7Hit'] != null) {
      com7Hit = StatHitValue.fromJson(json['com7Hit']);
    }
    kill1 = ForecastValue.fromJson(json['kill1']);
    if (json['kill1Hit'] != null) {
      kill1Hit = StatHitValue.fromJson(json['kill1Hit']);
    }
    kill2 = ForecastValue.fromJson(json['kill2']);
    if (json['kill2Hit'] != null) {
      kill2Hit = StatHitValue.fromJson(json['kill2Hit']);
    }
    comb3 = ForecastValue.fromJson(json['comb3']);
    if (json['comb3Hit'] != null) {
      comb3Hit = StatHitValue.fromJson(json['comb3Hit']);
    }
    comb4 = ForecastValue.fromJson(json['comb4']);
    if (json['comb4Hit'] != null) {
      comb4Hit = StatHitValue.fromJson(json['comb4Hit']);
    }
    comb5 = ForecastValue.fromJson(json['comb5']);
    if (json['comb5Hit'] != null) {
      comb5Hit = StatHitValue.fromJson(json['comb5Hit']);
    }
  }

  void calcValue() {
    dan1.calcValue();
    dan2.calcValue();
    dan3.calcValue();
    com5.calcValue();
    com6.calcValue();
    com7.calcValue();
    kill1.calcValue();
    kill2.calcValue();
    comb3.calcValue();
    comb4.calcValue();
    comb5.calcValue();
  }
}
