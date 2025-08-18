import 'package:prize_lottery_app/base/model/enum_value.dart';

///
///
class UserInvite {
  ///邀请码
  late String code;

  ///邀请链接
  late String invUri;

  ///流量主级别
  late EnumValue agent;

  /// 流量合作伙伴开关
  late int partner;

  ///是否申请中
  late int applying;

  ///累计邀请人数
  late int invites;

  /// 累计获得奖励
  late int rewards;

  ///邀请账户状态
  late EnumValue state;

  ///创建时间
  late String gmtCreate;

  UserInvite.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    invUri = json['invUri'];
    agent = EnumValue.fromJson(json['agent']);
    partner = json['partner'];
    applying = json['applying'];
    invites = json['invites'] ?? 0;
    rewards = json['rewards'] ?? 0;
    state = EnumValue.fromJson(json['state']);
    gmtCreate = json['gmtCreate'] ?? '';
  }
}
