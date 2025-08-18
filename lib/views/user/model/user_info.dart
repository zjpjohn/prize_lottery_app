import 'package:prize_lottery_app/base/model/enum_value.dart';

class UserInfo {
  late int id;
  late String nickname;
  late String phone;
  late String avatar;
  late String wxId;
  late String aliId;
  late int expert;
  late EnumValue state;
  late EnumValue channel;
  late String gmtCreate;

  UserInfo.fromJson(Map json) {
    id = int.parse(json['id']);
    nickname = json['nickname'] ?? '';
    phone = json['phone'] ?? '';
    avatar = json['avatar'] ?? '';
    wxId = json['wxId'] ?? '';
    aliId = json['aliId'] ?? '';
    expert = json['expert'] ?? 0;
    state = EnumValue.fromJson(json['state']);
    channel = EnumValue.fromJson(json['channel']);
    gmtCreate = json['gmtCreate'] ?? '';
  }
}

///
///
/// 邀请用户信息
class InvitedUser {
  late String nickname;
  late String phone;
  late String avatar;
  late EnumValue channel;
  late String gmtCreate;

  InvitedUser.fromJson(Map json) {
    nickname = json['nickname'] ?? '';
    phone = json['phone'] ?? '';
    avatar = json['avatar'] ?? '';
    channel = EnumValue.fromJson(json['channel']);
    gmtCreate = json['gmtCreate'] ?? '';
  }
}
