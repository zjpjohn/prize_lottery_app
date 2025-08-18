import 'package:prize_lottery_app/utils/request.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_index.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_pick.dart';

///
///
///
class LotteryIndexRepository {
  ///
  ///
  static Future<void> lottoN3Pick(
      {required String lottery,
      required String period,
      required List<List<String>> balls}) {
    return HttpRequest().postJson('/slotto/app/intellect/pick?type=n3', data: {
      'lottery': lottery,
      'period': period,
      'balls': balls,
    }).then((value) => null);
  }

  ///
  ///
  static Future<void> lottoPick({
    required String lottery,
    required String period,
    required List<String> reds,
    required List<String> blues,
  }) {
    return HttpRequest().postJson('/slotto/app/intellect/pick?type=rb', data: {
      'lottery': lottery,
      'period': period,
      'reds': reds,
      'blues': blues,
    }).then((value) => null);
  }

  ///
  ///
  static Future<LotteryPick?> lotteryPick(
      {required String lottery, String? period}) {
    return HttpRequest().get('/slotto/app/intellect/pick', params: {
      'lottery': lottery,
      'period': period,
    }).then((value) {
      if (value.data == null) {
        return null;
      }
      return LotteryPick.fromJson(value.data);
    });
  }

  ///
  ///
  static Future<List<String>> indexPeriods(String type) {
    return HttpRequest().get(
      '/slotto/app/intellect/index/periods',
      params: {'type': type},
    ).then((value) => value.data.cast<String>());
  }

  ///
  ///
  static Future<LotteryIndex> lotteryIndex(
      {required String type, String? period}) {
    return HttpRequest().post(
      '/slotto/app/intellect/index',
      params: {
        'lottery': type,
        'period': period,
      },
    ).then((value) => LotteryIndex.fromJson(value.data));
  }

  ///
  ///
  static Future<Num3LottoIndex> num3Index(
      {required String type, String? period}) {
    return HttpRequest().post('/slotto/app/intellect/num3/index', params: {
      'lottery': type,
      'period': period,
    }).then((value) => Num3LottoIndex.fromJson(value.data));
  }

  ///
  ///
  static Future<List<String>> num3IndexPeriods(String type) {
    return HttpRequest().get(
      '/slotto/app/intellect/num3/index/periods',
      params: {'type': type},
    ).then((value) => value.data.cast<String>());
  }
}
