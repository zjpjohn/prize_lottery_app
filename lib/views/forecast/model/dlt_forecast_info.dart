import 'package:prize_lottery_app/base/model/forecast_value.dart';
import 'package:prize_lottery_app/base/model/stat_hit_value.dart';

class DltForecastInfo {
  late int id;
  late String period;
  late String masterId;
  late ForecastValue red1;
  StatHitValue? red1Hit;
  late ForecastValue red2;
  StatHitValue? red2Hit;
  late ForecastValue red3;
  StatHitValue? red3Hit;
  late ForecastValue red10;
  StatHitValue? red10Hit;
  late ForecastValue red20;
  StatHitValue? red20Hit;
  late ForecastValue redKill3;
  StatHitValue? rk3Hit;
  late ForecastValue redKill6;
  StatHitValue? rk6Hit;
  late ForecastValue blue1;
  StatHitValue? blue1Hit;
  late ForecastValue blue2;
  StatHitValue? blue2Hit;
  late ForecastValue blue6;
  StatHitValue? blue6Hit;
  late ForecastValue blueKill3;
  StatHitValue? bkHit;
  String? calcTime;
  String? gmtCreate;

  DltForecastInfo.fromJson(Map<String, dynamic> json) {
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
    red10 = ForecastValue.fromJson(json['red10']);
    if (json['red10Hit'] != null) {
      red10Hit = StatHitValue.fromJson(json['red10Hit']);
    }
    red20 = ForecastValue.fromJson(json['red20']);
    if (json['red20Hit'] != null) {
      red20Hit = StatHitValue.fromJson(json['red20Hit']);
    }
    redKill3 = ForecastValue.fromJson(json['redKill3']);
    if (json['rk3Hit'] != null) {
      rk3Hit = StatHitValue.fromJson(json['rk3Hit']);
    }
    redKill6 = ForecastValue.fromJson(json['redKill6']);
    if (json['rk6Hit'] != null) {
      rk6Hit = StatHitValue.fromJson(json['rk6Hit']);
    }
    blue1 = ForecastValue.fromJson(json['blue1']);
    if (json['blue1Hit'] != null) {
      blue1Hit = StatHitValue.fromJson(json['blue1Hit']);
    }
    blue2 = ForecastValue.fromJson(json['blue2']);
    if (json['blue2Hit'] != null) {
      blue2Hit = StatHitValue.fromJson(json['blue2Hit']);
    }
    blue6 = ForecastValue.fromJson(json['blue6']);
    if (json['blue6Hit'] != null) {
      blue6Hit = StatHitValue.fromJson(json['blue6Hit']);
    }
    blueKill3 = ForecastValue.fromJson(json['blueKill3']);
    if (json['bkHit'] != null) {
      bkHit = StatHitValue.fromJson(json['bkHit']);
    }
  }

  void calcValue() {
    red1.calcValue();
    red2.calcValue();
    red3.calcValue();
    red10.calcValue();
    red20.calcValue();
    redKill3.calcValue();
    redKill6.calcValue();
    blue1.calcValue();
    blue2.calcValue();
    blue6.calcValue();
    blueKill3.calcValue();
  }
}
