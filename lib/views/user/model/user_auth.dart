import 'package:prize_lottery_app/base/model/enum_value.dart';

///
/// 用户登录授权信息
///
class AuthInfo {
  ///
  /// 授权登录token
  String token = '';

  ///token过期时间
  int expire = 0;

  ///登录时间
  String loginTime = '';

  ///授权用户信息
  AuthUser? user;

  AuthInfo.fromJson(Map<String, dynamic> json) {
    token = json['token'] ?? '';
    expire = int.parse(json['expire']);
    loginTime = json['loginTime'];
    user = AuthUser.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['token'] = token;
    json['expire'] = expire;
    json['loginTime'] = loginTime;
    json['user'] = user;
    return json;
  }
}

class AuthUser {
  ///用户标识，base64编码
  String uid = '';

  ///用户昵称
  String nickname = '';

  ///登录手机号
  String phone = '';

  ///用户头像
  String avatar = '';

  ///用户邀请码
  String code = '';

  ///用户邀请链接
  String inviteUri = '';

  ///预测专家
  int expert = 0;

  ///注册渠道
  EnumValue? channel;

  ///是否绑定微信账号
  bool wxBind = false;

  ///是否绑定支付宝账户
  bool aliBind = false;

  AuthUser.fromJson(Map json) {
    uid = json['uid'];
    nickname = json['nickname'];
    phone = json['phone'];
    avatar = json['avatar'];
    code = json['code'] ?? '';
    inviteUri = json['inviteUri'] ?? '';
    expert = json['expert'] ?? 0;
    wxBind = json['wxBind'] ?? false;
    aliBind = json['aliBind'] ?? false;
    if (json['channel'] != null) {
      channel = EnumValue.fromJson(json['channel']);
    }
  }

  Map toJson() {
    Map json = {};
    json['uid'] = uid;
    json['nickname'] = nickname;
    json['phone'] = phone;
    json['avatar'] = avatar;
    json['code'] = code;
    json['inviteUri'] = inviteUri;
    json['expert'] = expert;
    json['channel'] = channel;
    json['wxBind'] = wxBind;
    json['aliBind'] = aliBind;
    return json;
  }
}
