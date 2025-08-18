import 'package:prize_lottery_app/base/model/enum_value.dart';

///
///
///
class LotteryIndex {
  late String period;
  late EnumValue type;
  late LottoIndex redBall;
  LottoIndex? blueBall;
  Lottery? lottery;

  LotteryIndex.fromJson(Map<String, dynamic> json) {
    period = json['period'];
    type = EnumValue.fromJson(json['type']);
    redBall = LottoIndex.fromJson(json['redBall']);
    if (json['blueBall'] != null) {
      blueBall = LottoIndex.fromJson(json['blueBall']);
    }
    if (json['lottery'] != null) {
      lottery = Lottery.fromJson(json['lottery']);
    }
  }
}

class Num3LottoIndex {
  late String period;
  late EnumValue type;
  late LottoIndex danIndex;
  late LottoIndex comIndex;
  late LottoIndex killIndex;
  Lottery? lottery;

  Num3LottoIndex.fromJson(Map<String, dynamic> json) {
    period = json['period'];
    type = EnumValue.fromJson(json['type']);
    danIndex = LottoIndex.fromJson1(json['danIndex']);
    comIndex = LottoIndex.fromJson1(json['comIndex']);
    killIndex = LottoIndex.fromJson1(json['killIndex']);
    if (json['lottery'] != null) {
      lottery = Lottery.fromJson(json['lottery']);
    }
  }
}

class Lottery {
  String period = '';
  List<String> redBall = [];
  List<String> blueBall = [];

  Lottery.fromJson(Map<String, dynamic> json) {
    period = json['period'];
    redBall = _redSplit(json['red'] ?? '');
    blueBall = _blueSplit(json['blue'] ?? '');
  }

  List<String> _redSplit(String red) {
    String trimmed = red.trim();
    return trimmed.isEmpty ? [] : trimmed.trim().split(RegExp('\\s+'));
  }

  List<String> _blueSplit(String blue) {
    String trimmed = blue.trim();
    return trimmed.isEmpty ? [] : trimmed.split(RegExp('\\s+'));
  }
}

class LottoIndex {
  ///
  late List<Index> values;

  LottoIndex({required this.values});

  LottoIndex.fromJson(Map<String, dynamic> json) {
    List list = json['values'];
    values = list.map((e) => Index.fromJson(e)).toList();
    _sortAndTopN();
  }

  LottoIndex.fromJson1(Map<String, dynamic> json) {
    List list = json['values'];
    values = list.map((e) => Index.fromJson(e)).toList();
    _sortWithKey();
  }

  LottoIndex reverse() {
    return LottoIndex(
      values:
          values.map((e) => Index(ball: e.ball, index: 1 - e.index)).toList(),
    );
  }

  void _sortWithKey() {
    values.sort((i1, i2) => i1.ball.compareTo(i2.ball));
  }

  void _sortAndTopN() {
    values.sort((i1, i2) {
      int compare = i2.index.compareTo(i1.index);
      if (compare == 0) {
        return i1.ball.compareTo(i2.ball);
      }
      return compare;
    });
    List<String> topBalls = values.take(5).map((e) => e.ball).toList();
    for (var e in values) {
      if (topBalls.contains(e.ball)) {
        e.hot = true;
      }
    }
  }

  static LottoIndex empty(int size) {
    return LottoIndex(
      values: List.generate(size, (i) => Index(ball: '$i', index: 0)),
    );
  }
}

class Index {
  late String ball;
  late double index;
  bool hot = false;

  Index({required this.ball, required this.index, this.hot = false});

  Index.fromJson(Map<String, dynamic> json) {
    ball = json['ball'];
    index = json['index'];
  }
}
