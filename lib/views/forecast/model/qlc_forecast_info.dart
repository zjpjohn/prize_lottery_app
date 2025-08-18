import 'package:prize_lottery_app/base/model/forecast_value.dart';
import 'package:prize_lottery_app/base/model/stat_hit_value.dart';

class QlcForecastInfo {
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
  late ForecastValue red18;
  StatHitValue? red18Hit;
  late ForecastValue red22;
  StatHitValue? red22Hit;
  late ForecastValue kill3;
  StatHitValue? kill3Hit;
  late ForecastValue kill6;
  StatHitValue? kill6Hit;
  String? calcTime;
  String? gmtCreate;

  QlcForecastInfo.fromJson(Map<String, dynamic> json) {
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
    red18 = ForecastValue.fromJson(json['red18']);
    if (json['red18Hit'] != null) {
      red18Hit = StatHitValue.fromJson(json['red18Hit']);
    }
    red22 = ForecastValue.fromJson(json['red22']);
    if (json['red22Hit'] != null) {
      red22Hit = StatHitValue.fromJson(json['red22Hit']);
    }
    kill3 = ForecastValue.fromJson(json['kill3']);
    if (json['kill3Hit'] != null) {
      kill3Hit = StatHitValue.fromJson(json['kill3Hit']);
    }
    kill6 = ForecastValue.fromJson(json['kill6']);
    if (json['kill6Hit'] != null) {
      kill6Hit = StatHitValue.fromJson(json['kill6Hit']);
    }
  }

  void calcValue() {
    red1.calcValue();
    red2.calcValue();
    red3.calcValue();
    red12.calcValue();
    red18.calcValue();
    red22.calcValue();
    kill3.calcValue();
    kill6.calcValue();
  }
}
