import 'package:prize_lottery_app/base/model/enum_value.dart';
import 'package:prize_lottery_app/utils/tools.dart';

///
///
class MasterDetail {
  ///
  late String masterId;

  ///
  late String name;

  ///
  late String address;

  ///
  late String avatar;

  ///
  late String description;

  ///是否已关注专家
  late int focused;

  ///浏览量
  late int browse;

  ///订阅量
  late int subscribe;

  ///搜索量
  late int searches;

  ///
  late List<LotteryItem> lotteries;

  MasterDetail.fromJson(Map<String, dynamic> json) {
    masterId = json['masterId'];
    name = json['name'];
    avatar = json['avatar'];
    address = json['address'] ?? '';
    description = json['description'] ?? '';
    focused = json['focused'] ?? 0;
    browse = Tools.randLimit(json['browse'] ?? 0, 100);
    subscribe = Tools.randLimit(json['subscribe'] ?? 0, 100);
    searches = Tools.randLimit(json['searches'] ?? 0, 100);
    List list = json['lotteries'];
    lotteries = list.map((e) => LotteryItem.fromJson(e)).toList();
  }
}

class LotteryItem {
  late int level;
  late String latest;
  late EnumValue lottery;

  LotteryItem.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    latest = json['latest'];
    lottery = EnumValue.fromJson(json['lottery']);
  }
}
