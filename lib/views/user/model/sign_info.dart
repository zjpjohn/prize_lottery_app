import 'package:prize_lottery_app/base/model/enum_value.dart';

///
///签到信息
class SignInfo {
  ///每天签到积分
  late int ecoupon;

  ///连续签到达到门槛是的奖励积分
  late int scoupon;

  ///账户积分
  int acctCoupon = 0;

  ///连续签到门槛
  int throttle = 0;

  /// 连续签到天数
  int series = 0;

  ///累计签到总次数
  int times = 0;

  ///累计签到总积分
  int coupon = 0;

  ///当前账户积分
  int current = 0;

  ///今日是否签到
  int hasSigned = 0;

  ///上一次签到日期
  String? lastDate;

  ///前台连续签到天数
  int hasSeries = 0;

  ///积分兑换规则
  late ExchangeRule rule;

  SignInfo.fromJson(Map<String, dynamic> json) {
    ecoupon = json['ecoupon'];
    scoupon = json['scoupon'];
    acctCoupon = json['acctCoupon'];
    throttle = json['throttle'];
    series = json['series'];
    hasSeries = json['series'];
    times = json['times'];
    coupon = json['coupon'];
    current = json['current'];
    hasSigned = json['hasSigned'];
    lastDate = json['lastDate'];
    rule = ExchangeRule.fromJson(json['exchangeRule']);
  }
}

class SignResult extends SignInfo {
  ///
  late SignLog log;

  ///
  SignResult.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    log = SignLog.fromJson(json['log']);
  }
}

///
/// 签到日志
class SignLog {
  ///签到类型
  late EnumValue type;

  ///签到奖励
  late int award;

  ///签到时间
  late String signTime;

  SignLog.fromJson(Map<String, dynamic> json) {
    type = EnumValue.fromJson(json['type']);
    award = json['award'];
    signTime = json['signTime'];
  }
}

///
/// 积分兑换规则
class ExchangeRule {
  ///兑换比例
  late int ratio;

  ///兑换门槛
  late int throttle;

  ExchangeRule.fromJson(Map<String, dynamic> json) {
    ratio = json['ratio'];
    throttle = json['throttle'];
  }
}

class ExchangeResult {
  ///兑换消耗积分数量
  late int coupon;

  ///兑换获取金币数量
  late int surplus;

  ///账户剩余积分数量
  late int remain;

  ExchangeResult.fromJson(Map<String, dynamic> json) {
    coupon = json['coupon'];
    surplus = json['surplus'];
    remain = json['remain'];
  }
}
