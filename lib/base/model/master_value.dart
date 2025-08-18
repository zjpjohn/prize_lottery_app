import 'package:prize_lottery_app/utils/tools.dart';

///
///
class MasterValue {
  ///
  late String masterId;

  ///
  late String name;

  ///
  late String avatar;

  ///浏览量
  int browse = 0;

  ///订阅量
  int subscribe = 0;

  ///搜索量
  int searches = 0;

  MasterValue(this.masterId, this.name, this.avatar);

  MasterValue.fromJson(Map<String, dynamic> json) {
    masterId = json['masterId'] ?? '';
    name = json['name'];
    avatar = json['avatar'] ?? '';
    browse = Tools.randLimit(json['browse'] ?? 0, 500);
    subscribe = Tools.randLimit(json['subscribe'] ?? 0, 500);
    searches = Tools.randLimit(json['searches'] ?? 0, 500);
  }
}
