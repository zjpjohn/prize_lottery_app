import 'package:prize_lottery_app/base/model/master_value.dart';
import 'package:prize_lottery_app/base/model/page_result.dart';
import 'package:prize_lottery_app/utils/request.dart';
import 'package:prize_lottery_app/views/master/model/dlt_master.dart';
import 'package:prize_lottery_app/views/master/model/fc3d_master.dart';
import 'package:prize_lottery_app/views/master/model/focus_master.dart';
import 'package:prize_lottery_app/views/master/model/home_master.dart';
import 'package:prize_lottery_app/views/master/model/master_detail.dart';
import 'package:prize_lottery_app/views/master/model/master_schema.dart';
import 'package:prize_lottery_app/views/master/model/pl3_master.dart';
import 'package:prize_lottery_app/views/master/model/qlc_master.dart';
import 'package:prize_lottery_app/views/master/model/random_master.dart';
import 'package:prize_lottery_app/views/master/model/recommend_master.dart';
import 'package:prize_lottery_app/views/master/model/renew_master.dart';
import 'package:prize_lottery_app/views/master/model/ssq_master.dart';
import 'package:prize_lottery_app/views/rank/model/dlt_master_rank.dart';
import 'package:prize_lottery_app/views/rank/model/fc3d_master_rank.dart';
import 'package:prize_lottery_app/views/rank/model/pl3_master_rank.dart';
import 'package:prize_lottery_app/views/rank/model/qlc_master_rank.dart';
import 'package:prize_lottery_app/views/rank/model/ssq_master_rank.dart';

///
///
class LottoMasterRepository {
  ///
  /// 首页专家分类
  static Future<Map<String, List<HomeMaster>>> homeMasters(String type) {
    return HttpRequest().get('/slotto/app/$type/master/homed').then((value) {
      Map<String, List> data = Map<String, List>.from(value.data);
      return data.map((key, value) {
        List<HomeMaster> masters =
            value.map((e) => HomeMaster.fromJson(e)).toList();
        return MapEntry(key, masters);
      });
    });
  }

  static Future<List<RandomMaster>> fc3dRandomRecommends() {
    return HttpRequest().get('/slotto/app/fsd/random/masters').then((value) {
      List results = value.data;
      return results.map((e) => RandomMaster.fromFsd(e)).toList();
    });
  }

  static Future<List<Fc3dMasterMulRank>> fc3dRandomMasters() {
    return HttpRequest().get('/slotto/app/fsd/random/masters').then((value) {
      List results = value.data;
      return results.map((e) => Fc3dMasterMulRank.fromJson(e)).toList();
    });
  }

  ///
  /// 查询福彩3D专家详细信息
  static Future<Fc3dMasterDetail> fc3dMasterDetail(String masterId) {
    return HttpRequest()
        .get('/slotto/app/fsd/master/$masterId')
        .then((value) => Fc3dMasterDetail.fromJson(value.data));
  }

  ///
  /// 福彩3D专家方案推荐
  static Future<List<Fc3dSchema>> fc3dSchemaMasters() {
    return HttpRequest().get('/slotto/app/fsd/schema/masters').then((value) {
      List result = value.data;
      return result.map((e) => Fc3dSchema.fromJson(e)).toList();
    });
  }

  ///
  /// 福彩3D任意一个方案更新的专家信息
  static Future<List<RenewMaster>> fc3dRenewMaster() {
    return HttpRequest().get('/slotto/app/fsd/renew/masters').then((value) {
      List<RenewMaster> masters =
          List.of(value.data).map((e) => RenewMaster.fromJson(e)).toList();
      return masters;
    });
  }

  ///
  /// 排列三随机推荐
  static Future<List<RandomMaster>> pl3RandomRecommends() {
    return HttpRequest().get('/slotto/app/pls/random/masters').then((value) {
      List results = value.data;
      return results.map((e) => RandomMaster.fromPl3(e)).toList();
    });
  }

  ///
  /// 排列三专家随机推荐
  static Future<List<Pl3MasterMulRank>> pl3RandomMasters() {
    return HttpRequest().get('/slotto/app/pls/random/masters').then((value) {
      List results = value.data;
      return results.map((e) => Pl3MasterMulRank.fromJson(e)).toList();
    });
  }

  ///
  /// 查询排列三专家详细信息
  static Future<Pl3MasterDetail> pl3MasterDetail(String masterId) {
    return HttpRequest()
        .get('/slotto/app/pls/master/$masterId')
        .then((value) => Pl3MasterDetail.fromJson(value.data));
  }

  ///
  /// 排列三专家方案推荐
  static Future<List<Pl3Schema>> pl3SchemaMasters() {
    return HttpRequest().get('/slotto/app/pls/schema/masters').then((value) {
      List result = value.data;
      return result.map((e) => Pl3Schema.fromJson(e)).toList();
    });
  }

  ///
  /// 排列三任意一个方案更新的专家信息
  static Future<List<RenewMaster>> pl3RenewMaster() {
    return HttpRequest().get('/slotto/app/pls/renew/masters').then((value) {
      List<RenewMaster> masters =
          List.of(value.data).map((e) => RenewMaster.fromJson(e)).toList();
      return masters;
    });
  }

  ///
  /// 双色球随机推荐专家
  static Future<List<RandomMaster>> ssqRandomRecommends() {
    return HttpRequest().get('/slotto/app/ssq/random/masters').then((value) {
      List results = value.data;
      return results.map((e) => RandomMaster.fromSsq(e)).toList();
    });
  }

  static Future<List<SsqMasterMulRank>> ssqRandomMasters() {
    return HttpRequest().get('/slotto/app/ssq/random/masters').then((value) {
      List results = value.data;
      return results.map((e) => SsqMasterMulRank.fromJson(e)).toList();
    });
  }

  ///
  ///查询双色球专家详情
  static Future<SsqMasterDetail> ssqMasterDetail(String masterId) {
    return HttpRequest()
        .get('/slotto/app/ssq/master/$masterId')
        .then((value) => SsqMasterDetail.fromJson(value.data));
  }

  ///
  /// 双色球专家方案推荐
  static Future<List<SsqSchema>> ssqSchemaMasters() {
    return HttpRequest().get('/slotto/app/ssq/schema/masters').then((value) {
      List result = value.data;
      return result.map((e) => SsqSchema.fromJson(e)).toList();
    });
  }

  ///
  /// 双色球任意一个方案更新的专家信息
  static Future<List<RenewMaster>> ssqRenewMaster() {
    return HttpRequest().get('/slotto/app/ssq/renew/masters').then((value) {
      return List.of(value.data).map((e) => RenewMaster.fromJson(e)).toList();
    });
  }

  ///
  /// 大乐透随机推荐专家
  static Future<List<RandomMaster>> dltRandomRecommends() {
    return HttpRequest().get('/slotto/app/dlt/random/masters').then((value) {
      List results = value.data;
      return results.map((e) => RandomMaster.fromDlt(e)).toList();
    });
  }

  static Future<List<DltMasterMulRank>> dltRandomMasters() {
    return HttpRequest().get('/slotto/app/dlt/random/masters').then((value) {
      List results = value.data;
      return results.map((e) => DltMasterMulRank.fromJson(e)).toList();
    });
  }

  ///
  /// 查询大乐透专家详情
  static Future<DltMasterDetail> dltMasterDetail(String masterId) {
    return HttpRequest()
        .get('/slotto/app/dlt/master/$masterId')
        .then((value) => DltMasterDetail.fromJson(value.data));
  }

  ///
  /// 大乐透专家方案推荐
  static Future<List<DltSchema>> dltSchemaMasters() {
    return HttpRequest().get('/slotto/app/dlt/schema/masters').then((value) {
      List result = value.data;
      return result.map((e) => DltSchema.fromJson(e)).toList();
    });
  }

  ///
  /// 大乐透任意一个方案更新的专家信息
  static Future<List<RenewMaster>> dltRenewMaster() {
    return HttpRequest().get('/slotto/app/dlt/renew/masters').then((value) {
      return List.of(value.data).map((e) => RenewMaster.fromJson(e)).toList();
    });
  }

  ///
  /// 七乐彩随机推荐专家
  static Future<List<RandomMaster>> qlcRandomRecommends() {
    return HttpRequest().get('/slotto/app/qlc/random/masters').then((value) {
      List results = value.data;
      return results.map((e) => RandomMaster.fromQlc(e)).toList();
    });
  }

  static Future<List<QlcMasterMulRank>> qlcRandomMasters() {
    return HttpRequest().get('/slotto/app/qlc/random/masters').then((value) {
      List results = value.data;
      return results.map((e) => QlcMasterMulRank.fromJson(e)).toList();
    });
  }

  ///
  /// 查询七乐彩专家详情
  static Future<QlcMasterDetail> qlcMasterDetail(String masterId) {
    return HttpRequest()
        .get('/slotto/app/qlc/master/$masterId')
        .then((value) => QlcMasterDetail.fromJson(value.data));
  }

  ///
  /// 七乐彩专家方案推荐
  static Future<List<QlcSchema>> qlcSchemaMasters() {
    return HttpRequest().get('/slotto/app/qlc/schema/masters').then((value) {
      List result = value.data;
      return result.map((e) => QlcSchema.fromJson(e)).toList();
    });
  }

  ///
  /// 七乐彩任意一个方案更新的专家信息
  static Future<List<RenewMaster>> qlcRenewMaster() {
    return HttpRequest().get('/slotto/app/qlc/renew/masters').then((value) {
      return List.of(value.data).map((e) => RenewMaster.fromJson(e)).toList();
    });
  }

  ///
  /// 专家推荐
  static Future<List<RecommendMaster>> recommendMasters() {
    return HttpRequest()
        .get('/slotto/app/master/follow/recommend')
        .then((value) {
      List list = value.data;
      return list.map((e) => RecommendMaster.fromJson(e)).toList();
    });
  }

  ///
  /// 查询订阅专家
  static Future<PageResult<SubscribeMaster>> subscribeMasters(
      {int page = 1, int limit = 10}) {
    return HttpRequest().get(
      '/slotto/app/master/follow/list',
      params: {'page': page, 'limit': limit},
    ).then(
      (value) => PageResult.fromJson(
        json: value.data,
        handle: (e) => SubscribeMaster.fromJson(e),
      ),
    );
  }

  ///
  /// 查询关注专家
  static Future<PageResult<MasterFocus>> focusMasters(
      {int page = 1, int limit = 10}) {
    return HttpRequest().get('/slotto/app/master/focus/list',
        params: {'page': page, 'limit': limit}).then(
      (value) => PageResult.fromJson(
        json: value.data,
        handle: (e) => MasterFocus.fromJson(e),
      ),
    );
  }

  ///
  ///关注专家
  static Future<void> focusMaster(String masterId) {
    return HttpRequest().post('/slotto/app/master/focus',
        data: {'masterId': masterId}).then((value) => null);
  }

  ///订阅专家
  static Future<void> followMaster(
      {required String masterId, required String type, String? trace}) {
    return HttpRequest().post(
      '/slotto/app/master/follow',
      data: {
        'masterId': masterId,
        'type': type,
        'trace': trace,
      },
    ).then((value) => null);
  }

  ///跟踪订阅专家预测字段
  static Future<void> traceMaster(
      {required String masterId, required String type, required String trace}) {
    return HttpRequest().put(
      '/slotto/app/master/follow/trace',
      data: {
        'masterId': masterId,
        'type': type,
        'trace': trace,
      },
    ).then((value) => null);
  }

  ///重点关注/取消重点关注已订阅专家
  static Future<void> specialOrCancelMaster(
      {required String masterId, required String type}) {
    return HttpRequest().put(
      '/slotto/app/master/follow/special',
      data: {
        'masterId': masterId,
        'type': type,
      },
    ).then((value) => null);
  }

  ///取消订阅专家
  static Future<void> unFollowMaster(
      {required String masterId, required String type}) {
    return HttpRequest().delete('/slotto/app/master/follow',
        params: {'masterId': masterId, 'type': type}).then((value) => null);
  }

  ///
  /// 一键批量关注专家
  static Future<void> batchFollow(List<Map<String, String>> masters) {
    return HttpRequest().postJson(
      '/slotto/app/master/follow/batch',
      data: {'masters': masters},
    ).then((value) => null);
  }

  ///
  /// 搜索专家
  static Future<List<MasterValue>> matchMasters(String name) {
    return HttpRequest().get(
      '/slotto/share/master/search',
      params: {'name': name},
    ).then((value) {
      List result = value.data;
      return result.map((e) => MasterValue.fromJson(e)).toList();
    });
  }

  ///
  /// 搜索专家详情
  static Future<MasterDetail> masterDetail(
      {required String masterId, int search = 0}) {
    return HttpRequest().get('/slotto/share/master/$masterId', params: {
      'search': search
    }).then((value) => MasterDetail.fromJson(value.data));
  }

  ///
  /// 热门专家集合
  static Future<List<MasterValue>> hotMasters() {
    return HttpRequest().get('/slotto/share/master/hot/list').then((value) {
      List result = value.data;
      return result.map((e) => MasterValue.fromJson(e)).toList();
    });
  }
}
