import 'package:prize_lottery_app/base/model/page_result.dart';
import 'package:prize_lottery_app/utils/request.dart';
import 'package:prize_lottery_app/views/glad/model/dlt_master_glad.dart';
import 'package:prize_lottery_app/views/glad/model/fc3d_master_glad.dart';
import 'package:prize_lottery_app/views/glad/model/pl3_master_glad.dart';
import 'package:prize_lottery_app/views/glad/model/qlc_master_glad.dart';
import 'package:prize_lottery_app/views/glad/model/ssq_master_glad.dart';

///
///
class MasterGladRepository {
  ///
  ///
  static Future<PageResult<Fc3dMasterGlad>> fc3dGladList(
      {int page = 1, int limit = 10}) {
    return HttpRequest().get('/slotto/app/fsd/glad', params: {
      'page': page,
      'limit': limit,
    }).then(
      (value) => PageResult.fromJson(
        json: value.data,
        handle: (e) => Fc3dMasterGlad.fromJson(e),
      ),
    );
  }

  ///
  ///
  static Future<PageResult<Pl3MasterGlad>> pl3GladList(
      {int page = 1, int limit = 10}) {
    return HttpRequest().get('/slotto/app/pls/glad', params: {
      'page': page,
      'limit': limit,
    }).then(
      (value) => PageResult.fromJson(
        json: value.data,
        handle: (e) => Pl3MasterGlad.fromJson(e),
      ),
    );
  }

  ///
  ///
  static Future<PageResult<SsqMasterGlad>> ssqGladList(
      {int page = 1, int limit = 10}) {
    return HttpRequest().get('/slotto/app/ssq/glad', params: {
      'page': page,
      'limit': limit,
    }).then(
      (value) => PageResult.fromJson(
        json: value.data,
        handle: (e) => SsqMasterGlad.fromJson(e),
      ),
    );
  }

  ///
  ///
  static Future<PageResult<DltMasterGlad>> dltGladList(
      {int page = 1, int limit = 10}) {
    return HttpRequest().get('/slotto/app/dlt/glad', params: {
      'page': page,
      'limit': limit,
    }).then(
      (value) => PageResult.fromJson(
        json: value.data,
        handle: (e) => DltMasterGlad.fromJson(e),
      ),
    );
  }

  ///
  ///
  static Future<PageResult<QlcMasterGlad>> qlcGladList(
      {int page = 1, int limit = 10}) {
    return HttpRequest().get('/slotto/app/qlc/glad', params: {
      'page': page,
      'limit': limit,
    }).then(
      (value) => PageResult.fromJson(
        json: value.data,
        handle: (e) => QlcMasterGlad.fromJson(e),
      ),
    );
  }
}
