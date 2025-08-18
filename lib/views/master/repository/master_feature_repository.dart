import 'package:prize_lottery_app/utils/request.dart';
import 'package:prize_lottery_app/views/master/model/master_feature.dart';

///
///
///
class MasterFeatureRepository {
  ///
  ///
  static Future<Fc3dMasterRate> fc3dMasterRate(String masterId) {
    return HttpRequest().get(
      '/slotto/app/fsd/master/rate',
      params: {'masterId': masterId},
    ).then((value) => Fc3dMasterRate.fromJson(value.data));
  }

  ///
  ///
  static Future<List<Fc3dICaiHit>> fc3dMasterHits(String masterId) {
    return HttpRequest().get(
      '/slotto/app/fsd/hits',
      params: {'masterId': masterId},
    ).then((value) {
      List data = value.data;
      return data.map((e) => Fc3dICaiHit.fromJson(e)).toList();
    });
  }

  ///
  ///
  static Future<Pl3MasterRate> pl3MasterRate(String masterId) {
    return HttpRequest().get(
      '/slotto/app/pls/master/rate',
      params: {'masterId': masterId},
    ).then((value) => Pl3MasterRate.fromJson(value.data));
  }

  ///
  ///
  static Future<List<Pl3ICaiHit>> pl3MasterHits(String masterId) {
    return HttpRequest().get(
      '/slotto/app/pls/hits',
      params: {'masterId': masterId},
    ).then((value) {
      List data = value.data;
      return data.map((e) => Pl3ICaiHit.fromJson(e)).toList();
    });
  }

  ///
  ///
  static Future<SsqMasterRate> ssqMasterRate(String masterId) {
    return HttpRequest().get(
      '/slotto/app/ssq/master/rate',
      params: {'masterId': masterId},
    ).then((value) => SsqMasterRate.fromJson(value.data));
  }

  ///
  ///
  static Future<List<SsqICaiHit>> ssqMasterHits(String masterId) {
    return HttpRequest().get(
      '/slotto/app/ssq/hits',
      params: {'masterId': masterId},
    ).then((value) {
      List data = value.data;
      return data.map((e) => SsqICaiHit.fromJson(e)).toList();
    });
  }

  ///
  ///
  static Future<DltMasterRate> dltMasterRate(String masterId) {
    return HttpRequest().get(
      '/slotto/app/dlt/master/rate',
      params: {'masterId': masterId},
    ).then((value) => DltMasterRate.fromJson(value.data));
  }

  ///
  ///
  static Future<List<DltICaiHit>> dltMasterHits(String masterId) {
    return HttpRequest().get(
      '/slotto/app/dlt/hits',
      params: {'masterId': masterId},
    ).then((value) {
      List data = value.data;
      return data.map((e) => DltICaiHit.fromJson(e)).toList();
    });
  }

  ///
  ///
  static Future<QlcMasterRate> qlcMasterRate(String masterId) {
    return HttpRequest().get(
      '/slotto/app/qlc/master/rate',
      params: {'masterId': masterId},
    ).then((value) => QlcMasterRate.fromJson(value.data));
  }

  ///
  ///
  static Future<List<QlcICaiHit>> qlcMasterHits(String masterId) {
    return HttpRequest().get(
      '/slotto/app/qlc/hits',
      params: {'masterId': masterId},
    ).then((value) {
      List data = value.data;
      return data.map((e) => QlcICaiHit.fromJson(e)).toList();
    });
  }
}
