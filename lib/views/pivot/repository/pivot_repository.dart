import 'package:prize_lottery_app/base/model/fee_data_result.dart';
import 'package:prize_lottery_app/utils/request.dart';
import 'package:prize_lottery_app/views/pivot/model/pivot_info.dart';

///
/// 今日要点仓储
class PivotRepository {
  ///
  /// 查询指定期的今日要点信息
  static Future<FeeDataResult<TodayPivot>> todayPivot({
    required String type,
    String? period,
  }) {
    return HttpRequest().post('/slotto/app/$type/pivot', params: {
      'period': period
    }).then((value) => FeeDataResult.fromJson(
          json: value.data,
          dataHandle: (e) => TodayPivot.fromJson(e),
          emptyHandle: (period) => TodayPivot(period: period),
        ));
  }

  ///
  /// 查询今日要点最新20期的期号
  static Future<List<String>> pivotPeriods(String type) {
    return HttpRequest()
        .get('/slotto/app/$type/pivot/periods')
        .then((value) => (value.data as List).cast<String>());
  }
}
