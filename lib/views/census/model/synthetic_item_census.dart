import 'package:prize_lottery_app/base/model/census_value.dart';

///
///
class SyntheticItemCensus {
  ///
  ///统计期号
  late String period;

  ///分类排名前10
  late CensusValue level10;

  ///分类排名前20
  late CensusValue level20;

  ///分类排名前50
  late CensusValue level50;

  ///分类排名前100
  late CensusValue level100;

  ///分类排名前150
  late CensusValue level150;

  ///分类排名前200
  late CensusValue level200;

  SyntheticItemCensus.fromJson(Map<String, dynamic> json) {
    period = json['period'] ?? '';
    level10 = CensusValue.fromJson(json['level10']['values']);
    level20 = CensusValue.fromJson(json['level20']['values']);
    level50 = CensusValue.fromJson(json['level50']['values']);
    level100 = CensusValue.fromJson(json['level100']['values']);
    level150 = CensusValue.fromJson(json['level150']['values']);
    level200 = CensusValue.fromJson(json['level200']['values']);
  }
}
