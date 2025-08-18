import 'package:prize_lottery_app/base/model/page_result.dart';
import 'package:prize_lottery_app/utils/request.dart';
import 'package:prize_lottery_app/views/battle/model/master_battle.dart';
import 'package:prize_lottery_app/views/forecast/model/dlt_forecast_info.dart';
import 'package:prize_lottery_app/views/forecast/model/fc3d_forecast_info.dart';
import 'package:prize_lottery_app/views/forecast/model/pl3_forecast_info.dart';
import 'package:prize_lottery_app/views/forecast/model/qlc_forecast_info.dart';
import 'package:prize_lottery_app/views/forecast/model/ssq_forecast_info.dart';
import 'package:prize_lottery_app/views/rank/model/dlt_master_rank.dart';
import 'package:prize_lottery_app/views/rank/model/fc3d_master_rank.dart';
import 'package:prize_lottery_app/views/rank/model/pl3_master_rank.dart';
import 'package:prize_lottery_app/views/rank/model/qlc_master_rank.dart';
import 'package:prize_lottery_app/views/rank/model/ssq_master_rank.dart';

///
///
///
class MasterBattleRepository {
  ///
  ///
  /// 删除对战列表的专家
  static Future<void> removeBattle(int id) {
    return HttpRequest()
        .delete('/slotto/app/master/battle/$id')
        .then((value) => null);
  }

  ///=============================福彩3D==============================
  ///
  /// 加入对战列表
  static Future<MasterBattle<Fc3dForecastInfo>> addFc3dBattle(String masterId) {
    return HttpRequest().post(
      '/slotto/app/fsd/battle',
      params: {'masterId': masterId},
    ).then((value) => MasterBattle.fromJson(
          value.data,
          convert: (e) => Fc3dForecastInfo.fromJson(e)..calcValue(),
        ));
  }

  ///
  /// 查询对战列表
  static Future<List<MasterBattle<Fc3dForecastInfo>>> fc3dBattles() {
    return HttpRequest().get('/slotto/app/fsd/battles').then((value) {
      List data = value.data;
      if (data.isEmpty) {
        return [];
      }
      return data
          .map((e) => MasterBattle.fromJson(
                e,
                convert: (f) => Fc3dForecastInfo.fromJson(f)..calcValue(),
              ))
          .toList();
    });
  }

  ///
  /// 对战专家分页查询
  static Future<PageResult<MasterBattleRank<Fc3dMasterMulRank>>>
      fc3dBattleRanks({int page = 1, int limit = 10}) {
    return HttpRequest().get('/slotto/app/fsd/battle/ranks', params: {
      'page': page,
      'limit': limit
    }).then((value) => PageResult.fromJson(
          json: value.data,
          handle: (e) => MasterBattleRank.fromJson(
            e,
            convert: (rank) => Fc3dMasterMulRank.fromJson(rank),
          ),
        ));
  }

  ///===========================排列三=============================
  ///
  /// 添加到对战列表
  static Future<MasterBattle<Pl3ForecastInfo>> addPl3Battle(String masterId) {
    return HttpRequest().post('/slotto/app/pls/battle', params: {
      'masterId': masterId
    }).then((value) => MasterBattle.fromJson(
          value.data,
          convert: (e) => Pl3ForecastInfo.fromJson(e)..calcValue(),
        ));
  }

  ///
  /// 查询对战列表
  static Future<List<MasterBattle<Pl3ForecastInfo>>> pl3Battles() {
    return HttpRequest().get('/slotto/app/pls/battles').then((value) {
      List data = value.data;
      if (data.isEmpty) {
        return [];
      }
      return data
          .map((e) => MasterBattle.fromJson(
                e,
                convert: (f) => Pl3ForecastInfo.fromJson(f)..calcValue(),
              ))
          .toList();
    });
  }

  ///
  /// 对战专家分页查询
  static Future<PageResult<MasterBattleRank<Pl3MasterMulRank>>> pl3BattleRanks(
      {int page = 1, int limit = 10}) {
    return HttpRequest().get('/slotto/app/pls/battle/ranks', params: {
      'page': page,
      'limit': limit
    }).then((value) => PageResult.fromJson(
          json: value.data,
          handle: (e) => MasterBattleRank.fromJson(
            e,
            convert: (rank) => Pl3MasterMulRank.fromJson(rank),
          ),
        ));
  }

  ///===========================双色球=============================
  ///
  /// 添加到对战列表
  static Future<MasterBattle<SsqForecastInfo>> addSsqBattle(String masterId) {
    return HttpRequest().post('/slotto/app/ssq/battle', params: {
      'masterId': masterId
    }).then((value) => MasterBattle.fromJson(
          value.data,
          convert: (e) => SsqForecastInfo.fromJson(e)..calcValue(),
        ));
  }

  ///
  /// 查询对战列表
  static Future<List<MasterBattle<SsqForecastInfo>>> ssqBattles() {
    return HttpRequest().get('/slotto/app/ssq/battles').then((value) {
      List data = value.data;
      if (data.isEmpty) {
        return [];
      }
      return data
          .map((e) => MasterBattle.fromJson(
                e,
                convert: (f) => SsqForecastInfo.fromJson(f)..calcValue(),
              ))
          .toList();
    });
  }

  ///
  /// 对战专家分页查询
  static Future<PageResult<MasterBattleRank<SsqMasterMulRank>>> ssqBattleRanks(
      {int page = 1, int limit = 10}) {
    return HttpRequest().get('/slotto/app/ssq/battle/ranks', params: {
      'page': page,
      'limit': limit
    }).then((value) => PageResult.fromJson(
          json: value.data,
          handle: (e) => MasterBattleRank.fromJson(
            e,
            convert: (rank) => SsqMasterMulRank.fromJson(rank),
          ),
        ));
  }

  ///===========================大乐透=============================
  ///
  /// 添加到对战列表
  static Future<MasterBattle<DltForecastInfo>> addDltBattle(String masterId) {
    return HttpRequest().post('/slotto/app/dlt/battle', params: {
      'masterId': masterId
    }).then((value) => MasterBattle.fromJson(
          value.data,
          convert: (e) => DltForecastInfo.fromJson(e)..calcValue(),
        ));
  }

  ///
  /// 查询对战列表
  static Future<List<MasterBattle<DltForecastInfo>>> dltBattles() {
    return HttpRequest().get('/slotto/app/dlt/battles').then((value) {
      List data = value.data;
      if (data.isEmpty) {
        return [];
      }
      return data
          .map((e) => MasterBattle.fromJson(
                e,
                convert: (f) => DltForecastInfo.fromJson(f)..calcValue(),
              ))
          .toList();
    });
  }

  ///
  /// 对战专家分页查询
  static Future<PageResult<MasterBattleRank<DltMasterMulRank>>> dltBattleRanks(
      {int page = 1, int limit = 10}) {
    return HttpRequest().get('/slotto/app/dlt/battle/ranks', params: {
      'page': page,
      'limit': limit
    }).then((value) => PageResult.fromJson(
          json: value.data,
          handle: (e) => MasterBattleRank.fromJson(
            e,
            convert: (rank) => DltMasterMulRank.fromJson(rank),
          ),
        ));
  }

  ///===========================七乐彩=============================
  ///
  /// 添加到对战列表
  static Future<MasterBattle<QlcForecastInfo>> addQlcBattle(String masterId) {
    return HttpRequest().post('/slotto/app/qlc/battle', params: {
      'masterId': masterId
    }).then((value) => MasterBattle.fromJson(
          value.data,
          convert: (e) => QlcForecastInfo.fromJson(e)..calcValue(),
        ));
  }

  ///
  /// 查询对战列表
  static Future<List<MasterBattle<QlcForecastInfo>>> qlcBattles() {
    return HttpRequest().get('/slotto/app/qlc/battles').then((value) {
      List data = value.data;
      if (data.isEmpty) {
        return [];
      }
      return data
          .map((e) => MasterBattle.fromJson(
                e,
                convert: (f) => QlcForecastInfo.fromJson(f)..calcValue(),
              ))
          .toList();
    });
  }

  ///
  /// 对战专家分页查询
  static Future<PageResult<MasterBattleRank<QlcMasterMulRank>>> qlcBattleRanks(
      {int page = 1, int limit = 10}) {
    return HttpRequest().get('/slotto/app/qlc/battle/ranks', params: {
      'page': page,
      'limit': limit
    }).then((value) => PageResult.fromJson(
          json: value.data,
          handle: (e) => MasterBattleRank.fromJson(
            e,
            convert: (rank) => QlcMasterMulRank.fromJson(rank),
          ),
        ));
  }
}
