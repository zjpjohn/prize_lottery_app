import 'dart:math';

///
/// 进位和差表
List<List<int>> jinDiffList = [
  [0, 1],
  [0, 2],
  [1, 2]
];

///
///
Map<int, List<List<int>>> jinWeiTable = {
  0: [
    [0, 0],
    [1, 1],
    [1, 9],
    [2, 2],
    [2, 8],
    [3, 3],
    [3, 7],
    [4, 4],
    [4, 6],
    [5, 5],
    [6, 6],
    [7, 7],
    [8, 8],
    [9, 9]
  ],
  1: [
    [0, 1],
    [0, 9],
    [1, 2],
    [2, 3],
    [2, 9],
    [3, 4],
    [3, 8],
    [4, 5],
    [4, 7],
    [5, 6],
    [6, 7],
    [7, 8],
    [8, 9]
  ],
  2: [
    [0, 2],
    [0, 8],
    [1, 1],
    [1, 3],
    [1, 9],
    [2, 4],
    [3, 5],
    [3, 9],
    [4, 6],
    [4, 8],
    [5, 7],
    [6, 6],
    [6, 8],
    [7, 9]
  ],
  3: [
    [0, 3],
    [0, 7],
    [1, 2],
    [1, 4],
    [1, 8],
    [2, 5],
    [2, 9],
    [3, 6],
    [4, 7],
    [4, 9],
    [5, 8],
    [6, 7],
    [6, 9]
  ],
  4: [
    [0, 4],
    [0, 6],
    [1, 3],
    [1, 5],
    [1, 7],
    [2, 2],
    [2, 6],
    [2, 8],
    [3, 7],
    [3, 9],
    [4, 8],
    [5, 9],
    [6, 8],
    [7, 7]
  ],
  5: [
    [0, 5],
    [1, 4],
    [1, 6],
    [2, 3],
    [2, 7],
    [3, 8],
    [4, 9],
    [6, 9],
    [7, 8]
  ],
  6: [
    [0, 4],
    [0, 6],
    [1, 5],
    [1, 7],
    [2, 4],
    [2, 6],
    [2, 8],
    [3, 3],
    [3, 7],
    [3, 9],
    [4, 8],
    [5, 9],
    [7, 9],
    [8, 8]
  ],
  7: [
    [0, 3],
    [0, 7],
    [1, 4],
    [1, 6],
    [1, 8],
    [2, 5],
    [2, 9],
    [3, 4],
    [3, 6],
    [4, 7],
    [5, 8],
    [6, 9],
    [8, 9]
  ],
  8: [
    [0, 2],
    [0, 8],
    [1, 3],
    [1, 7],
    [1, 9],
    [2, 4],
    [2, 6],
    [3, 5],
    [4, 4],
    [4, 6],
    [5, 7],
    [6, 8],
    [7, 9],
    [9, 9]
  ],
  9: [
    [0, 1],
    [0, 9],
    [1, 2],
    [1, 8],
    [2, 3],
    [2, 7],
    [3, 4],
    [3, 6],
    [4, 5],
    [5, 6],
    [6, 7],
    [7, 8],
    [8, 9]
  ],
};

Map<int, List<List<int>>> evenTable = {
  0: [
    [0, 0],
    [1, 9],
    [2, 8],
    [3, 7],
    [4, 6],
    [5, 5],
    [0, 5],
  ],
  2: [
    [0, 2],
    [1, 1],
    [3, 9],
    [4, 8],
    [5, 7],
    [6, 6],
    [1, 6]
  ],
  4: [
    [1, 3],
    [2, 2],
    [6, 8],
    [7, 7],
    [5, 9],
    [0, 4],
    [2, 7]
  ],
  6: [
    [0, 6],
    [1, 5],
    [3, 3],
    [2, 4],
    [8, 8],
    [7, 9],
    [3, 8]
  ],
  8: [
    [0, 8],
    [1, 7],
    [2, 6],
    [3, 5],
    [4, 4],
    [9, 9],
    [4, 9]
  ],
};

///星期胆码表
final weekDanTable = {
  1: [7, 9, 0, 6],
  2: [5, 9, 6, 8],
  3: [5, 0, 4, 8],
  4: [3, 6, 5, 0],
  5: [3, 7, 4, 6],
  6: [3, 5, 2, 6],
  7: [1, 5, 2, 4]
};

///
/// 胆码组信息
class Num3LottoDanZu {
  late List<int> danZu;
  late List<List<int>> zuHe;

  Num3LottoDanZu({
    required this.danZu,
    required this.zuHe,
  });

  List<String> zuHeString() {
    return zuHeTxt(zuHe);
  }
}

class DuanZuInfo {
  late String txt;
  late List<List<int>> table;
  late List<String> excludes;

  DuanZuInfo({
    required this.txt,
    required this.table,
    required this.excludes,
  });
}

class JinWeiInfo {
  late List<int> diff;
  late List<String> zu3;
  late List<String> zu6;

  JinWeiInfo({
    required this.diff,
    required this.zu3,
    required this.zu6,
  });
}

class EvenSumInfo {
  late List<int> even;
  late List<String> zu3;
  late List<String> zu6;

  EvenSumInfo({
    required this.even,
    required this.zu3,
    required this.zu6,
  });
}

class FilterDto {
  List<int> jinDiff = [];
  List<int> evenSum = [];
  List<int> danList1 = [];
  List<int> danList2 = [];
  List<int> danList3 = [];
  List<int> sumList = [];
  List<int> kuaList = [];
  List<int> killList = [];
  List<List<int>> twoMa = [];
  Map<int, List<int>> direct = {0: [], 1: [], 2: []};
  Map<int, DuanZuInfo> currDuanZu = {};
  Map<int, DuanZuInfo> lastDuanZu = {};

  bool hasConditions() {
    return danList1.isNotEmpty ||
        danList2.isNotEmpty ||
        danList3.isNotEmpty ||
        sumList.isNotEmpty ||
        kuaList.isNotEmpty ||
        killList.isNotEmpty ||
        twoMa.isNotEmpty ||
        jinDiff.isNotEmpty ||
        evenSum.isNotEmpty ||
        currDuanZu.isNotEmpty ||
        lastDuanZu.isNotEmpty;
  }

  bool directNotEmpty() {
    return direct[0]!.isNotEmpty ||
        direct[1]!.isNotEmpty ||
        direct[2]!.isNotEmpty;
  }

  List<int> directItem(int index) {
    if (direct[index] != null && direct[index]!.isNotEmpty) {
      return direct[index]!;
    }
    return List.generate(10, (i) => i);
  }

  resetFilter() {
    danList1 = [];
    danList2 = [];
    danList3 = [];
    sumList = [];
    kuaList = [];
    killList = [];
    twoMa = [];
    jinDiff = [];
    evenSum = [];
    direct = {0: [], 1: [], 2: []};
    currDuanZu = {};
    lastDuanZu = {};
  }
}

class FilterResult {
  late List<String> zu3;
  late List<String> zu6;
  late List<String> direct;

  FilterResult({
    required this.zu3,
    required this.zu6,
    required this.direct,
  });

  resetResult() {
    zu3 = [];
    zu6 = [];
    direct = [];
  }

  bool isEmpty() {
    return zu3.isEmpty && zu6.isEmpty && direct.isEmpty;
  }
}

List<int> weekDan(DateTime date) {
  return weekDanTable[date.weekday]!;
}

bool filterDan(int i, int j, int k, List<int>? danList) {
  if (danList == null || danList.isEmpty) {
    return true;
  }
  return danList.contains(i) || danList.contains(j) || danList.contains(k);
}

bool filterKill(int i, int j, int k, List<int>? killList) {
  if (killList == null || killList.isEmpty) {
    return true;
  }
  return !killList.contains(i) &&
      !killList.contains(j) &&
      !killList.contains(k);
}

bool filterKua(int i, int j, int k, List<int>? kuaList) {
  if (kuaList == null || kuaList.isEmpty) {
    return true;
  }
  int maxVal = max(i, max(j, k));
  int minVal = min(i, min(j, k));
  return kuaList.contains(maxVal - minVal);
}

bool filterSum(int i, int j, int k, List<int>? sumList) {
  if (sumList == null || sumList.isEmpty) {
    return true;
  }
  int sum = i + j + k;
  return sumList.contains(sum);
}

int sumTail(List<int> index) {
  return (index[0] + index[1]) % 10;
}

List<int> twoCodeSum(codes) {
  int sumTail1 = sumTail([codes[0], codes[1]]);
  int sumTail2 = sumTail([codes[0], codes[2]]);
  int sumTail3 = sumTail([codes[1], codes[2]]);
  List<int> result = List.of({sumTail1, sumTail2, sumTail3});
  result.sort();
  return result;
}

List<int> towCodeDiff(codes) {
  int diff1 = abs(codes[0] - codes[1]);
  int diff2 = abs(codes[0] - codes[2]);
  int diff3 = abs(codes[1] - codes[2]);
  List<int> result = List.of({diff1, diff2, diff3});
  result.sort();
  return result;
}

bool twoDiffFilter(int i, int j, int k, List<int>? diffList) {
  if (diffList == null || diffList.isEmpty) {
    return true;
  }
  List<int> codeDiff = towCodeDiff([i, j, k]);
  return codeDiff
      .where((i) => diffList.contains(i))
      .isNotEmpty;
}

bool towSumFilter(int i, int j, int k, List<int>? sumList) {
  if (sumList == null || sumList.isEmpty) {
    return true;
  }
  List<int> codeSum = twoCodeSum([i, j, k]);
  return codeSum
      .where((i) => sumList.contains(i))
      .isNotEmpty;
}

bool isSameTwoMa(List<int> target, List<int> source) {
  target.sort();
  source.sort();

  var tStr = target.join('');
  var sStr = source.join('');
  return tStr == sStr;
}

bool isZu3(i, j, k) {
  return {i, j, k}.length == 2;
}

bool isZu6(i, j, k) {
  return {i, j, k}.length == 3;
}

bool twoMaIncludes(int i, int j, int k, List<int> twoMa) {
  return (twoMa.contains(i) && twoMa.contains(j)) ||
      (twoMa.contains(i) && twoMa.contains(k)) ||
      (twoMa.contains(j) && twoMa.contains(k));
}

bool twoMaFilter(int i, int j, int k, List<List<int>>? twoMa) {
  if (twoMa == null || twoMa.isEmpty || isZu3(i, j, k)) {
    return true;
  }
  return twoMa
      .where((e) => twoMaIncludes(i, j, k, e))
      .isNotEmpty;
}

bool patternFilter(int i, int j, int k, int? pattern) {
  if (pattern == null) {
    return true;
  }
  Set<int> set = {i, j, k};
  if (pattern == 3) {
    return set.length == 3;
  }
  if (pattern == 2) {
    return set.length == 2;
  }
  return set.length == 1;
}

bool itemFilter(int i, int j, int k, FilterDto filter) {
  if (!filterDan(i, j, k, filter.danList1)) {
    return false;
  }
  if (!filterDan(i, j, k, filter.danList2)) {
    return false;
  }
  if (!filterDan(i, j, k, filter.danList3)) {
    return false;
  }
  if (!twoMaFilter(i, j, k, filter.twoMa)) {
    return false;
  }
  if (!filterDuanZu(i, j, k, filter.currDuanZu)) {
    return false;
  }
  if (!filterDuanZu(i, j, k, filter.lastDuanZu)) {
    return false;
  }
  if (!filterSum(i, j, k, filter.sumList)) {
    return false;
  }
  if (!filterKua(i, j, k, filter.kuaList)) {
    return false;
  }
  if (!filterKill(i, j, k, filter.killList)) {
    return false;
  }
  if (!filterJinDiff(i, j, k, filter.jinDiff)) {
    return false;
  }
  return filterEvenSum(i, j, k, filter.evenSum);
}

List<String> filterDirect(FilterDto dto) {
  List<int> bai = dto.directItem(0),
      shi = dto.directItem(1),
      ge = dto.directItem(2);
  List<String> result = [];
  for (int i in bai) {
    for (int j in shi) {
      for (int k in ge) {
        if (!itemFilter(i, j, k, dto)) {
          continue;
        }
        List<int> value = List.from([i, j, k]);
        result.add(value.join(''));
      }
    }
  }
  return result;
}

FilterResult lotteryFilter(FilterDto dto) {
  if (dto.directNotEmpty()) {
    List<String> direct = filterDirect(dto);
    return FilterResult(
      zu3: [],
      zu6: [],
      direct: direct,
    );
  }
  Set<String> zu3 = {};
  Set<String> zu6 = {};
  for (int i = 0; i < 10; i++) {
    for (int j = 0; j < 10; j++) {
      for (int k = 0; k < 10; k++) {
        if (!itemFilter(i, j, k, dto)) {
          continue;
        }
        List<int> result = List.of({i, j, k})
          ..sort();
        String item = result.join('');
        if (isZu3(i, j, k)) {
          zu3.add(item);
        } else if (isZu6(i, j, k)) {
          zu6.add(item);
        }
      }
    }
  }
  return FilterResult(
    zu3: List.of(zu3),
    zu6: List.of(zu6),
    direct: [],
  );
}

bool filterEvenSum(int i, int j, int k, List<int> even) {
  if (even.isEmpty) {
    return true;
  }
  List<List<int>> evenList =
  even.map((e) => evenTable[e]!).expand((e) => e).toList();
  return evenList
      .where((e) =>
  (e.contains(i) && e.contains(j)) ||
      (e.contains(j) && e.contains(k)) ||
      (e.contains(i) && e.contains(k)))
      .isNotEmpty;
}

///
/// 奖号偶合信息
EvenSumInfo evenSumInfo(String lottery) {
  List<int> even = evenSum(lottery);
  var table = even.map((e) => evenTable[e]!).toList();
  var zu3 = <String>{},
      zu6 = <String>{};
  for (int i = 9; i <= 9; i++) {
    for (int j = 0; j < table.length; j++) {
      var element = table[j];
      for (int k = 0; k < element.length; k++) {
        var lotto = [...element[k], i]..sort();
        if (lotto.length == 2) {
          zu3.add(lotto.join(''));
        }
        if (lotto.length == 3) {
          zu6.add(lotto.join(''));
        }
      }
    }
  }
  return EvenSumInfo(
    even: even,
    zu3: zu3.toList(),
    zu6: zu6.toList(),
  );
}

List<int> evenSum(String lottery) {
  List<int> balls = lottery.split(' ').map((e) => int.parse(e)).toList();
  var segments = duanZu46(balls);
  if (segments[0].length == 6) {
    return segments[0].where((e) => e % 2 == 0).toList()
      ..sort();
  }
  return segments[1].where((e) => e % 2 == 0).toList()
    ..sort();
}

bool filterJinDiff(int i, int j, int k, List<int> diff) {
  if (diff.isEmpty) {
    return true;
  }
  List<List<int>> table =
  diff.map((e) => jinWeiTable[e]!).expand((e) => e).toList();
  return table
      .where((e) =>
  (e.contains(i) && e.contains(j)) ||
      (e.contains(j) && e.contains(k)) ||
      (e.contains(i) && e.contains(k)))
      .isNotEmpty;
}

///
/// 进位合差计算
JinWeiInfo jinWei({required String lottery, bool duiMa = true}) {
  List<int> diffList = twoDiff(lottery: lottery, duiMa: duiMa);
  List<List<List<int>>> table = diffList.map((e) => jinWeiTable[e]!).toList();
  var zu3 = <String>{},
      zu6 = <String>{};
  for (int i = 9; i <= 9; i++) {
    for (int j = 0; j < table.length; j++) {
      var element = table[j];
      for (int k = 0; k < element.length; k++) {
        var lotto = [...element[k], i]..sort();
        if (lotto.length == 2) {
          zu3.add(lotto.join(''));
        }
        if (lotto.length == 3) {
          zu6.add(lotto.join(''));
        }
      }
    }
  }
  return JinWeiInfo(
    diff: diffList,
    zu3: zu3.toList(),
    zu6: zu6.toList(),
  );
}

///
/// 进位和差计算
List<int> jinWeiDiff(String lottery) {
  List<int> balls = lottery.split(' ').map((e) => int.parse(e)).toList();
  int index = balls[1] % 3;
  return jinDiffList[index];
}

List<int> twoDiff({required String lottery, bool duiMa = true}) {
  List<int> balls = lottery.split(' ').map((e) => int.parse(e)).toList();
  var segments = duanZu46(balls);
  int sum1 = segments[0].reduce((c, e) => c + e);
  int sum2 = segments[1].reduce((c, e) => c + e);
  return [
    duiMa ? toDuiMa(sum1 % 10) : sum1 % 10,
    duiMa ? toDuiMa(sum2 % 10) : sum2 % 10,
  ];
}

int toDuiMa(int value) {
  return value <= 5 ? value : value - 5;
}

List<List<int>> duanZu46(List<int> balls) {
  List<int> set = List.from(Set.from(balls));
  if (set.length == 1) {
    List<int> index = duiMaZu(balls[0]);
    List<int> index1 = duiMaZu(balls[0] == 5 ? 1 : 0);
    List<int> segment1 = [...index, ...index1];
    List<List<int>> index2 = remainIndex([index[0], index1[0]]);
    List<int> segment2 = [];
    for (var e in index2) {
      segment2.addAll(e);
    }
    return [segment1, segment2];
  }
  if (set.length == 2) {
    if (abs(set[0] - set[1]) == 5) {
      if (set[0] + set[1] != 5) {
        var index = duiMaZu(set[0]);
        var index1 = duiMaZu(0);
        var segment1 = [...index, ...index1];
        var index2 = remainIndex([index[0], index1[0]]);
        var segment2 = index2.expand((e) => e).toList();
        return [segment1, segment2];
      }
      List<int> index = [0, 5],
          index1 = [1, 6];
      var segment1 = [...index, ...index1];
      var index2 = remainIndex([index[0], index1[0]]);
      var segment2 = index2.expand((e) => e).toList();
      return [segment1, segment2];
    }
    var index1 = duiMaZu(set[0]);
    var index2 = duiMaZu(set[1]);
    var segment1 = [
      ...index1,
      ...index2,
    ];
    var remain = remainIndex([index1[0], index2[0]]);
    var segment2 = remain.expand((e) => e).toList();
    return [segment1, segment2];
  }
  var values = zu6Filter(balls);
  if (values.length == 2) {
    var index1 = duiMaZu(values[0]);
    var index2 = duiMaZu(values[1]);
    var segment1 = [
      ...index1,
      ...index2,
    ];
    var remain = remainIndex([index1[0], index2[0]]);
    var segment2 = remain.expand((e) => e).toList();
    return [segment1, segment2];
  }
//组六计算
  var index = duiMaZu(balls[0]);
  var index1 = duiMaZu(balls[1]);
  var index2 = duiMaZu(balls[2]);
  var segment1 = [
    ...index,
    ...index1,
    ...index2,
  ];
  var remain = remainIndex([index[0], index1[0], index2[0]]);
  var segment2 = remain.expand((e) => e).toList();
  return [segment1, segment2];
}

///
/// 计算选三开奖号码胆码组
Num3LottoDanZu lotteryDanZu(String lottery) {
  List<int> balls =
  lottery.split(RegExp('\\s+')).map((e) => int.parse(e)).toList();
  List<List<int>> duiMa = lotteryDuiMa(balls);
  if (duiMa.length == 2) {
    List<List<int>> danList = danMaZu(duiMa);
    List<List<int>> zuHe = lotteryZuHe(danList);
    return Num3LottoDanZu(
      danZu: danList.expand((e) => e).toList()
        ..sort(),
      zuHe: zuHe,
    );
  }
  duiMa.sort((e1, e2) => e2[0] - e1[0]);
  List<List<int>> values = duiMa.sublist(0, 2);
  List<List<int>> danList = danMaZu(values);
  List<List<int>> zuHe = lotteryZuHe(danList);
  return Num3LottoDanZu(
    danZu: danList.expand((e) => e).toList()
      ..sort(),
    zuHe: zuHe,
  );
}

List<List<int>> remainIndex(List<int> indices) {
  return [0, 1, 2, 3, 4]
      .where((i) => !indices.contains(i))
      .map((i) => duiMaZu(i))
      .toList();
}

///
/// 计算号码对码组合
List<int> duiMaZu(int value) {
  if (value < 5) {
    return [value, value + 5];
  }
  return [value - 5, value];
}

///
/// 组合字符串
List<String> zuHeTxt(List<List<int>> values) {
  return values.map((e) => e.join('')).toList()
    ..sort();
}

///
/// 计算总体两码组合
List<List<int>> lotteryZuHe(List<List<int>> danMaZu) {
  Map<int, List<int>> group = oddEvenGroup(danMaZu);
  List<List<int>> result = [];
  result.addAll(calcZuHe(group[0]!, [0, 2, 4, 6, 8]));
  result.addAll(calcZuHe(group[1]!, [1, 3, 5, 7, 9]));
  return result;
}

///
/// 计算两码组合
List<List<int>> calcZuHe(List<int> values, List<int> all) {
  List<int> remain = all.where((e) => !values.contains(e)).toList();
  List<List<int>> result = [];
  result.add(values..sort());
  for (int i = 0; i < remain.length; i++) {
    for (int j = 0; j < values.length; j++) {
      result.add([values[j], remain[i]]..sort());
    }
  }
  return result;
}

///
/// 对码组求胆码组
List<List<int>> danMaZu(List<List<int>> duiMa) {
  return [
    duiMaZu((duiMa[0][0] + duiMa[0][1]) % 10),
    duiMaZu((duiMa[1][0] + duiMa[1][1]) % 10),
  ];
}

///
/// 胆码组奇偶分组
Map<int, List<int>> oddEvenGroup(List<List<int>> danZu) {
  List<int> odd = [],
      even = [];
  for (var e in danZu) {
    isOdd(e[0]) ? odd.add(e[0]) : even.add(e[0]);
    isOdd(e[1]) ? odd.add(e[1]) : even.add(e[1]);
  }
  return {0: even, 1: odd};
}

bool isOdd(value) {
  return value % 2 == 1;
}

///
/// 奖号对码化
List<List<int>> lotteryDuiMa(List<int> balls) {
  List<int> set = List.from(Set.from(balls));
  if (set.length == 1) {
    return [
      duiMaZu(balls[0]),
      duiMaZu(set[0] == 5 ? 1 : 0),
    ];
  }
  if (set.length == 2) {
    if (abs(set[0] - set[1]) == 5) {
      if (set[0] + set[1] != 5) {
        return [duiMaZu(set[0]), duiMaZu(0)];
      }
      return [
        [0, 5],
        [1, 6]
      ];
    }
    return [
      duiMaZu(set[0]),
      duiMaZu(set[1]),
    ];
  }
  List<int> values = zu6Filter(balls);
  if (values.length == 2) {
    return [
      duiMaZu(values[0]),
      duiMaZu(values[1]),
    ];
  }
  return [
    duiMaZu(values[0]),
    duiMaZu(values[1]),
    duiMaZu(values[2]),
  ];
}

///
/// 过滤掉组六中的对码号码
List<int> zu6Filter(List<int> balls) {
  if (abs(balls[0] - balls[1]) == 5) {
    return [balls[0], balls[2]];
  }
  if (abs(balls[0] - balls[2]) == 5 || abs(balls[1] - balls[2]) == 5) {
    return [balls[0], balls[1]];
  }
  return balls;
}

///
/// 绝对值计算
int abs(int value) {
  return value < 0 ? -value : value;
}

///
/// 码+对码+对码4邻码
List<int> neighbor6(int value) {
  int code = value < 5 ? value + 5 : value - 5;
  List<int> result = List.from([value, code]);
  result.add(code - 2 < 0 ? code - 2 + 10 : code - 2);
  result.add(code - 1 < 0 ? code - 1 + 10 : code - 1);
  result.add(code + 1 > 9 ? code + 1 - 10 : code + 1);
  result.add(code + 2 > 9 ? code + 2 - 10 : code + 2);
  result.sort();
  return result;
}

///
/// 2-2-6断组
List<List<int>> duanZu(int value) {
  List<int> segment = neighbor6(value);
  List<int> remain = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
      .where((e) => !segment.contains(e))
      .toList()
    ..sort();
  List<int> segment1 = remain.where((e) => e % 2 == 0).toList();
  List<int> segment2 = remain.where((e) => e % 2 == 1).toList();
  return [segment, segment1, segment2];
}

///
/// 断组字符串
String duanZuTxtItem(List<List<int>> table) {
  return '${table[0].join('')}-${table[1].join('')}-${table[2].join('')}';
}

///
/// 奖号百十个位断组
Map<int, List<List<int>>> lotteryDuanZu(String lottery) {
  List<int> codes =
  List.from(Set.from(lottery.split(' ').map((e) => int.parse(e))));
  Map<int, List<List<int>>> result = {};
  for (int i = 0; i < codes.length; i++) {
    result[i] = duanZu(codes[i]);
  }
  return result;
}

Map<int, String> duanZuTxt(Map<int, List<List<int>>> table) {
  Map<int, String> result = {};
  for (var key in table.keys) {
    result[key] = duanZuTxtItem(table[key]!);
  }
  return result;
}

bool filterDuanZu(int i, int j, int k, Map<int, DuanZuInfo> duanZu) {
  Map<int, DuanZuInfo> map =
  Map.fromEntries(duanZu.entries.where((e) => e.value.excludes.isNotEmpty));
  if (map.isEmpty) {
    return true;
  }
  List<int> keys = map.keys.toList();
  var balls = List.from({i, j, k})
    ..sort();
  var value = balls.join('');
  if (keys.length == 1) {
    return !duanZu[keys[0]]!.excludes.contains(value);
  }
  if (keys.length == 2) {
    if (!duanZu[keys[0]]!.excludes.contains(value) &&
        !duanZu[keys[1]]!.excludes.contains(value)) {
      return true;
    }
    if (!duanZu[keys[0]]!.excludes.contains(value)) {
      return true;
    }
    return !duanZu[keys[1]]!.excludes.contains(value);
  }
  if (!duanZu[keys[0]]!.excludes.contains(value) &&
      !duanZu[keys[1]]!.excludes.contains(value) &&
      !duanZu[keys[2]]!.excludes.contains(value)) {
    return true;
  }
  if (!duanZu[keys[0]]!.excludes.contains(value) &&
      !duanZu[keys[1]]!.excludes.contains(value)) {
    return true;
  }
  if (!duanZu[keys[0]]!.excludes.contains(value) &&
      !duanZu[keys[2]]!.excludes.contains(value)) {
    return true;
  }
  return !duanZu[keys[1]]!.excludes.contains(value) &&
      !duanZu[keys[2]]!.excludes.contains(value);
}

Map<int, DuanZuInfo> duanZuInfo(String lottery) {
  Map<int, List<List<int>>> table = lotteryDuanZu(lottery);
  Map<int, String> text = duanZuTxt(table);
  Map<int, DuanZuInfo> result = {};
  for (var key in table.keys) {
    result[key] = DuanZuInfo(
      txt: text[key]!,
      table: table[key]!,
      excludes: [],
    );
  }
  return result;
}

///
/// 断组计算排除号码
List<String> duanZuExcludes(List<List<int>> table) {
  List<String> data = [];
  for (int i = 0; i < table[0].length; i++) {
    for (int j = 0; j < table[1].length; j++) {
      for (int k = 0; k < table[2].length; k++) {
        List<int> result = List.from({table[0][i], table[1][j], table[2][k]});
        result.sort();
        data.add(result.join(''));
      }
    }
  }
  return data;
}
