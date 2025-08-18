import 'package:prize_lottery_app/utils/date_util.dart';
import 'package:prize_lottery_app/views/lottery/utils/num3_lottery_utils.dart';

///
///
class WensFilter {
  ///稳氏四段
  static final segment1 = [
    [1, 3, 8],
    [4, 9],
    [5, 7],
    [0, 2, 6]
  ];
  static final segment2 = [
    [1, 6, 7],
    [3, 8],
    [5, 9],
    [0, 2, 4]
  ];
  static final segment3 = [
    [2, 7, 9],
    [1, 6],
    [3, 5],
    [0, 4, 8]
  ];
  static final segment4 = [
    [3, 4, 9],
    [2, 7],
    [1, 5],
    [0, 6, 8]
  ];

  ///4胆码表
  static final Map<int, List<int>> danTable = {
    1: [1, 3, 6, 8],
    2: [1, 2, 6, 7],
    3: [2, 4, 7, 9],
    4: [3, 4, 8, 9],
    5: [2, 5, 7, 9],
  };

  ///求邻码
  static List<int> judgeNeighbor(int value) {
    if (value == 0) {
      return [1, 9];
    }
    if (value == 9) {
      return [0, 8];
    }
    return [value - 1, value + 1];
  }

  static bool judgePattern(int tail, List<int> indices) {
    return (abs(indices[0] - indices[1]) == 5 &&
            tail == (indices[0] + indices[1]) % 10) ||
        (abs(indices[0] - indices[2]) == 5 &&
            tail == (indices[0] + indices[2]) % 10) ||
        (abs(indices[1] - indices[2]) == 5 &&
            tail == (indices[1] + indices[2]) % 10);
  }

  static int remainTail(
      int index1, int index2, int index3, int index4, int index5) {
    int index12 = (index1 + index2) % 10;
    if (index12 == (index3 + index4) % 10) {
      return index5;
    }
    if (index12 == (index3 + index5) % 10) {
      return index4;
    }
    return index3;
  }

  static List<int> calcIndex(value) {
    late List<int> index;
    if (value < 5) {
      index = [value, value + 5];
    } else {
      index = [value - 5, value];
    }
    return index;
  }

  static List<List<int>> remainIndex(List<int> indices) {
    return [0, 1, 2, 3, 4]
        .where((i) => !indices.contains(i))
        .map((i) => calcIndex(i))
        .toList();
  }

  static WensPattern negotiatePattern(tail) {
    if (tail == 5) {
      return WensPattern(
        type: 5,
        index: 4,
        segment: segment3,
        dan: danTable[5]!,
      );
    }
    if (judgePattern(tail, segment1[0])) {
      return WensPattern(
        type: 1,
        index: 1,
        segment: segment1,
        dan: danTable[1]!,
      );
    }
    if (judgePattern(tail, segment2[0])) {
      return WensPattern(
        type: 2,
        index: 2,
        segment: segment2,
        dan: danTable[2]!,
      );
    }
    if (judgePattern(tail, segment3[0])) {
      return WensPattern(
        type: 3,
        index: 3,
        segment: segment3,
        dan: danTable[3]!,
      );
    }
    return WensPattern(
      type: 4,
      index: 4,
      segment: segment4,
      dan: danTable[4]!,
    );
  }

  static List<int> shiDuiMa(codes) {
    int code = codes[1] < 5 ? codes[1] + 5 : codes[1] - 5;
    List<int> result = [codes[1], code];
    result.add(code - 2 < 0 ? code - 2 + 10 : code - 2);
    result.add(code - 1 < 0 ? code - 1 + 10 : code - 1);
    result.add(code + 1 > 9 ? code + 1 - 10 : code + 1);
    result.add(code + 2 > 9 ? code + 2 - 10 : code + 2);
    result.sort();
    return result;
  }

  static WensPattern calcPattern(List<int> balls) {
    Set<int> set = Set.of(balls);
    List<int> collected = balls;
    if (set.length == 1) {
      List<int> neighbor = judgeNeighbor(collected[0]);
      List<int> index1 = calcIndex(neighbor[0]);
      int index1Tail = sumTail(index1);
      List<int> index2 = calcIndex(neighbor[1]);
      int index2Tail = sumTail(index2);
      List<List<int>> remainIndices = remainIndex([index1[0], index2[0]]);
      List<int> index3 = remainIndices[0];
      int index3Tail = sumTail(index3);
      List<int> index4 = remainIndices[1];
      int index4Tail = sumTail(index4);
      List<int> index5 = remainIndices[2];
      int index5Tail = sumTail(index5);
      int tail = remainTail(
          index1Tail, index2Tail, index3Tail, index4Tail, index5Tail);
      return negotiatePattern(tail);
    }

    if (set.length == 2) {
      collected = List.of(set);
      if (abs(collected[0] - collected[1]) == 5) {
        if (collected[0] + collected[1] != 5) {
          List<int> index1 = calcIndex(collected[0]);
          int index1Tail = sumTail(index1);
          List<int> index2 = [0, 5];
          int index2Tail = sumTail(index2);
          List<List<int>> remainIndices = remainIndex([index1[0], index2[0]]);
          List<int> index3 = remainIndices[0];
          int index3Tail = sumTail(index3);
          List<int> index4 = remainIndices[1];
          int index4Tail = sumTail(index4);
          List<int> index5 = remainIndices[2];
          int index5Tail = sumTail(index5);
          int remainedTail = remainTail(
              index4Tail, index5Tail, index1Tail, index2Tail, index3Tail);
          return negotiatePattern(remainedTail);
        }
        List<int> index1 = [0, 5];
        int index1Tail = sumTail(index1);
        List<int> index2 = [1, 6];
        int index2Tail = sumTail(index2);
        List<List<int>> remainIndices = remainIndex([index1[0], index2[0]]);
        List<int> index3 = remainIndices[0];
        int index3Tail = sumTail(index3);
        List<int> index4 = remainIndices[1];
        int index4Tail = sumTail(index4);
        List<int> index5 = remainIndices[2];
        int index5Tail = sumTail(index5);
        int remainedTail = remainTail(
            index4Tail, index5Tail, index1Tail, index2Tail, index3Tail);
        return negotiatePattern(remainedTail);
      }
      List<int> index1 = calcIndex(collected[0]);
      int index1Tail = sumTail(index1);
      List<int> index2 = calcIndex(collected[1]);
      int index2Tail = sumTail(index2);
      List<List<int>> remainIndices = remainIndex([index1[0], index2[0]]);
      List<int> index3 = remainIndices[0];
      int index3Tail = sumTail(index3);
      List<int> index4 = remainIndices[1];
      int index4Tail = sumTail(index4);
      List<int> index5 = remainIndices[2];
      int index5Tail = sumTail(index5);
      int remainedTail = remainTail(
          index1Tail, index2Tail, index3Tail, index4Tail, index5Tail);
      return negotiatePattern(remainedTail);
    }
    //组六计算
    List<int> index1 = calcIndex(collected[0]);
    int index1Tail = sumTail(index1);
    List<int> index2 = calcIndex(collected[1]);
    int index2Tail = sumTail(index2);
    List<int> index3 = calcIndex(collected[2]);
    int index3Tail = sumTail(index3);
    if (index1Tail != index2Tail &&
        index2Tail != index3Tail &&
        index1Tail != index3Tail) {
      List<List<int>> remainIndices =
          remainIndex([index1[0], index2[0], index3[0]]);
      List<int> index4 = remainIndices[0];
      int index4Tail = sumTail(index4);
      List<int> index5 = remainIndices[1];
      int index5Tail = sumTail(index5);
      int remainedTail = remainTail(
          index4Tail, index5Tail, index1Tail, index2Tail, index3Tail);
      return negotiatePattern(remainedTail);
    }
    if (index1Tail == index2Tail) {
      List<List<int>> remainIndices = remainIndex([index1[0], index3[0]]);
      List<int> index4 = remainIndices[0];
      int index4Tail = sumTail(index4);
      List<int> index5 = remainIndices[1];
      int index5Tail = sumTail(index5);
      List<int> index6 = remainIndices[2];
      int index6Tail = sumTail(index6);
      int remainedTail = remainTail(
          index1Tail, index3Tail, index4Tail, index5Tail, index6Tail);
      return negotiatePattern(remainedTail);
    }
    List<List<int>> remainIndices = remainIndex([index1[0], index2[0]]);
    List<int> index4 = remainIndices[0];
    int index4Tail = sumTail(index4);
    List<int> index5 = remainIndices[1];
    int index5Tail = sumTail(index5);
    List<int> index6 = remainIndices[2];
    int index6Tail = sumTail(index6);
    int remainedTail =
        remainTail(index1Tail, index2Tail, index4Tail, index5Tail, index6Tail);
    return negotiatePattern(remainedTail);
  }

  static String joinSegment(List<List<int>> segment) {
    return '${segment[0].join('')}-${segment[1].join('')}-${segment[2].join('')}-${segment[3].join('')}';
  }

  static WensInfo calcWensInfo(Num3Lottery lottery) {
    List<int> codes = lottery.current
        .split(RegExp(r'\s+'))
        .map((e) => int.parse(e.trim()))
        .toList();
    WensPattern pattern = calcPattern(codes);
    List<int> weekDanTable = weekDan(lottery.nextDate());
    List<int> twoDiff = towCodeDiff(codes);
    List<int> twoSum = twoCodeSum(codes);
    List<int>? shiDanTable;
    String? shiSegment;
    if (lottery.nextShi != null && lottery.nextShi!.isNotEmpty) {
      List<int> shiCodes = lottery.nextShi!
          .split(RegExp(r'\s+'))
          .map((e) => int.parse(e.trim()))
          .toList();
      var shiPattern = calcPattern(shiCodes);
      shiDanTable = shiPattern.dan;
      shiSegment = joinSegment(shiPattern.segment);
    }
    return WensInfo(
      lottery: lottery,
      twoDiff: twoDiff,
      twoSum: twoSum,
      weekDanTable: weekDanTable,
      wensDanTable: pattern.dan,
      segment: joinSegment(pattern.segment),
      tenDanTable: shiDuiMa(codes),
      shiDanTable: shiDanTable,
      shiSegment: shiSegment,
    );
  }
}

class WensPattern {
  late int type;
  late int index;
  late List<List<int>> segment;
  late List<int> dan;

  WensPattern({
    required this.type,
    required this.index,
    required this.segment,
    required this.dan,
  });
}

class FilterInfo {
  late Num3Lottery lottery;
  late List<int> jinDiff;
  late List<int> oeSum;
  late List<int> todayDan;
  late List<List<int>> twoMaList;
  late Map<int, DuanZuInfo> currDuanZu;
  Map<int, DuanZuInfo>? lastDuanZu;

  FilterInfo({required this.lottery}) {
    jinDiff = jinWeiDiff(lottery.current);
    oeSum = evenSum(lottery.current);
    todayDan = weekDan(lottery.nextDate());
    twoMaList = lotteryDanZu(lottery.current).zuHe;
    currDuanZu = duanZuInfo(lottery.current);
    if (lottery.last != null) {
      lastDuanZu = duanZuInfo(lottery.last!);
    }
  }
}

class WensInfo {
  late Num3Lottery lottery;
  late List<int> twoDiff;
  late List<int> twoSum;
  late List<int> weekDanTable;
  late List<int> wensDanTable;
  late String segment;
  late List<int> tenDanTable;
  late List<int>? shiDanTable;
  String? shiSegment;

  WensInfo({
    required this.lottery,
    required this.twoDiff,
    required this.twoSum,
    required this.weekDanTable,
    required this.wensDanTable,
    required this.segment,
    required this.tenDanTable,
    this.shiDanTable,
    this.shiSegment,
  });
}

class Num3Lottery {
  late String period;
  late String nextPeriod;
  late String lastDate;
  late DateTime lotDate;
  late String current;
  String? lastPeriod;
  String? last;
  String? next;
  String? nextShi;

  Num3Lottery.fromJson(Map<String, dynamic> json) {
    period = json['period'];
    nextPeriod = json['nextPeriod'];
    lastDate = json['lotDate'];
    lotDate = DateUtil.parse(lastDate, pattern: 'yyyy/MM/dd');
    current = json['current'];
    if (json['next'] != null) {
      next = json['next'];
      nextShi = json['nextShi'];
    }
    if (json['last'] != null) {
      last = json['last'];
      lastPeriod = json['lastPeriod'];
    }
  }

  DateTime nextDate() {
    return lotDate.add(const Duration(days: 1));
  }
}

class Num3LottoDan {
  late String period;
  List<int> danList = [];
  List<int> shiList = [];

  Num3LottoDan.fromJson(Map<String, dynamic> json) {
    period = json['period'] ?? '';
    if (json['danList'] != null) {
      danList = (json['danList'] as List).cast<int>();
    }
    if (json['shiList'] != null) {
      shiList = (json['shiList'] as List).cast<int>();
    }
  }
}
