import 'package:prize_lottery_app/base/model/page_result.dart';
import 'package:prize_lottery_app/utils/request.dart';
import 'package:prize_lottery_app/views/user/model/user_voucher.dart';

///
///
///
class VoucherRepository {
  ///
  /// 用户代金券账户信息
  static Future<UserVoucher> userVoucher() {
    return HttpRequest()
        .get('/ucenter/app/voucher/')
        .then((value) => UserVoucher.fromJson(value.data));
  }

  ///
  /// 领取代金券
  static Future<DrawVoucher> drawVoucher(String seqNo) {
    return HttpRequest().post('/ucenter/app/voucher/draw', params: {
      'seqNo': seqNo
    }).then((value) => DrawVoucher.fromJson(value.data));
  }

  ///
  /// 批量领券代金券
  static Future<List<DrawVoucher>> drawBatch(List<String> seqNos) {
    return HttpRequest().postJson(
      '/ucenter/app/voucher/draw/batch',
      data: {'seqNos': seqNos},
    ).then((value) {
      List list = value.data;
      return list.map((e) => DrawVoucher.fromJson(e)).toList();
    });
  }

  ///
  /// 查询可领取代金券列表
  static Future<List<VoucherInfo>> voucherList() {
    return HttpRequest().get('/ucenter/app/voucher/list').then((value) {
      List list = value.data;
      return list.map((e) => VoucherInfo.fromJson(e)).toList();
    });
  }

  ///
  /// 最新用户领券记录
  static Future<List<UserDraw>> userDrawList() {
    return HttpRequest().get('/ucenter/app/voucher/latest').then((value) {
      List list = value.data;
      return list.map((e) => UserDraw.fromJson(e)).toList();
    });
  }

  ///
  /// 分页查询用户领取代金券记录
  static Future<PageResult<UserVoucherLog>> voucherRecords({
    int page = 1,
    int limit = 10,
    int? used,
    int? expired,
  }) {
    return HttpRequest().get('/ucenter/app/voucher/record/list', params: {
      'page': page,
      'limit': limit,
      'used': used,
      'expired': expired,
    }).then(
      (value) => PageResult.fromJson(
        json: value.data,
        handle: (e) => UserVoucherLog.fromJson(e),
      ),
    );
  }
}
