///
///
class StatHitValue {
  ///
  late int series;

  ///
  late double rate;

  ///
  double? fullRate;

  ///
  late String count;

  StatHitValue.fromJson(Map<String, dynamic> json) {
    series = json['series'] ?? 0;
    rate = json['rate'] ?? 0;
    fullRate = json['fullRate'] ?? 0;
    count = json['count'] ?? '';
  }

  StatHitValue(this.series, this.rate, this.fullRate, this.count);
}
