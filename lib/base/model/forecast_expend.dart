///
///
class ForecastExpend {
  ///
  /// 消耗奖励金
  late int expend;

  /// 最多金币抵扣奖励金
  late int bounty;

  ForecastExpend({
    required this.expend,
    required this.bounty,
  });

  ForecastExpend.fromJson(Map<String, dynamic> json) {
    bounty = json['bounty'];
    expend = json['expend'];
  }
}
