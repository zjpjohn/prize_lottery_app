import 'package:prize_lottery_app/base/model/page_result.dart';
import 'package:prize_lottery_app/utils/request.dart';
import 'package:prize_lottery_app/views/user/model/user_member.dart';

///
///
class MemberRepository {
  ///
  /// 查询用户会员信息
  static Future<UserMember> member() {
    return HttpRequest()
        .get('/ucenter/app/user/member')
        .then((value) => UserMember.fromJson(value.data));
  }

  ///
  /// 分页查询会员续费记录
  static Future<PageResult<UserMemberLog>> memberLogs(
      {int page = 1, int limit = 10}) {
    return HttpRequest().get('/ucenter/app/user/member/log', params: {
      'page': page,
      'limit': limit
    }).then((value) => PageResult.fromJson(
          json: value.data,
          handle: (value) => UserMemberLog.fromJson(value),
        ));
  }

  ///
  /// 查询平台会员套餐集合
  static Future<List<MemberPackage>> memberPackage() {
    return HttpRequest().get('/ucenter/app/pack/list').then((value) {
      return (value.data as List)
          .map((e) => MemberPackage.fromJson(e))
          .toList();
    });
  }

  ///
  /// 查询会员套餐特权集合
  static Future<List<MemberPrivilege>> memberPrivileges() {
    return HttpRequest().get('/ucenter/app/pack/privilege/list').then((value) {
      return (value.data as List)
          .map((e) => MemberPrivilege.fromJson(e))
          .toList();
    });
  }
}
