import 'package:flutter_easyloading/flutter_easyloading.dart';

///
///
class UserBalance {
  ///
  late int balance;

  ///
  late int surplus;

  ///
  late int invite;

  ///
  late int coupon;

  ///
  late int voucher;

  ///
  late int withdraw;

  ///
  late int canWithdraw;

  ///
  late int withRmb;

  ///
  late String withLatest;

  UserBalance.fromJson(Map<String, dynamic> json) {
    balance = json['balance'] ?? 0;
    surplus = json['surplus'] ?? 0;
    invite = json['invite'] ?? 0;
    coupon = json['coupon'] ?? 0;
    voucher = json['voucher'] ?? 0;
    withdraw = json['withdraw'] ?? 0;
    canWithdraw = json['canWithdraw'] ?? 0;
    withRmb = json['withRmb'] ?? 0;
    withLatest = json['withLatest'] ?? '';
  }

  ///
  /// 是否可以兑换积分
  bool canExchange(int throttle) {
    return coupon >= throttle;
  }

  ///
  /// 提现操作
  void withdrawAction() {
    if (canWithdraw == 0) {
      EasyLoading.showToast('暂不支持提现');
      return;
    }
    if (balance <= 10) {
      EasyLoading.showToast('账户金额不足');
      return;
    }

    /// 跳转提现页面
  }
}
