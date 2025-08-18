import 'package:prize_lottery_app/base/model/enum_value.dart';
import 'package:prize_lottery_app/utils/date_util.dart';

///
/// 流量主账户信息
///
class AgentAccount {
  late int userId;
  late EnumValue agent;
  late int withdraw;
  late int withRmb;
  late String withLatest;
  late int income;
  late int invites;
  late int users;
  late int todayIncome;
  late int todayInvites;
  late int todayUsers;

  AgentAccount.fromJson(Map<String, dynamic> json) {
    userId = int.parse(json['userId']);
    agent = EnumValue.fromJson(json['agent']);
    income = json['income'] ?? 0;
    withRmb = json['withRmb'] ?? 0;
    invites = json['invites'] ?? 0;
    users = json['users'] ?? 0;
    withdraw = json['withdraw'] ?? 0;
    withLatest = json['withLatest'] ?? '';
    todayIncome = json['todayIncome'] ?? 0;
    todayInvites = json['todayInvites'] ?? 0;
    todayUsers = json['todayUsers'] ?? 0;
  }

  String withdrawText() {
    return (withdraw / 100).toStringAsFixed(2);
  }
}

///
/// 流量主收益明细
///
class AgentIncome {
  late int userId;
  late String nickname;
  late String phone;
  late int invUid;
  late String seqNo;
  late int amount;
  late double ratio;
  late int channel;
  late String gmtCreate;

  AgentIncome.fromJson(Map<String, dynamic> json) {
    nickname = json['nickname'];
    phone = json['phone'];
    userId = int.parse(json['userId']);
    invUid = int.parse(json['invUid']);
    seqNo = json['seqNo'];
    amount = json['amount'];
    ratio = json['ratio'];
    channel = json['channel'];
    gmtCreate = json['gmtCreate'];
  }
}

///
/// 流量主数据统计指标
///
class AgentMetrics {
  late String day;
  late DateTime date;
  late int users;
  late int amount;
  late int invites;

  AgentMetrics.fromJson(Map<String, dynamic> json) {
    date = DateUtil.parse(json['day'], pattern: 'yyyy/MM/dd');
    day = DateUtil.formatDate(date, format: 'MM/dd');
    users = json['users'];
    amount = json['amount'];
    invites = json['invites'];
  }

  Map<dynamic, dynamic> toAmount() {
    return {
      'day': day,
      'name': '收益',
      'value': amount / 1000,
    };
  }

  Map<dynamic, dynamic> toUsers() {
    return {
      'day': day,
      'name': '人数',
      'value': users,
    };
  }

  Map<dynamic, dynamic> toInvites() {
    return {
      'day': day,
      'name': '邀请',
      'value': invites,
    };
  }
}
