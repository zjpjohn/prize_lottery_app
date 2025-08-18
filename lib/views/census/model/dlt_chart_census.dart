import 'package:prize_lottery_app/base/model/census_value.dart';

///
///
class DltChartCensus {
  ///
  late String period;

  ///
  late CensusValue r2;

  ///
  late CensusValue r3;

  ///
  late CensusValue r10;

  ///
  late CensusValue r20;

  ///
  late CensusValue rk3;

  ///
  late CensusValue rk6;

  ///
  late CensusValue b2;

  ///
  late CensusValue b6;

  ///
  late CensusValue bk;

  DltChartCensus.fromJson(Map<String, dynamic> json) {
    period = json['period'] ?? '';
    r2 = CensusValue.fromJson(json['r2']['values']);
    r3 = CensusValue.fromJson(json['r3']['values']);
    r10 = CensusValue.fromJson(json['r10']['values']);
    r20 = CensusValue.fromJson(json['r20']['values']);
    rk3 = CensusValue.fromJson(json['rk3']['values']);
    rk6 = CensusValue.fromJson(json['rk6']['values']);
    b2 = CensusValue.fromJson(json['b2']['values']);
    b6 = CensusValue.fromJson(json['b6']['values']);
    bk = CensusValue.fromJson(json['bk']['values']);
  }
}
