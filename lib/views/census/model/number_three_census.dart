import 'package:prize_lottery_app/base/model/census_value.dart';

class NumberThreeCensus {
  ///
  late String name;

  ///
  late String period;

  ///
  late CensusValue d2;

  ///
  late CensusValue d3;

  ///
  late CensusValue c5;

  ///
  late CensusValue c6;

  ///
  late CensusValue c7;

  ///
  late CensusValue k1;

  ///
  late CensusValue k2;

  NumberThreeCensus.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    period = json['period'] ?? '';
    d2 = CensusValue.fromJson(json['d2']['values']);
    d3 = CensusValue.fromJson(json['d3']['values']);
    c5 = CensusValue.fromJson(json['c5']['values']);
    c6 = CensusValue.fromJson(json['c6']['values']);
    c7 = CensusValue.fromJson(json['c7']['values']);
    k1 = CensusValue.fromJson(json['k1']['values']);
    k2 = CensusValue.fromJson(json['k2']['values']);
  }
}
