import 'package:prize_lottery_app/base/model/forecast_expend.dart';

///
///
class FeeDataResult<T> {
  late String period;
  late bool feeRequired;
  T? data;
  ForecastExpend? expend;

  FeeDataResult.fromJson({
    required Map<String, dynamic> json,
    required T Function(Map<String, dynamic> value) dataHandle,
    T Function(String)? emptyHandle,
  }) {
    period = json['period'];
    feeRequired = json['feeRequired'];
    if (json['data'] != null) {
      data = dataHandle(json['data']);
    } else if (emptyHandle != null) {
      data = emptyHandle(period);
    }
    if (json['expend'] != null) {
      expend = ForecastExpend.fromJson(json['expend']);
    }
  }
}
