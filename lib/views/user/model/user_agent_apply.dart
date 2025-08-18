import 'package:prize_lottery_app/base/model/enum_value.dart';

///
///
class UserAgentApply {
  late int id;
  late int userId;
  late EnumValue state;
  late String gmtCreate;
  late String gmtModify;
  String? remark;

  UserAgentApply.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    userId = int.parse(json['userId']);
    state = EnumValue.fromJson(json['state']);
    gmtCreate = json['gmtCreate'];
    gmtModify = json['gmtModify'];
    remark = json['remark'] ?? '';
  }
}
