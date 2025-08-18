import 'dart:math';

import 'package:flutter/material.dart';

///
///
abstract class Shrink {
  ///
  ///缩水过滤
  bool shrink(List<int> balls);

  ///是否选中
  bool selected();

  ///清空缩水条件
  void clear();
}

class DanModel {
  ///胆码最小值
  late int min;

  ///胆码最大值
  late int max;

  ///胆码个数最大值
  late int danMax;

  ///胆码选择个数限制
  late int limit;

  DanModel({
    required this.min,
    required this.max,
    required this.danMax,
    required this.limit,
  });
}

///
/// 胆码过滤标识
const int danShrinkIdx = 1;

///
/// 单组胆码过滤
class DanShrink extends Shrink {
  ///
  ///
  Set<int> dans = {};

  ///
  Set<int> numbers = {};

  DanShrink();

  DanShrink.fromStr(String data) {
    List<String> items = data.split(";");
    dans = items[0].split(",").map((e) => int.parse(e)).toSet();
    numbers = items[1].split(",").map((e) => int.parse(e)).toSet();
  }

  @override
  bool shrink(List<int> balls) {
    if (dans.isEmpty) {
      return true;
    }
    Set<int> intersection = Set.of(balls).intersection(dans);
    return numbers.contains(intersection.length);
  }

  String encode() {
    return "${dans.join(",")};${numbers.join(",")}";
  }

  @override
  bool selected() {
    return dans.isNotEmpty && numbers.isNotEmpty;
  }

  @override
  void clear() {
    dans.clear();
    numbers.clear();
  }
}

///和值过滤标识
const int sumShrinkIdx = 2;

///
/// 和值过滤
class SumShrink extends Shrink {
  ///
  late RangeValues ranges;

  ///
  late double min, max;

  ///和值奇偶
  Set<int> oddEven = {};

  ///和值路数
  Set<int> roads = {};

  ///和值尾数
  Set<int> tail = {};

  SumShrink({required this.min, required this.max}) {
    ranges = RangeValues(min, max);
  }

  SumShrink.fromStr(String data) {
    List<String> items = data.split(";");
    min = double.parse(items[0]);
    max = double.parse(items[1]);
    ranges = RangeValues(min, max);
    if (items[2].trim().isNotEmpty) {
      oddEven = items[2].split(",").map((e) => int.parse(e)).toSet();
    }
    if (items[3].trim().isNotEmpty) {
      roads = items[3].split(",").map((e) => int.parse(e)).toSet();
    }
    if (items[4].trim().isNotEmpty) {
      tail = items[4].split(",").map((e) => int.parse(e)).toSet();
    }
  }

  String encode() {
    return "${ranges.start};${ranges.end};${oddEven.join(",")};${roads.join(",")};${tail.join(",")}";
  }

  @override
  bool shrink(List<int> balls) {
    ///
    ///
    int sum = balls.reduce((v, e) => v + e);

    ///和值范围判断
    if (ranges.start > sum || ranges.end < sum) {
      return false;
    }

    ///和值奇偶
    if (oddEven.isNotEmpty && !oddEven.contains(sum % 2)) {
      return false;
    }

    ///和值路数
    if (roads.isNotEmpty && !roads.contains(sum % 3)) {
      return false;
    }
    //和值尾数
    if (tail.isNotEmpty) {
      int sail;
      if (sum <= 9) {
        sail = sum;
      } else if (sum <= 99) {
        sail = sum % 10;
      } else {
        sail = (sum % 100) % 10;
      }
      if (!tail.contains(sail)) {
        return false;
      }
    }
    return true;
  }

  @override
  bool selected() {
    return ranges.start > min ||
        ranges.end < max ||
        oddEven.isNotEmpty ||
        tail.isNotEmpty ||
        roads.isNotEmpty;
  }

  @override
  void clear() {
    ranges = RangeValues(min, max);
    oddEven.clear();
    tail.clear();
    roads.clear();
  }
}

class Road012Model {
  ///
  /// 012路选择范围
  late List<int> ranges;

  Road012Model(this.ranges);
}

/// 012路过虑标识
const int roadShrinkIdx = 3;

///
/// 012路过滤
class Road012Shrink extends Shrink {
  ///
  Map<int, List<int>> roads = {
    0: [],
    1: [],
    2: [],
  };

  Road012Shrink();

  Road012Shrink.fromStr(String data) {
    List<String> items = data.split(";");
    for (var e in items) {
      List<String> item = e.split(":");
      int road = int.parse(item[0]);
      if (item[1].trim().isNotEmpty) {
        roads[road] = item[1].split(",").map((e) => int.parse(e)).toList();
      }
    }
  }

  String encode() {
    return '0:${roads[0]!.join(",")};1:${roads[1]!.join(",")};2:${roads[2]!.join(",")}';
  }

  @override
  bool shrink(List<int> balls) {
    ///0路有限制
    if (roads[0]!.isNotEmpty && !roads[0]!.contains(_calcRoadX(balls, 0))) {
      return false;
    }

    ///1路有限制
    if (roads[1]!.isNotEmpty && !roads[1]!.contains(_calcRoadX(balls, 1))) {
      return false;
    }

    ///2路有限制
    if (roads[2]!.isNotEmpty && !roads[2]!.contains(_calcRoadX(balls, 2))) {
      return false;
    }

    ///
    return true;
  }

  ///
  ///
  int _calcRoadX(List<int> balls, int road) {
    int count = 0;
    for (int ball in balls) {
      if (ball % 3 == road) {
        count++;
      }
    }
    return count;
  }

  @override
  bool selected() {
    return roads[0]!.isNotEmpty || roads[0]!.isNotEmpty || roads[0]!.isNotEmpty;
  }

  @override
  void clear() {
    roads.forEach((key, value) => value.clear());
  }
}

class BigModel {
  ///
  late Map<int, String> ranges;

  BigModel(this.ranges);
}

///大小过滤标识
const int bigShrinkIdx = 4;

///
///大小过滤
class BigShrink extends Shrink {
  ///大小值分界
  late int seg;

  ///
  List<String> ratios = [];

  BigShrink(this.seg);

  BigShrink.fromStr(String data) {
    List<String> items = data.split(';');
    seg = int.parse(items[0]);
    ratios = items[1].split(",");
  }

  String encode() {
    return "$seg;${ratios.join(",")}";
  }

  @override
  bool shrink(List<int> balls) {
    ///
    if (ratios.isEmpty) {
      return true;
    }

    ///判断大小比
    return ratios.contains(_calcRatio(balls));
  }

  ///计算大小比值
  String _calcRatio(List<int> balls) {
    int big = 0, small = 0;
    for (int ball in balls) {
      if (ball >= seg) {
        big++;
      } else {
        small++;
      }
    }
    return '$big:$small';
  }

  @override
  bool selected() {
    return ratios.isNotEmpty;
  }

  @override
  void clear() {
    ratios.clear();
  }
}

class EvenModel {
  ///
  late Map<int, String> ranges;

  EvenModel(this.ranges);
}

///奇偶过滤标识
const int evenShrinkIdx = 5;

///
/// 奇偶过滤
class EvenOddShrink extends Shrink {
  ///
  List<String> ratios = [];

  EvenOddShrink();

  EvenOddShrink.fromStr(String data) {
    ratios = data.split(",");
  }

  String encode() {
    return ratios.join(",");
  }

  @override
  bool shrink(List<int> balls) {
    if (ratios.isEmpty) {
      return true;
    }
    return ratios.contains(_calcRatio(balls));
  }

  ///计算奇偶比
  String _calcRatio(List<int> balls) {
    int odd = 0, even = 0;
    for (var ball in balls) {
      if (ball % 2 == 0) {
        even++;
      } else {
        odd++;
      }
    }
    return '$odd:$even';
  }

  @override
  bool selected() {
    return ratios.isNotEmpty;
  }

  @override
  void clear() {
    ratios.clear();
  }
}

class KuaModel {
  ///跨度范围
  late int min;
  late int max;

  KuaModel({required this.min, required this.max});
}

const int kuaShrinkIdx = 6;

///
/// 跨度过滤
class KuaShrink extends Shrink {
  ///跨度范围
  late int min;
  late int max;

  ///已选中的跨度集合
  Set<int> kuas = {};

  KuaShrink({required this.min, required this.max});

  KuaShrink.fromStr(String data) {
    List<String> items = data.split(';');
    min = int.parse(items[0]);
    max = int.parse(items[1]);
    kuas = items[2].split(",").map((e) => int.parse(e)).toSet();
  }

  String encode() {
    return "$min;$max;${kuas.join(",")}";
  }

  @override
  bool shrink(List<int> balls) {
    if (kuas.isEmpty) {
      return true;
    }
    int minn = max, maxx = min;
    for (var ball in balls) {
      if (minn > ball) {
        minn = ball;
      }
      if (maxx < ball) {
        maxx = ball;
      }
    }
    return kuas.contains(maxx - minn);
  }

  @override
  bool selected() {
    return kuas.isNotEmpty;
  }

  @override
  void clear() {
    kuas.clear();
  }
}

class N3PatternModel {
  ///形态范围
  late Map<int, String> patterns = {};

  N3PatternModel(this.patterns);
}

///
const int n3PatternShrinkIdx = 7;

///
/// 选三型形态过滤
class N3PatternShrink extends Shrink {
  ///已选择的形态
  Map<int, String> pattern = {};

  N3PatternShrink();

  N3PatternShrink.fromStr(String data) {
    List<String> items = data.split(";");
    for (var value in items) {
      List<String> values = value.split(':');
      pattern[int.parse(values[0])] = values[1];
    }
  }

  String encode() {
    return pattern.entries.map((e) => "${e.key}:${e.value}").toList().join(";");
  }

  @override
  bool shrink(List<int> balls) {
    if (pattern.isEmpty) {
      return true;
    }
    return pattern.containsKey(Set.of(balls).length);
  }

  @override
  bool selected() {
    return pattern.isNotEmpty;
  }

  @override
  void clear() {
    pattern.clear();
  }
}

class PrimeModel {
  ///
  late Map<int, String> primes;

  PrimeModel(this.primes);
}

///
const int primeShrinkIdx = 8;

///
/// 质合过滤
class PrimeShrink extends Shrink {
  ///
  Set<String> prime = {};

  PrimeShrink();

  PrimeShrink.fromStr(String data) {
    prime.addAll(data.split(","));
  }

  String encode() {
    return prime.join(",");
  }

  @override
  bool shrink(List<int> balls) {
    if (prime.isEmpty) {
      return true;
    }
    return prime.contains(_calcRatio(balls));
  }

  String _calcRatio(List<int> balls) {
    int prime = 0, composite = 0;
    for (int ball in balls) {
      if (_isComposite(ball)) {
        composite++;
      } else {
        prime++;
      }
    }
    return '$prime:$composite';
  }

  bool _isComposite(int x) {
    if (x <= 2) {
      return false;
    }
    for (int i = 2; i <= sqrt(x); i++) {
      if (x % i == 0) {
        return true;
      }
    }
    return false;
  }

  @override
  bool selected() {
    return prime.isNotEmpty;
  }

  @override
  void clear() {
    prime.clear();
  }
}

class SeriesModel {
  ///
  /// 连号范围
  late Map<int, String> ranges;

  SeriesModel(this.ranges);
}

///
const int seriesShrinkIdx = 9;

///
/// 连号过滤
class SeriesShrink extends Shrink {
  ///已选择连号
  Map<int, String> series = {};

  SeriesShrink();

  SeriesShrink.fromStr(String data) {
    List<String> items = data.split(';');
    for (var value in items) {
      List<String> values = value.split(':');
      series[int.parse(values[0])] = values[1];
    }
  }

  String encode() {
    return series.entries.map((e) => '${e.key}:${e.value}').join(';');
  }

  @override
  bool shrink(List<int> balls) {
    if (series.isEmpty) {
      return true;
    }
    return series.containsKey(_calcSeries(balls));
  }

  ///
  /// 计算最大连号
  int _calcSeries(List<int> balls) {
    int current = 1, max = 1;
    List<int> copy = List.of(balls);
    copy.sort();
    for (int i = 1; i < copy.length; i++) {
      if (copy[i] - copy[i - 1] == 1) {
        current = current + 1;
        continue;
      }
      if (current > max) {
        max = current;
      }
      current = 1;
    }
    if (current > max) {
      max = current;
    }
    return max <= 1 ? max - 1 : max;
  }

  @override
  bool selected() {
    return series.isNotEmpty;
  }

  @override
  void clear() {
    series.clear();
  }
}

class SegmentModel {
  ///
  late List<int> lower;
  late List<int> middle;
  late List<int> higher;
  late int segMax;

  SegmentModel({
    required this.lower,
    required this.middle,
    required this.higher,
    required this.segMax,
  });
}

///
const int segmentShrinkIdx = 10;

///
/// 分段过滤
class SegmentShrink extends Shrink {
  ///
  late List<int> lower;
  late List<int> middle;
  late List<int> higher;
  late int segMax;

  Map<int, Set<int>> segs = {1: {}, 2: {}, 3: {}};

  SegmentShrink({
    required this.lower,
    required this.middle,
    required this.higher,
    required this.segMax,
  });

  SegmentShrink.fromStr(String data) {
    List<String> items = data.split(';');
    segMax = int.parse(items[0]);
    lower = items[1].split(',').map((e) => int.parse(e)).toList();
    middle = items[2].split(',').map((e) => int.parse(e)).toList();
    higher = items[3].split(',').map((e) => int.parse(e)).toList();
    if (items[4].trim().isNotEmpty) {
      segs[1] = items[4].split(',').map((e) => int.parse(e)).toSet();
    }
    if (items[5].trim().isNotEmpty) {
      segs[2] = items[5].split(',').map((e) => int.parse(e)).toSet();
    }
    if (items[6].trim().isNotEmpty) {
      segs[3] = items[6].split(',').map((e) => int.parse(e)).toSet();
    }
  }

  String encode() {
    return '$segMax;${lower.join(',')};${middle.join(',')};${higher.join(',')};${segs[1]!.join(',')};${segs[2]!.join(',')};${segs[3]!.join(',')}';
  }

  @override
  bool shrink(List<int> balls) {
    if (segs[1]!.isNotEmpty &&
        !segs[1]!.contains(Set.of(lower).intersection(Set.of(balls)).length)) {
      return false;
    }
    if (segs[2]!.isNotEmpty &&
        !segs[2]!.contains(Set.of(middle).intersection(Set.of(balls)).length)) {
      return false;
    }
    if (segs[3]!.isNotEmpty &&
        !segs[3]!.contains(Set.of(higher).intersection(Set.of(balls)).length)) {
      return false;
    }
    return true;
  }

  @override
  bool selected() {
    return segs[1]!.isNotEmpty || segs[2]!.isNotEmpty || segs[3]!.isNotEmpty;
  }

  @override
  void clear() {
    segs.forEach((key, value) => value.clear());
  }
}

class AcModel {
  ///AC值范围
  late List<int> ranges;

  AcModel(this.ranges);
}

const int acShrinkIdx = 11;

///
/// AC值过滤
class AcShrink extends Shrink {
  ///已选择的AC值
  Set<int> acs = {};

  AcShrink();

  AcShrink.fromStr(String data) {
    acs = data.split(',').map((e) => int.parse(e)).toSet();
  }

  String encode() {
    return acs.join(',');
  }

  @override
  bool shrink(List<int> balls) {
    if (acs.isEmpty) {
      return true;
    }
    return acs.contains(_calcAc(balls));
  }

  ///
  /// 计算AC值
  int _calcAc(List<int> balls) {
    Set<int> deltas = {};
    for (int i = balls.length - 1; i >= 1; i--) {
      for (int j = i - 1; j >= 0; j--) {
        int delta = balls[i] - balls[j];
        deltas.add(delta);
      }
    }
    return deltas.length - balls.length + 1;
  }

  @override
  bool selected() {
    return acs.isNotEmpty;
  }

  @override
  void clear() {
    acs.clear();
  }
}
