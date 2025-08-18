import 'package:prize_lottery_app/base/model/census_value.dart';

class QlcChartCensus {
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
  late CensusValue r18;

  ///
  late CensusValue r22;

  ///
  late CensusValue k3;

  ///
  late CensusValue k6;

  QlcChartCensus.fromJson(Map<String, dynamic> json) {
    period = json['period'] ?? '';
    r1 = CensusValue.fromJson(json['r1']['values']);
    r2 = CensusValue.fromJson(json['r2']['values']);
    r3 = CensusValue.fromJson(json['r3']['values']);
    r12 = CensusValue.fromJson(json['r12']['values']);
    r18 = CensusValue.fromJson(json['r18']['values']);
    r22 = CensusValue.fromJson(json['r22']['values']);
    k3 = CensusValue.fromJson(json['k3']['values']);
    k6 = CensusValue.fromJson(json['k6']['values']);
  }
}
