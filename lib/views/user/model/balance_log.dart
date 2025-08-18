import 'package:prize_lottery_app/base/model/enum_value.dart';

///
///
class BalanceLog {
  ///
  /// 日志流水号
  late String seq;

  ///奖励金变动
  late int balance;

  ///金币变动
  late int surplus;

  ///变动来源数据
  late int source;

  ///变动描述
  late String remark;

  ///变动方向
  late EnumValue direct;

  ///操作类型
  late EnumValue action;

  ///
  late String gmtCreate;

  BalanceLog.fromJson(Map<String, dynamic> json) {
    seq = json['seq'];
    balance = json['balance'] ?? 0;
    surplus = json['surplus'] ?? 0;
    source = json['source'] ?? 0;
    remark = json['remark'] ?? '';
    gmtCreate = json['gmtCreate'];
    direct = EnumValue.fromJson(json['direct']);
    action = EnumValue.fromJson(json['action']);
  }
}
