import 'package:prize_lottery_app/base/model/enum_value.dart';

///
///
///
class LotteryPick {
  ///
  ///选号记录标识
  late int id;

  ///选号期号
  late String period;

  ///彩票类型
  late EnumValue lottery;

  ///时间戳
  late String timestamp;

  ///选三型选号
  LotteryN3Pick? n3Pick;

  ///红蓝球选号
  LotteryRbPick? rbPick;

  LotteryPick.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    period = json['period'];
    timestamp = json['timestamp'];
    lottery = EnumValue.fromJson(json['lottery']);
    if (lottery.value == 'fc3d' || lottery.value == 'pl3') {
      n3Pick = LotteryN3Pick.from(json['reds']);
    } else {
      rbPick = LotteryRbPick.from(red: json['reds'], blue: json['blues']);
    }
  }
}

///
/// 选三型选号模型
///
class LotteryN3Pick {
  List<String> bai = [];
  List<String> shi = [];
  List<String> ge = [];

  LotteryN3Pick();

  LotteryN3Pick.from(dynamic pick) {
    List data = pick;
    bai = data[0].cast<String>();
    shi = data[1].cast<String>();
    ge = data[2].cast<String>();
  }
}

///
/// 红蓝球型选号
///
class LotteryRbPick {
  List<String> reds = [];
  List<String> blues = [];

  LotteryRbPick();

  LotteryRbPick.from({dynamic red, dynamic blue}) {
    List redBalls = red;
    reds = redBalls[0].cast<String>();
    if (blue != null) {
      blues = blue.cast<String>();
    }
  }
}
