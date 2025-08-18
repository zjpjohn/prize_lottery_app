import 'package:prize_lottery_app/base/model/enum_value.dart';
import 'package:prize_lottery_app/base/model/master_value.dart';

class LotteryTime {
  late String lottery;
  late String period;

  LotteryTime.fromJson(Map<String, dynamic> json) {
    lottery = json['lottery'];
    period = json['period'];
  }
}

class MasterFocus {
  late int userId;
  late String masterId;
  late MasterValue master;
  List<LotteryTime> lotteries = [];

  MasterFocus.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    masterId = json['masterId'];
    master = MasterValue.fromJson(json['master']);
    if (json['lotteries'] != null) {
      List list = json['lotteries'];
      lotteries = list.map((e) => LotteryTime.fromJson(e)).toList();
    }
  }
}

///
///
class SubscribeMaster {
  ///专家标识
  late String masterId;

  ///订阅渠道
  late EnumValue channel;

  ///最新预测期号
  late String latest;

  ///最新预测更新时间
  late String modifyTime;

  ///订阅时间
  late String gmtCreate;

  ///追踪专家预测值字段
  late String trace;

  ///追踪专家预测值字段中文名
  late String traceZh;

  ///是否重点关注
  late int special;

  ///专家信息
  late MasterValue master;

  SubscribeMaster.fromJson(Map<String, dynamic> json) {
    masterId = json['masterId'];
    channel = EnumValue.fromJson(json['channel']);
    latest = json['latest'];
    modifyTime = json['modifyTime'];
    gmtCreate = json['gmtCreate'];
    trace = json['trace'] ?? '';
    traceZh = json['traceZh'] ?? '';
    special = json['special'] ?? 0;
    master = MasterValue.fromJson(json['master']);
  }
}
