import 'package:prize_lottery_app/utils/request.dart';
import 'package:prize_lottery_app/views/wens/model/wens_filter.dart';

///
///
class WenFilterRepository {
  ///
  ///
  static Future<Num3Lottery> num3Lottery(
      {required String type, String? period}) {
    return HttpRequest().get(
      '/slotto/share/lotto/num3/lottery',
      params: {'type': type, 'period': period},
    ).then((e) => Num3Lottery.fromJson(e.data));
  }

  ///
  ///
  static Future<List<String>> lotteryPeriods(
      {required String type, int limit = 30}) {
    return HttpRequest().get(
      '/slotto/share/lotto/periods',
      params: {'type': type, 'limit': limit},
    ).then((e) => (e.data as List).cast<String>());
  }

  ///
  /// 获取系统胆码
  static Future<Num3LottoDan> num3LottoDan(
      {required String type, String? period}) {
    return HttpRequest().get(
      '/slotto/share/lotto/num3/dan',
      params: {'type': type, 'period': period},
    ).then((e) => Num3LottoDan.fromJson(e.data));
  }
}
