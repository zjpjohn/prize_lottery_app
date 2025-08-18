import 'package:prize_lottery_app/base/model/stat_hit_value.dart';
import 'package:prize_lottery_app/views/rank/model/master_mul_rank.dart';

class RandomMaster extends MasterMulRank {
  ///彩票类型
  late String type;

  /// 设置渠道
  late String channel;

  ///预测成绩
  late StatHitValue achieve;

  ///命中字段中文名称
  late String hitKey;

  RandomMaster.fromFsd(Map<String, dynamic> json) : super.fromJson(json) {
    type = 'fc3d';
    channel = 'k1';
    achieve = StatHitValue.fromJson(json['com7']);
    hitKey = '七码';
  }

  RandomMaster.fromSsq(Map<String, dynamic> json) : super.fromJson(json) {
    type = 'ssq';
    channel = 'rk3';
    achieve = StatHitValue.fromJson(json['rk3']);
    hitKey = '杀红';
  }

  RandomMaster.fromDlt(Map<String, dynamic> json) : super.fromJson(json) {
    type = 'dlt';
    channel = 'rk';
    achieve = StatHitValue.fromJson(json['rk']);
    hitKey = '杀红';
  }

  RandomMaster.fromPl3(Map<String, dynamic> json) : super.fromJson(json) {
    type = 'pl3';
    channel = 'k1';
    achieve = StatHitValue.fromJson(json['com7']);
    hitKey = '七码';
  }

  RandomMaster.fromQlc(Map<String, dynamic> json) : super.fromJson(json) {
    type = 'qlc';
    channel = 'red22';
    achieve = StatHitValue.fromJson(json['red22']);
    hitKey = '围码';
  }

  @override
  MapEntry<String, StatHitValue> redHit() {
    return MapEntry(hitKey, achieve);
  }
}
