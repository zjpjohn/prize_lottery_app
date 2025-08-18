import 'package:prize_lottery_app/base/model/enum_value.dart';
import 'package:prize_lottery_app/utils/date_util.dart';

///
/// 时间转换
///
String timeConvert(String time) {
  DateTime dateTime = DateUtil.parse(time, pattern: 'yyyy/MM/dd HH:mm:ss');
  DateTime current = DateTime.now();
  if (current.day == dateTime.day) {
    return '今天';
  }
  if (current.day - 1 == dateTime.day) {
    return '昨天';
  }
  return DateUtil.formatDate(dateTime, format: 'MM-dd');
}

///
///
///
class ChannelMessage {
  late String name;
  late String channel;
  late String cover;
  late int type;
  late String remark;
  late int remind;
  late int read;
  late String title;
  int local = 1;
  String? latestTime;
  String? timeText;

  ChannelMessage.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    channel = json['channel'];
    cover = json['cover'];
    type = json['type'];
    remark = json['remark'];
    remind = json['remind'];
    read = json['read'];
    title = json['title'] ?? '';
    latestTime = json['latestTime'];
    if (latestTime != null && latestTime!.isNotEmpty) {
      timeText = timeConvert(latestTime!);
    }
  }

  String subtitle() {
    return title.trim().isNotEmpty ? title.trim() : remark;
  }
}

///
/// 站内信消息
///
class MessageInfo {
  late int id;
  late String title;
  late Map<String, String> content;
  late EnumValue type;
  late String channel;
  late String objId;
  late String objType;
  late String objAction;
  late String gmtCreate;
  late String timeText;

  MessageInfo.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    title = json['title'];
    content = Map.from(json['content']);
    type = EnumValue.fromJson(json['type']);
    channel = json['channel'];
    objId = json['objId'];
    objType = json['objType'];
    objAction = json['objAction'];
    gmtCreate = json['gmtCreate'];
    timeText = timeConvert(gmtCreate);
  }
}
