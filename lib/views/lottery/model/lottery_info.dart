///
///
class LotteryInfo {
  ///
  late String type;

  ///
  late String period;

  ///
  String com = '';

  ///
  String last = '';

  ///
  int lastDelta = 0;

  ///
  String red = '';

  ///
  String blue = '';

  ///
  String shi = '';

  ///
  String kai = '';

  ///
  String lotDate = '';

  LotteryInfo.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    period = json['period'];
    red = json['red'] ?? '';
    blue = json['blue'] ?? '';
    shi = json['shi'] ?? '';
    kai = json['kai'] ?? '';
    lotDate = json['lotDate'] ?? '';
    com = json['com'] ?? '';
    last = json['last'] ?? '';
    lastDelta = json['lastDelta'] ?? 0;
  }

  ///
  /// 是否为选三类型
  bool isN3Type() {
    return type == 'fc3d' || type == 'pl3';
  }

  List<String> redBalls() {
    String trimmed = red.trim();
    return trimmed.isEmpty ? [] : trimmed.trim().split(RegExp('\\s+'));
  }

  List<String> blueBalls() {
    String trimmed = blue.trim();
    return trimmed.isEmpty ? [] : trimmed.split(RegExp('\\s+'));
  }

  List<String> shiBalls() {
    String trimmed = shi.trim();
    return trimmed.isEmpty ? [] : trimmed.trim().split(RegExp('\\s+'));
  }
}

class FairTrial {
  ///
  late String type;

  ///
  late String period;

  ///
  String ball = '';

  FairTrial.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    period = json['period'];
    ball = json['ball'] ?? '';
  }

  List<String> balls() {
    String trimmed = ball.trim();
    return trimmed.isEmpty ? [] : trimmed.trim().split(RegExp('\\s+'));
  }
}

class Num3LottoFollow {
  late String period;
  late String red;
  late String last1;
  late String last2;
  late String next1;
  late String next2;
  int? id;
  String lotDate = '';

  Num3LottoFollow.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    period = json['period'];
    lotDate = json['lotDate'];
    red = json['red'];
    last1 = json['last1'] ?? '';
    last2 = json['last2'] ?? '';
    next1 = json['next1'] ?? '';
    next2 = json['next2'] ?? '';
  }

  Num3LottoFollow({
    required this.period,
    required this.red,
    required this.last1,
    required this.last2,
    required this.next1,
    required this.next2,
  });

  static List<Num3LottoFollow> mock() {
    return [
      Num3LottoFollow(
        period: '2023003',
        red: '5 9 6',
        last1: '8 5 0',
        last2: '',
        next1: '3 9 8',
        next2: '6 0 9',
      ),
    ];
  }
}
