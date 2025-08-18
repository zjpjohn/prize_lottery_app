import 'package:prize_lottery_app/utils/request.dart';
import 'package:prize_lottery_app/views/forecast/model/dlt_forecast_info.dart';
import 'package:prize_lottery_app/views/forecast/model/fc3d_forecast_info.dart';
import 'package:prize_lottery_app/views/forecast/model/pl3_forecast_info.dart';
import 'package:prize_lottery_app/views/forecast/model/qlc_forecast_info.dart';
import 'package:prize_lottery_app/views/forecast/model/ssq_forecast_info.dart';
import 'package:prize_lottery_app/views/master/model/dlt_history.dart';
import 'package:prize_lottery_app/views/master/model/fc3d_history.dart';
import 'package:prize_lottery_app/views/master/model/pl3_history.dart';
import 'package:prize_lottery_app/views/master/model/qlc_history.dart';
import 'package:prize_lottery_app/views/master/model/ssq_history.dart';

///
///
class ForecastInfoRepository {
  ///
  /// 查询福彩3D预测详情
  static Future<Fc3dForecastInfo> fc3dForecast(String masterId) {
    return HttpRequest()
        .get('/slotto/app/fsd/forecast/$masterId')
        .then((value) => Fc3dForecastInfo.fromJson(value.data));
  }

  ///
  /// 查询福彩3D历史预测成绩
  static Future<List<Fc3dHistory>> fc3dHistories(String masterId) {
    return HttpRequest().get('/slotto/app/fsd/history/$masterId').then((value) {
      List data = value.data;
      return data.map((e) => Fc3dHistory.fromJson(e)).toList();
    });
  }

  ///
  /// 查询排列三预测详情
  static Future<Pl3ForecastInfo> pl3Forecast(String masterId) {
    return HttpRequest()
        .get('/slotto/app/pls/forecast/$masterId')
        .then((value) => Pl3ForecastInfo.fromJson(value.data));
  }

  ///
  /// 查询排列三历史预测成绩
  static Future<List<Pl3History>> pl3Histories(String masterId) {
    return HttpRequest().get('/slotto/app/pls/history/$masterId').then((value) {
      List data = value.data;
      return data.map((e) => Pl3History.fromJson(e)).toList();
    });
  }

  ///
  /// 查询双色球预测详情
  static Future<SsqForecastInfo> ssqForecast(String masterId) {
    return HttpRequest()
        .get('/slotto/app/ssq/forecast/$masterId')
        .then((value) => SsqForecastInfo.fromJson(value.data));
  }

  ///
  /// 查询双色球历史预测数据
  static Future<List<SsqHistory>> ssqHistories(String masterId) {
    return HttpRequest().get('/slotto/app/ssq/history/$masterId').then((value) {
      List data = value.data;
      return data.map((e) => SsqHistory.fromJson(e)).toList();
    });
  }

  ///
  /// 查询大乐透预测详情
  static Future<DltForecastInfo> dltForecast(String masterId) {
    return HttpRequest()
        .get('/slotto/app/dlt/forecast/$masterId')
        .then((value) => DltForecastInfo.fromJson(value.data));
  }

  ///
  /// 查询大乐透历史预测数据
  static Future<List<DltHistory>> dltHistories(String masterId) {
    return HttpRequest().get('/slotto/app/dlt/history/$masterId').then((value) {
      List data = value.data;
      return data.map((e) => DltHistory.fromJson(e)).toList();
    });
  }

  ///
  /// 查询七乐彩预测详情
  static Future<QlcForecastInfo> qlcForecast(String masterId) {
    return HttpRequest()
        .get('/slotto/app/qlc/forecast/$masterId')
        .then((value) => QlcForecastInfo.fromJson(value.data));
  }

  ///
  /// 查询七乐彩历史预测数据
  static Future<List<QlcHistory>> qlcHistories(String masterId) {
    return HttpRequest().get('/slotto/app/qlc/history/$masterId').then((value) {
      List data = value.data;
      return data.map((e) => QlcHistory.fromJson(e)).toList();
    });
  }
}
