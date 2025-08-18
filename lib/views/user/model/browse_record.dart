import 'package:prize_lottery_app/base/model/enum_value.dart';
import 'package:prize_lottery_app/base/model/master_value.dart';
import 'package:prize_lottery_app/utils/date_util.dart';

///
///
class RecentBrowseRecord {
  ///
  /// 本周浏览总次数
  int count = 0;

  ///最近浏览记录最多5条
  List<BrowseRecord> records = [];

  RecentBrowseRecord();

  RecentBrowseRecord.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    List list = json['records'];
    records = list.map((e) => BrowseRecord.fromJson(e)).toList();
  }
}

///
///
class BrowseRecord {
  ///
  late int id;

  ///
  late int userId;

  ///
  late String period;

  ///
  late EnumValue type;

  ///
  late String sourceId;

  ///
  late EnumValue source;

  ///
  MasterValue? master;

  ///
  late String gmtCreate;

  ///记录浏览时间
  late DateTime createTime;

  BrowseRecord.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    userId = int.parse(json['userId']);
    period = json['period'];
    type = EnumValue.fromJson(json['type']);
    sourceId = json['sourceId'];
    source = EnumValue.fromJson(json['source']);
    gmtCreate = json['gmtCreate'];
    createTime = DateUtil.parse(gmtCreate, pattern: "yyyy/MM/dd HH:mm");
    if (json['master'] != null) {
      master = MasterValue.fromJson(json['master']);
    }
  }
}
