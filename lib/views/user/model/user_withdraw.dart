import 'package:prize_lottery_app/base/model/enum_value.dart';

///
/// 提现记录
class WithdrawRecord {
  ///
  /// 提现业务编号
  late String bizNo;

  /// 提现订单编号
  late String transNo;

  /// 提现渠道
  late EnumValue channel;

  /// 提现状态
  late EnumValue state;

  /// 备注消息
  late String message;

  /// 提现人民币金额
  late int money;

  /// 提现金币金额
  late int withdraw;

  /// 提现创建时间
  late String gmtCreate;

  WithdrawRecord.fromJson(Map<String, dynamic> json) {
    bizNo = json['bizNo'];
    transNo = json['transNo'] ?? '';
    channel = EnumValue.fromJson(json['channel']);
    state = EnumValue.fromJson(json['state']);
    message = json['message'] ?? '';
    money = int.parse(json['money']);
    withdraw = int.parse(json['withdraw']);
    gmtCreate = json['gmtCreate'];
  }
}
