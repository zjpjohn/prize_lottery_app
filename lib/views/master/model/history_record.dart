import 'package:prize_lottery_app/base/model/forecast_value.dart';
import 'package:prize_lottery_app/utils/tools.dart';

class HistoryRecord {
  ///
  Map<String, List<HitItem>> records = {};

  ///
  List<List<String>> reds = [];

  ///
  List<List<String>> blues = [];

  void addLotto(Map<String, List<List<String>>> lottos) {
    reds = lottos['red']!;
    blues = lottos['blue']!;
  }

  void addRecord(String type, List<HitItem> items) {
    records[type] = items;
  }

  List<HitItem> getRecords(String type) {
    return records[type]!;
  }
}

class HitItem {
  ///
  bool showHit;

  ///
  String period;

  ///
  int hit;

  ///
  List<Model> values;

  ///
  List<String> reds = [];

  ///
  List<String> blues = [];

  HitItem({
    this.showHit = false,
    required this.period,
    required this.hit,
    required this.values,
    required this.reds,
    this.blues = const [],
  });

  static HitItem parseItem(
    String period,
    bool showHit,
    ForecastValue value,
    List<String> reds,
    List<String> blues,
  ) {
    return HitItem(
      showHit: showHit,
      period: period,
      hit: value.dataHit,
      values: Tools.parse(value.hitData),
      reds: reds,
      blues: blues,
    );
  }
}
