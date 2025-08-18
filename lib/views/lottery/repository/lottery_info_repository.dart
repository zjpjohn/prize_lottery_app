import 'package:prize_lottery_app/base/model/page_result.dart';
import 'package:prize_lottery_app/utils/diagrams_table.dart';
import 'package:prize_lottery_app/utils/hunt_table.dart';
import 'package:prize_lottery_app/utils/request.dart';
import 'package:prize_lottery_app/utils/wuxing_table.dart';
import 'package:prize_lottery_app/views/lottery/model/fast_table.dart';
import 'package:prize_lottery_app/views/lottery/model/kl8_omit_census.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_around.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_assistant.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_code.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_dan.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_detail.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_honey.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_info.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_omit.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_ott.dart';

///
///
class LotteryInfoRepository {
  ///
  /// 查询最新彩种的开奖信息
  static Future<LotteryInfo> latestLottery(String type) {
    return HttpRequest()
        .get('/slotto/share/lotto/newest/$type')
        .then((value) => LotteryInfo.fromJson(value.data));
  }

  ///
  /// 查询彩种的最新开奖期号
  static Future<String> latestPeriod(String type) {
    return HttpRequest()
        .get('/slotto/share/lotto/latest/period/$type')
        .then((value) => value.data);
  }

  ///
  /// 分组查询全部彩种的最新开奖信息
  static Future<List<LotteryInfo>> groupLatest() {
    return HttpRequest()
        .get('/slotto/share/lotto/newest/group/v1')
        .then((value) {
      List json = value.data;
      return json.map((e) => LotteryInfo.fromJson(e)).toList();
    });
  }

  ///
  /// 查询最新指定期的开奖数据
  static Future<List<LotteryInfo>> latestLotteries(
      {required String type, int limit = 2}) {
    return HttpRequest().get(
      '/slotto/share/lotto/latest/list',
      params: {'type': type, 'limit': limit},
    ).then((value) {
      List json = value.data;
      return json.map((e) => LotteryInfo.fromJson(e)).toList();
    });
  }

  ///
  /// 查询选指定期前三型彩票开奖数据，
  /// 不传period则最新的开奖数据
  static Future<List<LotteryInfo>> num3BeforeLotteries(
      {required String type, int limit = 3, String? period}) {
    return HttpRequest().get(
      '/slotto/share/lotto/num3/lotteries',
      params: {'type': type, 'limit': limit, 'period': period},
    ).then((value) {
      List json = value.data;
      return json.map((e) => LotteryInfo.fromJson(e)).toList();
    });
  }

  ///
  /// 查询30期选三型开奖期号
  static Future<List<String>> num3LotteryPeriods(String type) {
    return HttpRequest().get(
      '/slotto/share/lotto/num3/periods',
      params: {'type': type},
    ).then((value) => (value.data as List).cast<String>());
  }

  ///
  /// 查询50期开奖期号
  static Future<List<String>> lotteryPeriods(String type) {
    return HttpRequest().get(
      '/slotto/share/lotto/periods',
      params: {'type': type, 'limit': 100},
    ).then((value) => (value.data as List).cast<String>());
  }

  ///
  /// 查询最新的
  static Future<List<LotteryInfo>> typedLatest(List<String> types) {
    return HttpRequest()
        .postJson('/slotto/share/lotto/newest/types', data: types)
        .then((value) {
      List json = value.data;
      return json.map((e) => LotteryInfo.fromJson(e)).toList();
    });
  }

  ///
  /// 查询速查表
  static Future<FastTable> fastTable({required String type, String? period}) {
    return HttpRequest().get('/slotto/share/lotto/qtable', params: {
      'type': type,
      'period': period
    }).then((value) => FastTable.fromJson(value.data));
  }

  ///
  /// 查询五行表
  static Future<WuXing> wuXingTable({required String type, String? period}) {
    return HttpRequest().get('/slotto/share/lotto/qtable', params: {
      'type': type,
      'period': period
    }).then((value) => WuXing.fromJson(value.data));
  }

  ///
  /// 查询寻宝图
  static Future<HuntTable> huntTable({required String type, String? period}) {
    return HttpRequest().get('/slotto/share/lotto/qtable', params: {
      'type': type,
      'period': period
    }).then((value) => HuntTable.fromJson(value.data));
  }

  ///
  /// 查询寻宝图
  static Future<DiagramsTable> diagramTable(
      {required String type, String? period}) {
    return HttpRequest().get('/slotto/share/lotto/qtable', params: {
      'type': type,
      'period': period
    }).then((value) => DiagramsTable.fromJson(value.data));
  }

  ///
  /// 查询开奖信息详情
  static Future<LotteryDetail> lotteryDetail(
      {required String type, required String period}) {
    return HttpRequest()
        .get('/slotto/share/lotto/$type/$period')
        .then((value) => LotteryDetail.fromJson(value.data));
  }

  ///
  /// 分页查询历史开奖信息
  static Future<PageResult<LotteryInfo>> historyLotteries(
      Map<String, dynamic> params) {
    Map<String, dynamic> requestDto = {'noneNull': 1, ...params};
    return HttpRequest()
        .get('/slotto/share/lotto/list', params: requestDto)
        .then(
          (value) => PageResult.fromJson(
            json: value.data,
            handle: (v) => LotteryInfo.fromJson(v),
          ),
        );
  }

  ///
  /// 查询彩种的遗漏数据
  static Future<List<LotteryOmit>> lotteryOmits(String type, int? size) {
    return HttpRequest().get('/slotto/share/lotto/omit/$type',
        params: {'size': size}).then((value) {
      List result = value.data;
      return result.map((e) => LotteryOmit.fromJson(e)).toList();
    });
  }

  ///
  /// 查询排列五定位形态遗漏
  static Future<List<LotteryPl5Omit>> pl5Omits(int? size) {
    return HttpRequest().get('/slotto/share/lotto/omit/pl5',
        params: {'size': size}).then((value) {
      List result = value.data;
      return result.map((e) => LotteryPl5Omit.fromJson(e)).toList();
    });
  }

  ///
  /// 查询排列五分位遗漏查询
  static Future<List<CbItemOmit>> pl5ItemOmits({required int type, int? size}) {
    return HttpRequest().get('/slotto/share/lotto/omit/item/pl5',
        params: {'type': type, 'size': size}).then((value) {
      List result = value.data;
      return result.map((e) => CbItemOmit.fromJson(e)).toList();
    });
  }

  ///
  /// 查询跨度遗漏
  static Future<List<KuaOmit>> kuaOmits(String type, int? size) {
    return HttpRequest().get('/slotto/share/lotto/omit/kua/$type',
        params: {'size': size}).then((value) {
      List result = value.data;
      return result.map((e) => KuaOmit.fromJson(e)).toList();
    });
  }

  ///
  /// 查询跨度遗漏
  static Future<List<SumOmit>> sumOmits(String type, int? size) {
    return HttpRequest().get('/slotto/share/lotto/omit/sum/$type',
        params: {'size': size}).then((value) {
      List result = value.data;
      return result.map((e) => SumOmit.fromJson(e)).toList();
    });
  }

  ///
  /// 查询形态遗漏
  static Future<List<TrendOmit>> trendOmits(String type, int? size) {
    return HttpRequest().get('/slotto/share/lotto/omit/trend/$type',
        params: {'size': size}).then((value) {
      List result = value.data;
      return result.map((e) => TrendOmit.fromJson(e)).toList();
    });
  }

  ///
  /// 查询对码遗漏
  static Future<List<MatchOmit>> matchOmits(String type, int? size) {
    return HttpRequest().get('/slotto/share/lotto/omit/match/$type',
        params: {'size': size}).then((value) {
      List result = value.data;
      return result.map((e) => MatchOmit.fromJson(e)).toList();
    });
  }

  ///
  /// 查询定位形态遗漏
  static Future<List<LotteryItemOmit>> itemOmits(String type, int? size) {
    return HttpRequest().get('/slotto/share/lotto/omit/item/$type',
        params: {'size': size}).then((value) {
      List result = value.data;
      return result.map((e) => LotteryItemOmit.fromJson(e)).toList();
    });
  }

  ///
  /// 快乐8遗漏数据
  static Future<List<Kl8Omit>> kl8Omits() {
    return HttpRequest().get('/slotto/share/lotto/kl8/omit').then((value) {
      List result = value.data;
      return result.map((e) => Kl8Omit.fromJson(e)).toList();
    });
  }

  ///
  /// 快乐8基础遗漏数据
  static Future<PageResult<Kl8BaseOmit>> kl8BaseOmits(
      {int page = 1, int limit = 4}) {
    return HttpRequest().get(
      '/slotto/share/lotto/kl8/base/omit/list',
      params: {'page': page, 'limit': limit},
    ).then((value) => PageResult.fromJson(
          json: value.data,
          handle: (v) => Kl8BaseOmit.fromJson(v),
        ));
  }

  ///
  /// 查询指定类型的万能码
  static Future<List<LotteryCode>> codeList(
      {required String lotto, required int type}) {
    return HttpRequest().get('/slotto/share/lotto/code/list',
        params: {'lotto': lotto, 'type': type}).then((value) {
      List result = value.data;
      return result.map((e) => LotteryCode.fromJson(e)).toList();
    });
  }

  ///
  /// 查询指定类型的胆码推荐
  static Future<List<LotteryDan>> danList(String type) {
    return HttpRequest().get('/slotto/share/lotto/dan/list',
        params: {'type': type}).then((value) {
      List result = value.data;
      return result.map((e) => LotteryDan.fromJson(e)).toList();
    });
  }

  ///
  /// 查询指定类型的012路遗漏
  static Future<List<LotteryOtt>> ottList(String type, int? size) {
    return HttpRequest().get('/slotto/share/lotto/ott/list',
        params: {'type': type, 'size': size}).then((value) {
      List result = value.data;
      return result.map((e) => LotteryOtt.fromJson(e)).toList();
    });
  }

  ///
  /// 查询应用助手信息
  static Future<List<LotteryAssistant>> appAssistants({
    required String appNo,
    required String version,
    String? type,
    bool detail = false,
  }) {
    return HttpRequest().get('/lope/app/assistant/list', params: {
      'appNo': appNo,
      'version': version,
      'type': type,
      'detail': detail,
    }).then((value) {
      List result = value.data;
      return result.map((e) => LotteryAssistant.fromJson(e)).toList();
    });
  }

  ///
  /// 查询应用助手详情
  static Future<LotteryAssistant> assistant(
      {required int id, required String appNo}) {
    return HttpRequest().get('/lope/app/assistant/$id', params: {
      'appNo': appNo
    }).then((value) => LotteryAssistant.fromJson(value.data));
  }

  ///
  /// 查询绕胆图信息
  static Future<LotteryAround> lotteryAround(
      {required String type, String? period}) {
    return HttpRequest().get('/slotto/share/lotto/around', params: {
      'type': type,
      'period': period
    }).then((value) => LotteryAround.fromJson(value.data));
  }

  ///
  /// 查询绕胆图期号集合
  static Future<List<String>> aroundPeriods(String type) {
    return HttpRequest().get(
      '/slotto/share/lotto/around/periods',
      params: {'type': type},
    ).then((value) => value.data.cast<String>());
  }

  ///
  /// 查询配胆图信息
  static Future<LotteryHoney> lotteryHoney(
      {required String type, String? period}) {
    return HttpRequest().get('/slotto/share/lotto/honey', params: {
      'type': type,
      'period': period
    }).then((value) => LotteryHoney.fromJson(value.data));
  }

  ///
  /// 查询配胆图期号集合
  static Future<List<String>> honeyPeriods(String type) {
    return HttpRequest().get(
      '/slotto/share/lotto/honey/periods',
      params: {'type': type},
    ).then((value) => value.data.cast<String>());
  }

  ///
  /// 查询偏态遗漏数据
  static Future<List<PianOmit>> pianOmits(
      {required String type, int limit = 30}) {
    return HttpRequest().get('/slotto/share/lotto/num3/pian/omit',
        params: {'type': type, 'limit': limit}).then((value) {
      return (value.data as List).map((e) => PianOmit.fromJson(e)).toList();
    });
  }

  ///
  /// 查询试机号开奖期号
  static Future<List<String>> trialPeriods(String type) {
    return HttpRequest().get('/slotto/share/lotto/trial/periods',
        params: {'type': type}).then((value) => value.data.cast<String>());
  }

  ///
  /// 查询试机号三期开奖表
  static Future<TrialTable> trialTable({required String type, String? period}) {
    return HttpRequest().get('/slotto/share/lotto/trial/table', params: {
      'type': type,
      'period': period
    }).then((value) => TrialTable.fromJson(value.data));
  }

  ///
  /// 查询出号统计
  static Future<Map<int, List<String>>> num3ComCounts(
      {required String type, int limit = 365}) {
    return HttpRequest().get('/slotto/share/lotto/num3/com/counts',
        params: {'type': type, 'limit': limit}).then((value) {
      Map<String, dynamic> json = value.data;
      return json
          .map((k, v) => MapEntry(int.parse(k), (v as List).cast<String>()));
    });
  }

  ///
  /// 查询指定期的历史跟随号码
  static Future<List<Num3LottoFollow>> num3Follows(
      {required String type, String? period}) {
    return HttpRequest().get('/slotto/share/lotto/num3/follow/list',
        params: {'type': type, 'period': period}).then((value) {
      return (value.data as List)
          .map((e) => Num3LottoFollow.fromJson(e))
          .toList();
    });
  }

  ///
  /// 查询组选号码历史跟随号码
  static Future<List<Num3LottoFollow>> comFollows(
      {required String type, required String com}) {
    return HttpRequest().get('/slotto/share/lotto/num3/com/follow',
        params: {'type': type, 'com': com}).then((value) {
      return (value.data as List)
          .map((e) => Num3LottoFollow.fromJson(e))
          .toList();
    });
  }
}
