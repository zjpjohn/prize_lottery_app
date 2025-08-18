import 'package:prize_lottery_app/base/model/page_result.dart';
import 'package:prize_lottery_app/utils/request.dart';
import 'package:prize_lottery_app/views/rank/model/dlt_master_rank.dart';
import 'package:prize_lottery_app/views/rank/model/fc3d_master_rank.dart';
import 'package:prize_lottery_app/views/rank/model/pl3_master_rank.dart';
import 'package:prize_lottery_app/views/rank/model/qlc_master_rank.dart';
import 'package:prize_lottery_app/views/rank/model/ssq_master_rank.dart';

///
///
class MasterRankRepository {
  ///
  ///
  static Future<PageResult<Fc3dMasterRank>> fc3dMasterRanks({
    required String type,
    int? vip,
    int page = 1,
    int limit = 10,
  }) {
    return HttpRequest().get('/slotto/app/fsd/rank', params: {
      'type': type,
      'vip': vip,
      'page': page,
      'limit': limit,
    }).then(
      (value) => PageResult.fromJson(
        json: value.data,
        handle: (e) => Fc3dMasterRank.fromJson(e),
      ),
    );
  }

  ///
  ///
  static Future<PageResult<Fc3dMasterMulRank>> mulFc3dMasterRanks(
      {int page = 1, int limit = 10}) {
    return HttpRequest().get('/slotto/app/fsd/mul/rank', params: {
      'page': page,
      'limit': limit,
    }).then(
      (value) => PageResult.fromJson(
        json: value.data,
        handle: (e) => Fc3dMasterMulRank.fromJson(e),
      ),
    );
  }

  ///
  ///
  static Future<PageResult<Pl3MasterRank>> pl3MasterRanks({
    required String type,
    int? vip,
    int page = 1,
    int limit = 10,
  }) {
    return HttpRequest().get('/slotto/app/pls/rank', params: {
      'type': type,
      'vip': vip,
      'page': page,
      'limit': limit,
    }).then(
      (value) => PageResult.fromJson(
        json: value.data,
        handle: (e) => Pl3MasterRank.fromJson(e),
      ),
    );
  }

  ///
  ///
  static Future<PageResult<Pl3MasterMulRank>> mulPl3MasterRanks(
      {int page = 1, int limit = 10}) {
    return HttpRequest().get('/slotto/app/pls/mul/rank', params: {
      'page': page,
      'limit': limit,
    }).then(
      (value) => PageResult.fromJson(
        json: value.data,
        handle: (e) => Pl3MasterMulRank.fromJson(e),
      ),
    );
  }

  ///
  ///
  static Future<PageResult<SsqMasterRank>> ssqMasterRanks({
    required String type,
    int? vip,
    int page = 1,
    int limit = 10,
  }) {
    return HttpRequest().get('/slotto/app/ssq/rank', params: {
      'type': type,
      'vip': vip,
      'page': page,
      'limit': limit,
    }).then(
      (value) => PageResult.fromJson(
        json: value.data,
        handle: (e) => SsqMasterRank.fromJson(e),
      ),
    );
  }

  ///
  ///
  static Future<PageResult<SsqMasterMulRank>> mulSsqMasterRanks(
      {int type = 0, int page = 1, int limit = 10}) {
    return HttpRequest().get('/slotto/app/ssq/mul/rank', params: {
      'type': type,
      'page': page,
      'limit': limit,
    }).then(
      (value) => PageResult.fromJson(
        json: value.data,
        handle: (e) => SsqMasterMulRank.fromJson(e),
      ),
    );
  }

  ///
  ///
  static Future<PageResult<DltMasterRank>> dltMasterRanks({
    required String type,
    int? vip,
    int page = 1,
    int limit = 10,
  }) {
    return HttpRequest().get('/slotto/app/dlt/rank', params: {
      'type': type,
      'vip': vip,
      'page': page,
      'limit': limit,
    }).then(
      (value) => PageResult.fromJson(
        json: value.data,
        handle: (e) => DltMasterRank.fromJson(e),
      ),
    );
  }

  ///
  ///
  static Future<PageResult<DltMasterMulRank>> mulDltMasterRanks(
      {int type = 0, int page = 1, int limit = 10}) {
    return HttpRequest().get('/slotto/app/dlt/mul/rank', params: {
      'type': type,
      'page': page,
      'limit': limit,
    }).then(
      (value) => PageResult.fromJson(
        json: value.data,
        handle: (e) => DltMasterMulRank.fromJson(e),
      ),
    );
  }

  ///
  ///
  static Future<PageResult<QlcMasterRank>> qlcMasterRanks({
    required String type,
    int? vip,
    int page = 1,
    int limit = 10,
  }) {
    return HttpRequest().get('/slotto/app/qlc/rank', params: {
      'type': type,
      'vip': vip,
      'page': page,
      'limit': limit,
    }).then(
      (value) => PageResult.fromJson(
        json: value.data,
        handle: (e) => QlcMasterRank.fromJson(e),
      ),
    );
  }

  ///
  ///
  static Future<PageResult<QlcMasterMulRank>> mulQlcMasterRanks(
      {int page = 1, int limit = 10}) {
    return HttpRequest().get('/slotto/app/qlc/mul/rank', params: {
      'page': page,
      'limit': limit,
    }).then(
      (value) => PageResult.fromJson(
        json: value.data,
        handle: (e) => QlcMasterMulRank.fromJson(e),
      ),
    );
  }
}
