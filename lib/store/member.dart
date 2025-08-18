import 'package:get/get.dart';
import 'package:prize_lottery_app/env/log_profile.dart';
import 'package:prize_lottery_app/store/user.dart';
import 'package:prize_lottery_app/utils/storage.dart';
import 'package:prize_lottery_app/views/user/model/user_member.dart';
import 'package:prize_lottery_app/views/user/repository/member_repository.dart';

///
/// 本地存储会员信息key
const memberKey = 'user_member';

class MemberStore extends GetxController {
  static MemberStore? _instance;

  factory MemberStore() {
    MemberStore._instance ??= Get.put<MemberStore>(MemberStore._initialize());
    return MemberStore._instance!;
  }

  MemberStore._initialize() {
    Map? json = Storage().getObject(memberKey);
    if (json != null) {
      _member = UserMember.fromJson(json);
    }
  }

  ///会员信息
  UserMember? _member;

  UserMember? get member => _member;

  set member(UserMember? member) {
    _member = member;
    if (_member != null) {
      Storage().putObject(memberKey, _member!);
    }
    update();
  }

  Future<void> refreshAuthed() async {
    if (UserStore().authToken != '') {
      refreshIfNull();
    }
  }

  Future<void> refreshMember() async {
    try {
      member = await MemberRepository.member();
    } catch (error) {
      logger.e(error);
    }
  }

  Future<void> refreshIfNull() async {
    if (member == null) {
      refreshMember();
    }
  }

  bool hasMember() {
    return member != null;
  }

  ///
  /// 会员套餐剩余天数
  /// days>0 表示还剩多少天过期
  /// days<0 表示已过期多少天
  int? remainDays() {
    if (member == null) {
      return null;
    }
    DateTime expireAt = member!.expireTime;
    return expireAt.difference(DateTime.now()).inDays;
  }

  ///
  /// 判断会员是否已过期
  bool isExpired() {
    if (_member == null) {
      return true;
    }
    DateTime expireAt = member!.expireTime;
    return expireAt.isBefore(DateTime.now());
  }

  ///
  /// 会员特权文字描述
  String memberText() {
    int? days = remainDays();
    if (days == null) {
      return '开通系统会员服务，全场内容随心看';
    }
    if (days > 0) {
      if (days > 7) {
        return '您的会员服务有效期截止${member!.expireTime.year}年${member!.expireTime.month}月${member!.expireTime.day}日';
      }
      return '您的会员服务将在$days天后过期，请您及时续费';
    }
    if (days == 0) {
      return '您的会员服务今日过期，请您及时续费';
    }
    return '您的会员服务已过期${days.abs()}天，请您及时续费';
  }

  String buttonText() {
    return member == null ? '领取会员' : '续费会员';
  }
}
