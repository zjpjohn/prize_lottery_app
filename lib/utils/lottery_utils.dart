import 'dart:math';

class LotteryUtils {
  ///
  /// 计算开奖号码和值
  static int sum(List<int> balls) {
    return balls.reduce((v, e) => v + e);
  }

  ///
  /// 计算开奖号码连号
  static int series(List<int> balls) {
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

  ///
  /// 计算开奖号码跨度
  static int kua(List<int> balls) {
    int _min = balls[0], _max = balls[0];
    for (int i = 1; i < balls.length; i++) {
      int ball = balls[i];
      if (_min > ball) {
        _min = ball;
      }
      if (_max < ball) {
        _max = ball;
      }
    }
    return _max - _min;
  }

  static Map<int, int> groupCount(List<int> balls) {
    Map<int, int> group = {};
    for (var e in balls) {
      group[e] = group[e] == null ? 1 : group[e]! + 1;
    }
    return group;
  }

  static String p5Pattern(List<int> balls) {
    Set<int> distinct = {}..addAll(balls);
    Map<int, int> group = groupCount(balls);
    if (distinct.length == 1) {
      return '五同';
    }
    if (distinct.length == 2) {
      return group[0] == 1 ? '四同' : '三同二同';
    }
    if (distinct.length == 3) {
      return group.entries.any((e) => e.value == 3) ? '三同' : '两组二同';
    }
    if (distinct.length == 4) {
      return '二同';
    }
    return '五不同';
  }

  ///
  /// 计算选三开奖形态：1-豹子,2-组三,3-组六
  static int n3Pattern(List<int> balls) {
    Set<int> distinctive = {}..addAll(balls);
    return distinctive.length;
  }

  ///
  /// 号码奇偶比
  static String oddEven(List<int> balls) {
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

  ///
  /// 计算质合比
  static String primeComposite(List<int> balls) {
    int prime = 0, composite = 0;
    for (var ball in balls) {
      if (isComposite(ball)) {
        composite++;
      } else {
        prime++;
      }
    }
    return '$prime:$composite';
  }

  static bool isComposite(int x) {
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
}
