import 'package:prize_lottery_app/base/model/census_value.dart';

///
///
class SyntheticFullCensus {
  ///
  late String period;

  ///
  late CensusValue level100;

  ///
  late CensusValue level200;

  ///
  late CensusValue level400;

  ///
  late CensusValue level600;

  ///
  late CensusValue level800;

  ///
  late CensusValue level1000;

  SyntheticFullCensus.fromJson(Map<String, dynamic> json) {
    period = json['period'] ?? '';
    level100 = CensusValue.fromJson(json['level100']['values']);
    level200 = CensusValue.fromJson(json['level200']['values']);
    level400 = CensusValue.fromJson(json['level400']['values']);
    level600 = CensusValue.fromJson(json['level600']['values']);
    level800 = CensusValue.fromJson(json['level800']['values']);
    level1000 = CensusValue.fromJson(json['level1000']['values']);
  }
}
