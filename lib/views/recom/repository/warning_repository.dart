import 'package:prize_lottery_app/base/model/fee_data_result.dart';
import 'package:prize_lottery_app/utils/request.dart';
import 'package:prize_lottery_app/views/recom/model/n3_warn_recommend.dart';
import 'package:prize_lottery_app/views/recom/model/num3_layer_filter.dart';

///
///
///
class WarnRecommendRepository {
  ///
  /// 选三预警分析
  static Future<FeeDataResult<Num3ComWarn>> num3ComWarn(
      {required String type, String? period}) {
    return HttpRequest().post('/slotto/app/num3/warn', params: {
      'type': type,
      'period': period
    }).then((value) => FeeDataResult.fromJson(
          json: value.data,
          dataHandle: (e) => Num3ComWarn.fromJson(e),
        ));
  }

  ///
  /// 选三预警期号集合
  static Future<List<String>> num3WarnPeriod(String type) {
    return HttpRequest().get('/slotto/app/num3/warn/periods', params: {
      'type': type
    }).then((value) => (value.data as List).cast<String>());
  }

  ///
  /// 选三分层预警期号集合
  static Future<List<String>> num3LayerPeriods(String type) {
    return HttpRequest().get('/slotto/app/num3/layer/periods', params: {
      'type': type
    }).then((value) => (value.data as List).cast<String>());
  }

  ///
  /// 福彩3D预警分析
  static Future<FeeDataResult<N3WarnRecommend>> fc3dWarnRecommend(
      {String? period}) {
    return HttpRequest().post('/slotto/app/fsd/warn', params: {
      'period': period
    }).then((value) => FeeDataResult.fromJson(
          json: value.data,
          dataHandle: (e) => N3WarnRecommend.fromJson(e),
        ));
  }

  ///
  /// 选三分层预警分析
  static Future<FeeDataResult<Num3Layer>> num3Layer(
      {required String type, String? period}) {
    return HttpRequest().post('/slotto/app/num3/layer', params: {
      'type': type,
      'period': period
    }).then((value) => FeeDataResult.fromJson(
          json: value.data,
          dataHandle: (e) => Num3Layer.fromJson(e),
        ));
  }

  ///
  /// 查询选三预警分析状态
  static Future<Num3LayerState> num3LayerState(String type) {
    return HttpRequest()
        .get('/slotto/share/lotto/num3/layer/state', params: {'type': type})
        .then((value) => Num3LayerState.fromJson(value.data))
        .catchError((_) => Num3LayerState.empty(type));
  }

  ///
  /// 查询福彩3D预警推荐期号集合
  static Future<List<String>> fc3dPeriods() {
    return HttpRequest()
        .get('/slotto/app/fsd/warn/periods')
        .then((value) => (value.data as List).cast<String>());
  }

  ///
  /// 排列三预警分析
  static Future<FeeDataResult<N3WarnRecommend>> pl3WarnRecommend(
      {String? period}) {
    return HttpRequest().post('/slotto/app/pls/warn', params: {
      'period': period
    }).then((value) => FeeDataResult.fromJson(
          json: value.data,
          dataHandle: (e) => N3WarnRecommend.fromJson(e),
        ));
  }

  ///
  /// 查询排列三预警推荐期号集合
  static Future<List<String>> pl3Periods() {
    return HttpRequest()
        .get('/slotto/app/pls/warn/periods')
        .then((value) => (value.data as List).cast<String>());
  }
}
