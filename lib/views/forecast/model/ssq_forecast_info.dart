import 'package:prize_lottery_app/base/model/forecast_value.dart';
import 'package:prize_lottery_app/base/model/stat_hit_value.dart';

class SsqForecastInfo {
  late int id;
  late String period;
  late String masterId;
  late ForecastValue red1;
  StatHitValue? red1Hit;
  late ForecastValue red2;
  StatHitValue? red2Hit;
  late ForecastValue red3;
  StatHitValue? red3Hit;
  late ForecastValue red12;
  StatHitValue? red12Hit;
  late ForecastValue red20;
  StatHitValue? red20Hit;
  late ForecastValue red25;
  StatHitValue? red25Hit;
  late ForecastValue redKill3;
  StatHitValue? rk3Hit;
  late ForecastValue redKill6;
  StatHitValue? rk6Hit;
  late ForecastValue blue3;
  StatHitValue? blue3Hit;
  late ForecastValue blue5;
  StatHitValue? blue5Hit;
  late ForecastValue blueKill;
  StatHitValue? bkHit;
  String? calcTime;
  String? gmtCreate;

  SsqForecastInfo.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    period = json['period'];
    masterId = json['masterId'];
    calcTime = json['calcTime'] ?? '';
    gmtCreate = json['gmtCreate'] ?? '';
    red1 = ForecastValue.fromJson(json['red1']);
    if (json['red1Hit'] != null) {
      red1Hit = StatHitValue.fromJson(json['red1Hit']);
    }
    red2 = ForecastValue.fromJson(json['red2']);
    if (json['red2Hit'] != null) {
      red2Hit = StatHitValue.fromJson(json['red2Hit']);
    }
    red3 = ForecastValue.fromJson(json['red3']);
    if (json['red3Hit'] != null) {
      red3Hit = StatHitValue.fromJson(json['red3Hit']);
    }
    red12 = ForecastValue.fromJson(json['red12']);
    if (json['red12Hit'] != null) {
      red12Hit = StatHitValue.fromJson(json['red12Hit']);
    }
    red20 = ForecastValue.fromJson(json['red20']);
    if (json['red20Hit'] != null) {
      red20Hit = StatHitValue.fromJson(json['red20Hit']);
    }
    red25 = ForecastValue.fromJson(json['red25']);
    if (json['red25Hit'] != null) {
      red25Hit = StatHitValue.fromJson(json['red25Hit']);
    }
    redKill3 = ForecastValue.fromJson(json['redKill3']);
    if (json['rk3Hit'] != null) {
      rk3Hit = StatHitValue.fromJson(json['rk3Hit']);
    }
    redKill6 = ForecastValue.fromJson(json['redKill6']);
    if (json['rk6Hit'] != null) {
      rk6Hit = StatHitValue.fromJson(json['rk6Hit']);
    }
    blue3 = ForecastValue.fromJson(json['blue3']);
    if (json['blue3Hit'] != null) {
      blue3Hit = StatHitValue.fromJson(json['blue3Hit']);
    }
    blue5 = ForecastValue.fromJson(json['blue5']);
    if (json['blue5Hit'] != null) {
      blue5Hit = StatHitValue.fromJson(json['blue5Hit']);
    }
    blueKill = ForecastValue.fromJson(json['blueKill']);
    if (json['bkHit'] != null) {
      bkHit = StatHitValue.fromJson(json['bkHit']);
    }
  }

  void calcValue() {
    red1.calcValue();
    red2.calcValue();
    red3.calcValue();
    red12.calcValue();
    red20.calcValue();
    red25.calcValue();
    redKill3.calcValue();
    redKill6.calcValue();
    blue3.calcValue();
    blue5.calcValue();
    blueKill.calcValue();
  }
}
