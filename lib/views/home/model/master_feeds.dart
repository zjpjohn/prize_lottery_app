import 'package:prize_lottery_app/base/model/enum_value.dart';
import 'package:prize_lottery_app/base/model/master_value.dart';
import 'package:prize_lottery_app/utils/date_util.dart';

///
///
///
class MasterFeeds {
  late int id;
  late EnumValue type;
  late MasterValue master;
  late String field;
  late EnumValue feedType;
  late String rateText;
  late String hitText;
  late String period;
  late int renew;
  late String renewPeriod;
  late String timestamp;
  late TimeDelta delta;
  String? masterText;

  MasterFeeds.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    type = EnumValue.fromJson(json['type']);
    master = MasterValue.fromJson(json['master']);
    field = json['field'];
    feedType = EnumValue.fromJson(json['feedType']);
    rateText = json['rateText'];
    hitText = json['hitText'];
    period = json['period'];
    renew = json['renew'];
    renewPeriod = json['renewPeriod'];
    timestamp = json['timestamp'];
    delta = _timeDelta();
    masterText = _masterText();
  }

  TimeDelta _timeDelta() {
    DateTime time = DateUtil.parse(timestamp, pattern: 'yyyy/MM/dd HH:mm:ss');
    return DateUtil.timeDeltaText(time);
  }

  String _masterText() {
    if (renew == 0) {
      return hitText;
    }
    return '第$renewPeriod期${type.description}推荐预测方案已更新';
  }
}
