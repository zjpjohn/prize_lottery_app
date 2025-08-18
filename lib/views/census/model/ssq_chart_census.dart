import 'package:prize_lottery_app/base/model/census_value.dart';

class SsqChartCensus {
  ///
  late String period;

  ///
  late CensusValue r1;

  ///
  late CensusValue r2;

  ///
  late CensusValue r3;

  ///
  late CensusValue r12;

  ///
  late CensusValue r20;

  ///
  late CensusValue r25;

  ///
  late CensusValue rk3;

  ///
  late CensusValue rk6;

  ///
  late CensusValue b3;

  ///
  late CensusValue b5;

  ///
  late CensusValue bk;

  SsqChartCensus.fromJson(Map<String, dynamic> json) {
    period = json['period'] ?? '';
    r1 = CensusValue.fromJson(json['r1']['values']);
    r2 = CensusValue.fromJson(json['r2']['values']);
    r3 = CensusValue.fromJson(json['r3']['values']);
    r12 = CensusValue.fromJson(json['r12']['values']);
    r20 = CensusValue.fromJson(json['r20']['values']);
    r25 = CensusValue.fromJson(json['r25']['values']);
    rk3 = CensusValue.fromJson(json['rk3']['values']);
    rk6 = CensusValue.fromJson(json['rk6']['values']);
    b3 = CensusValue.fromJson(json['b3']['values']);
    b5 = CensusValue.fromJson(json['b5']['values']);
    bk = CensusValue.fromJson(json['bk']['values']);
  }
}
