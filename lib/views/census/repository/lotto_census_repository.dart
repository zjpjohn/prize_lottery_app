import 'package:prize_lottery_app/base/model/fee_data_result.dart';
import 'package:prize_lottery_app/utils/request.dart';
import 'package:prize_lottery_app/views/census/model/dlt_chart_census.dart';
import 'package:prize_lottery_app/views/census/model/number_three_census.dart';
import 'package:prize_lottery_app/views/census/model/qlc_chart_census.dart';
import 'package:prize_lottery_app/views/census/model/ssq_chart_census.dart';
import 'package:prize_lottery_app/views/census/model/synthetic_full_census.dart';
import 'package:prize_lottery_app/views/census/model/synthetic_item_census.dart';
import 'package:prize_lottery_app/views/census/model/synthetic_vip_census.dart';

///
///
class LottoCensusRepository {
  ///
  ///
  static Future<NumberThreeCensus> fc3dRateCensus() {
    return HttpRequest()
        .get('/slotto/app/fsd/chart/rate')
        .then((value) => NumberThreeCensus.fromJson(value.data));
  }

  ///
  ///
  static Future<FeeDataResult<NumberThreeCensus>> fc3dRateCensusV1() {
    return HttpRequest()
        .get('/slotto/app/fsd/v1/chart/rate')
        .then((value) => FeeDataResult.fromJson(
              json: value.data,
              dataHandle: (e) => NumberThreeCensus.fromJson(e),
            ));
  }

  ///
  ///
  static Future<NumberThreeCensus> fc3dHotCensus() {
    return HttpRequest()
        .get('/slotto/app/fsd/chart/hot')
        .then((value) => NumberThreeCensus.fromJson(value.data));
  }

  ///
  ///
  static Future<FeeDataResult<NumberThreeCensus>> fc3dHotCensusV1() {
    return HttpRequest()
        .get('/slotto/app/fsd/v1/chart/hot')
        .then((value) => FeeDataResult.fromJson(
              json: value.data,
              dataHandle: (e) => NumberThreeCensus.fromJson(e),
            ));
  }

  ///
  ///
  static Future<NumberThreeCensus> fc3dLevelFull(int level) {
    return HttpRequest()
        .get('/slotto/app/fsd/full/$level')
        .then((value) => NumberThreeCensus.fromJson(value.data));
  }

  ///
  ///
  static Future<FeeDataResult<NumberThreeCensus>> fc3dLevelFullV1(int level) {
    return HttpRequest()
        .get('/slotto/app/fsd/v1/full/$level')
        .then((value) => FeeDataResult.fromJson(
              json: value.data,
              dataHandle: (e) => NumberThreeCensus.fromJson(e),
            ));
  }

  ///
  ///
  static Future<NumberThreeCensus> fc3dLevelVip(int level) {
    return HttpRequest()
        .get('/slotto/app/fsd/vip/$level')
        .then((value) => NumberThreeCensus.fromJson(value.data));
  }

  ///
  ///
  static Future<FeeDataResult<NumberThreeCensus>> fc3dLevelVipV1(int level) {
    return HttpRequest()
        .get('/slotto/app/fsd/v1/vip/$level')
        .then((value) => FeeDataResult.fromJson(
              json: value.data,
              dataHandle: (e) => NumberThreeCensus.fromJson(e),
            ));
  }

  ///
  ///
  static Future<NumberThreeCensus> pl3RateCensus() {
    return HttpRequest()
        .get('/slotto/app/pls/chart/rate')
        .then((value) => NumberThreeCensus.fromJson(value.data));
  }

  ///
  ///
  static Future<FeeDataResult<NumberThreeCensus>> pl3RateCensusV1() {
    return HttpRequest()
        .get('/slotto/app/pls/v1/chart/rate')
        .then((value) => FeeDataResult.fromJson(
              json: value.data,
              dataHandle: (e) => NumberThreeCensus.fromJson(e),
            ));
  }

  ///
  ///
  static Future<NumberThreeCensus> pl3HotCensus() {
    return HttpRequest()
        .get('/slotto/app/pls/chart/hot')
        .then((value) => NumberThreeCensus.fromJson(value.data));
  }

  ///
  ///
  static Future<FeeDataResult<NumberThreeCensus>> pl3HotCensusV1() {
    return HttpRequest()
        .get('/slotto/app/pls/chart/hot')
        .then((value) => FeeDataResult.fromJson(
              json: value.data,
              dataHandle: (e) => NumberThreeCensus.fromJson(e),
            ));
  }

  ///
  ///
  static Future<NumberThreeCensus> pl3LevelFull(int level) {
    return HttpRequest()
        .get('/slotto/app/pls/full/$level')
        .then((value) => NumberThreeCensus.fromJson(value.data));
  }

  ///
  ///
  static Future<FeeDataResult<NumberThreeCensus>> pl3LevelFullV1(int level) {
    return HttpRequest()
        .get('/slotto/app/pls/v1/full/$level')
        .then((value) => FeeDataResult.fromJson(
              json: value.data,
              dataHandle: (e) => NumberThreeCensus.fromJson(e),
            ));
  }

  ///
  ///
  static Future<NumberThreeCensus> pl3LevelVip(int level) {
    return HttpRequest()
        .get('/slotto/app/pls/vip/$level')
        .then((value) => NumberThreeCensus.fromJson(value.data));
  }

  ///
  ///
  static Future<FeeDataResult<NumberThreeCensus>> pl3LevelVipV1(int level) {
    return HttpRequest()
        .get('/slotto/app/pls/v1/vip/$level')
        .then((value) => FeeDataResult.fromJson(
              json: value.data,
              dataHandle: (e) => NumberThreeCensus.fromJson(e),
            ));
  }

  ///
  ///
  static Future<SsqChartCensus> ssqRateCensus() {
    return HttpRequest()
        .get('/slotto/app/ssq/chart/rate')
        .then((value) => SsqChartCensus.fromJson(value.data));
  }

  ///
  ///
  static Future<FeeDataResult<SsqChartCensus>> ssqRateCensusV1() {
    return HttpRequest()
        .get('/slotto/app/ssq/v1/chart/rate')
        .then((value) => FeeDataResult.fromJson(
              json: value.data,
              dataHandle: (e) => SsqChartCensus.fromJson(e),
            ));
  }

  ///
  ///
  static Future<SsqChartCensus> ssqHotCensus() {
    return HttpRequest()
        .get('/slotto/app/ssq/chart/hot')
        .then((value) => SsqChartCensus.fromJson(value.data));
  }

  ///
  ///
  static Future<FeeDataResult<SsqChartCensus>> ssqHotCensusV1() {
    return HttpRequest()
        .get('/slotto/app/ssq/v1/chart/hot')
        .then((value) => FeeDataResult.fromJson(
              json: value.data,
              dataHandle: (e) => SsqChartCensus.fromJson(e),
            ));
  }

  ///
  ///
  static Future<SsqChartCensus> ssqLevelFull(int level) {
    return HttpRequest()
        .get('/slotto/app/ssq/full/$level')
        .then((value) => SsqChartCensus.fromJson(value.data));
  }

  ///
  ///
  static Future<FeeDataResult<SsqChartCensus>> ssqLevelFullV1(int level) {
    return HttpRequest()
        .get('/slotto/app/ssq/v1/full/$level')
        .then((value) => FeeDataResult.fromJson(
              json: value.data,
              dataHandle: (e) => SsqChartCensus.fromJson(e),
            ));
  }

  ///
  ///
  static Future<SsqChartCensus> ssqLevelVip(int level) {
    return HttpRequest()
        .get('/slotto/app/ssq/vip/$level')
        .then((value) => SsqChartCensus.fromJson(value.data));
  }

  ///
  ///
  static Future<FeeDataResult<SsqChartCensus>> ssqLevelVipV1(int level) {
    return HttpRequest()
        .get('/slotto/app/ssq/v1/vip/$level')
        .then((value) => FeeDataResult.fromJson(
              json: value.data,
              dataHandle: (e) => SsqChartCensus.fromJson(e),
            ));
  }

  ///
  ///
  static Future<DltChartCensus> dltRateCensus() {
    return HttpRequest()
        .get('/slotto/app/dlt/chart/rate')
        .then((value) => DltChartCensus.fromJson(value.data));
  }

  ///
  ///
  static Future<FeeDataResult<DltChartCensus>> dltRateCensusV1() {
    return HttpRequest()
        .get('/slotto/app/dlt/v1/chart/rate')
        .then((value) => FeeDataResult.fromJson(
              json: value.data,
              dataHandle: (e) => DltChartCensus.fromJson(e),
            ));
  }

  ///
  ///
  static Future<DltChartCensus> dltHotCensus() {
    return HttpRequest()
        .get('/slotto/app/dlt/chart/hot')
        .then((value) => DltChartCensus.fromJson(value.data));
  }

  ///
  ///
  static Future<FeeDataResult<DltChartCensus>> dltHotCensusV1() {
    return HttpRequest()
        .get('/slotto/app/dlt/v1/chart/hot')
        .then((value) => FeeDataResult.fromJson(
              json: value.data,
              dataHandle: (e) => DltChartCensus.fromJson(e),
            ));
  }

  ///
  ///
  static Future<DltChartCensus> dltLevelFull(int level) {
    return HttpRequest()
        .get('/slotto/app/dlt/full/$level')
        .then((value) => DltChartCensus.fromJson(value.data));
  }

  ///
  ///
  static Future<FeeDataResult<DltChartCensus>> dltLevelFullV1(int level) {
    return HttpRequest()
        .get('/slotto/app/dlt/v1/full/$level')
        .then((value) => FeeDataResult.fromJson(
              json: value.data,
              dataHandle: (e) => DltChartCensus.fromJson(e),
            ));
  }

  ///
  ///
  static Future<DltChartCensus> dltLevelVip(int level) {
    return HttpRequest()
        .get('/slotto/app/dlt/vip/$level')
        .then((value) => DltChartCensus.fromJson(value.data));
  }

  ///
  ///
  static Future<FeeDataResult<DltChartCensus>> dltLevelVipV1(int level) {
    return HttpRequest()
        .get('/slotto/app/dlt/v1/vip/$level')
        .then((value) => FeeDataResult.fromJson(
              json: value.data,
              dataHandle: (e) => DltChartCensus.fromJson(e),
            ));
  }

  ///
  ///
  static Future<QlcChartCensus> qlcRateCensus() {
    return HttpRequest()
        .get('/slotto/app/qlc/chart/rate')
        .then((value) => QlcChartCensus.fromJson(value.data));
  }

  ///
  ///
  static Future<FeeDataResult<QlcChartCensus>> qlcRateCensusV1() {
    return HttpRequest()
        .get('/slotto/app/qlc/v1/chart/rate')
        .then((value) => FeeDataResult.fromJson(
              json: value.data,
              dataHandle: (e) => QlcChartCensus.fromJson(e),
            ));
  }

  ///
  ///
  static Future<QlcChartCensus> qlcHotCensus() {
    return HttpRequest()
        .get('/slotto/app/qlc/chart/hot')
        .then((value) => QlcChartCensus.fromJson(value.data));
  }

  ///
  ///
  static Future<FeeDataResult<QlcChartCensus>> qlcHotCensusV1() {
    return HttpRequest()
        .get('/slotto/app/qlc/v1/chart/hot')
        .then((value) => FeeDataResult.fromJson(
              json: value.data,
              dataHandle: (e) => QlcChartCensus.fromJson(e),
            ));
  }

  ///
  ///
  static Future<QlcChartCensus> qlcLevelFull(int level) {
    return HttpRequest()
        .get('/slotto/app/qlc/full/$level')
        .then((value) => QlcChartCensus.fromJson(value.data));
  }

  ///
  ///
  static Future<FeeDataResult<QlcChartCensus>> qlcLevelFullV1(int level) {
    return HttpRequest()
        .get('/slotto/app/qlc/v1/full/$level')
        .then((value) => FeeDataResult.fromJson(
              json: value.data,
              dataHandle: (e) => QlcChartCensus.fromJson(e),
            ));
  }

  ///
  ///
  static Future<QlcChartCensus> qlcLevelVip(int level) {
    return HttpRequest()
        .get('/slotto/app/qlc/vip/$level')
        .then((value) => QlcChartCensus.fromJson(value.data));
  }

  ///
  ///
  static Future<FeeDataResult<QlcChartCensus>> qlcLevelVipV1(int level) {
    return HttpRequest()
        .get('/slotto/app/qlc/v1/vip/$level')
        .then((value) => FeeDataResult.fromJson(
              json: value.data,
              dataHandle: (e) => QlcChartCensus.fromJson(e),
            ));
  }

  ///
  ///
  static Future<SyntheticFullCensus> fullCensus(
      {required String lottery, required String type}) {
    return HttpRequest()
        .get('/slotto/app/$lottery/chart/full/$type')
        .then((value) => SyntheticFullCensus.fromJson(value.data));
  }

  ///
  ///
  static Future<FeeDataResult<SyntheticFullCensus>> fullCensusV1(
      {required String lottery, required String type}) {
    return HttpRequest()
        .get('/slotto/app/$lottery/v1/chart/full/$type')
        .then((value) => FeeDataResult.fromJson(
              json: value.data,
              dataHandle: (e) => SyntheticFullCensus.fromJson(e),
            ));
  }

  ///
  ///
  static Future<SyntheticVipCensus> vipCensus({
    required String lottery,
    required String type,
  }) {
    return HttpRequest()
        .get('/slotto/app/$lottery/chart/vip/$type')
        .then((value) => SyntheticVipCensus.fromJson(value.data));
  }

  ///
  ///
  static Future<FeeDataResult<SyntheticVipCensus>> vipCensusV1({
    required String lottery,
    required String type,
  }) {
    return HttpRequest()
        .get('/slotto/app/$lottery/v1/chart/vip/$type')
        .then((value) => FeeDataResult.fromJson(
              json: value.data,
              dataHandle: (e) => SyntheticVipCensus.fromJson(e),
            ));
  }

  ///
  ///
  static Future<SyntheticItemCensus> itemCensus({
    required String lottery,
    required String type,
  }) {
    return HttpRequest()
        .get('/slotto/app/$lottery/chart/item/$type')
        .then((value) => SyntheticItemCensus.fromJson(value.data));
  }

  ///
  ///
  static Future<FeeDataResult<SyntheticItemCensus>> itemCensusV1({
    required String lottery,
    required String type,
  }) {
    return HttpRequest()
        .get('/slotto/app/$lottery/v1/chart/item/$type')
        .then((value) => FeeDataResult.fromJson(
              json: value.data,
              dataHandle: (e) => SyntheticItemCensus.fromJson(e),
            ));
  }
}
