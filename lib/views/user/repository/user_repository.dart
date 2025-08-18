import 'dart:async';

import 'package:prize_lottery_app/base/model/page_result.dart';
import 'package:prize_lottery_app/utils/request.dart';
import 'package:prize_lottery_app/views/user/model/auth_mobile.dart';
import 'package:prize_lottery_app/views/user/model/balance_log.dart';
import 'package:prize_lottery_app/views/user/model/browse_record.dart';
import 'package:prize_lottery_app/views/user/model/sign_info.dart';
import 'package:prize_lottery_app/views/user/model/user_agent_apply.dart';
import 'package:prize_lottery_app/views/user/model/user_agent_rule.dart';
import 'package:prize_lottery_app/views/user/model/user_auth.dart';
import 'package:prize_lottery_app/views/user/model/user_balance.dart';
import 'package:prize_lottery_app/views/user/model/user_info.dart';
import 'package:prize_lottery_app/views/user/model/user_invite.dart';
import 'package:prize_lottery_app/views/user/model/user_withdraw.dart';

class UserInfoRepository {
  ///
  /// 发送短信验证码
  static Future<void> sendSms({
    required String phone,
    required String channel,
  }) {
    return HttpRequest().post(
      '/ucenter/mobile/sms',
      params: {'phone': phone, 'channel': channel},
    ).then((value) => null);
  }

  ///
  /// 一键登录换取手机号
  static Future<AuthMobile> authMobile(String token) {
    return HttpRequest().get(
      '/ucenter/mobile/',
      params: {'token': token},
    ).then((value) => AuthMobile.fromJson(value.data));
  }

  ///
  /// 重置登录密码
  static Future<void> resetPassword(
      {required String code,
      required String password,
      required String confirm}) {
    return HttpRequest().put(
      '/ucenter/app/user/reset',
      data: {
        'code': code,
        'password': password,
        'confirm': confirm,
      },
    ).then((_) => null);
  }

  ///
  /// 授权登录
  static Future<AuthInfo> authLogin({
    required String deviceId,
    required String phone,
    required String code,
    String? authKey,
    int? channel,
    String? invCode,
  }) {
    return HttpRequest().post(
      '/ucenter/app/user/auth',
      params: {'type': 1},
      data: {
        'deviceId': deviceId,
        'phone': phone,
        'code': code,
        'authKey': authKey,
        'channel': channel ?? 3,
        'invite': invCode,
      },
    ).then((value) => AuthInfo.fromJson(value.data));
  }

  ///
  /// 密码授权登录
  static Future<AuthInfo> pwdAuth({
    required String deviceId,
    required String phone,
    required String password,
    String? authKey,
    int? channel,
  }) {
    return HttpRequest().post(
      '/ucenter/app/user/auth',
      params: {'type': 3},
      data: {
        'deviceId': deviceId,
        'phone': phone,
        'password': password,
        'authKey': authKey,
        'channel': channel ?? 3,
      },
    ).then((value) => AuthInfo.fromJson(value.data));
  }

  ///
  /// 一键快速登录
  ///
  static Future<AuthInfo> quickAuth({
    required String deviceId,
    required String phone,
    required String nonceStr,
    required String signature,
    String? authKey,
    int? channel,
    String? invCode,
  }) {
    return HttpRequest().post(
      '/ucenter/app/user/auth',
      params: {'type': 2},
      data: {
        'deviceId': deviceId,
        'phone': phone,
        'nonceStr': nonceStr,
        'signature': signature,
        'authKey': authKey,
        'channel': channel,
        'invite': invCode,
      },
    ).then((value) => AuthInfo.fromJson(value.data));
  }

  ///
  /// 用户退出登录
  ///
  static Future<void> loginOut() {
    return HttpRequest()
        .post('/ucenter/app/user/loginOut')
        .then((value) => null)
        .catchError((error) => null);
  }

  ///
  /// 查询用户详细信息
  ///
  static Future<UserInfo> userInfo() {
    return HttpRequest()
        .get('/ucenter/app/user')
        .then((value) => UserInfo.fromJson(value.data));
  }

  ///
  /// 查询账户余额详情
  ///
  static Future<UserBalance> userBalance() {
    return HttpRequest()
        .get('/ucenter/app/user/balance')
        .then((value) => UserBalance.fromJson(value.data))
        .catchError((error) => Future.value(UserBalance.fromJson({})));
  }

  ///
  /// 查询指定彩种最近浏览的记录信息
  ///
  static Future<RecentBrowseRecord> recentBrowse(String type) {
    return HttpRequest()
        .get('/slotto/app/browse/recent', params: {'type': type})
        .then((value) => RecentBrowseRecord.fromJson(value.data))
        .catchError((error) => Future.value(RecentBrowseRecord()));
  }

  ///
  /// 分页查询浏览记录
  ///
  static Future<PageResult<BrowseRecord>> browseRecords(
      {required DateTime timestamp,
      String? type,
      int page = 1,
      int limit = 10}) {
    return HttpRequest().get(
      '/slotto/app/browse/list',
      params: {
        'type': type,
        'current': timestamp.millisecondsSinceEpoch,
        'page': page,
        'limit': limit,
      },
    ).then(
      (value) => PageResult.fromJson(
        json: value.data,
        handle: (e) => BrowseRecord.fromJson(e),
      ),
    );
  }

  ///
  /// 分页查询余额账户日志
  ///
  static Future<PageResult<BalanceLog>> balanceLogs({
    required int direct,
    required int type,
    int page = 1,
    int limit = 10,
  }) {
    return HttpRequest().get(
      '/ucenter/app/user/balance/logs',
      params: {
        'direct': direct,
        'type': type,
        'page': page,
        'limit': limit,
      },
    ).then(
      (value) => PageResult.fromJson(
        json: value.data,
        handle: (e) => BalanceLog.fromJson(e),
      ),
    );
  }

  ///
  /// 积分兑换记录
  ///
  static Future<PageResult<BalanceLog>> couponLogs(
      {int page = 1, int limit = 10}) {
    return HttpRequest().get(
      '/ucenter/app/user/coupon/exchange/logs',
      params: {'page': page, 'limit': limit},
    ).then(
      (value) => PageResult.fromJson(
        json: value.data,
        handle: (e) => BalanceLog.fromJson(e),
      ),
    );
  }

  ///
  /// 用户消费金币记录
  ///
  static Future<PageResult<BalanceLog>> consumeRecords(
      {int page = 1, int limit = 10}) {
    return HttpRequest().get(
      '/ucenter/app/user/consume/logs',
      params: {'page': page, 'limit': limit},
    ).then(
      (value) => PageResult.fromJson(
        json: value.data,
        handle: (e) => BalanceLog.fromJson(e),
      ),
    );
  }

  ///
  /// 提现记录查询
  ///
  static Future<PageResult<WithdrawRecord>> withdrawRecords({
    int page = 1,
    int limit = 10,
  }) {
    return HttpRequest().get('/ucenter/app/user/withdraw/list', params: {
      'page': page,
      'limit': limit,
    }).then(
      (value) => PageResult.fromJson(
        json: value.data,
        handle: (e) => WithdrawRecord.fromJson(e),
      ),
    );
  }

  ///
  /// 积分兑换
  ///
  static Future<ExchangeResult> couponExchange() {
    return HttpRequest()
        .post('/ucenter/app/user/coupon')
        .then((value) => ExchangeResult.fromJson(value.data));
  }

  ///
  /// 用户邀请信息
  ///
  static Future<UserInvite> userInvite() {
    return HttpRequest()
        .get('/ucenter/app/invite/')
        .then((value) => UserInvite.fromJson(value.data));
  }

  ///
  /// 用户流量主规则
  ///
  static Future<UserAgentRule> agentRule() {
    return HttpRequest()
        .get('/ucenter/app/invite/rule')
        .then((value) => UserAgentRule.fromJson(value.data));
  }

  ///
  /// 查询系统全部生效的流量主规则
  ///
  static Future<List<UserAgentRule>> usingAgentRules() {
    return HttpRequest().get('/ucenter/app/invite/rule/using').then((value) {
      List list = value.data;
      return list.map((e) => UserAgentRule.fromJson(e)).toList();
    });
  }

  ///
  /// 申请成为流量主
  ///
  static Future<void> agentApply() {
    return HttpRequest()
        .post('/ucenter/app/agent/apply/')
        .then((value) => null);
  }

  ///
  /// 取消流量主申请
  ///
  static Future<void> cancelApply({required int id}) {
    return HttpRequest()
        .put('/ucenter/app/agent/apply/$id')
        .then((value) => null);
  }

  ///
  /// 用户流量主申请列表
  ///
  static Future<List<UserAgentApply>> agentApplies() {
    return HttpRequest().get('/ucenter/app/agent/apply/list').then((value) {
      List list = value.data;
      return list.map((e) => UserAgentApply.fromJson(e)).toList();
    });
  }

  ///
  /// 查询邀请用户集合
  ///
  static Future<PageResult<InvitedUser>> inviteUsers(
      {int page = 1, int limit = 10}) {
    return HttpRequest().get(
      '/ucenter/app/invite/users',
      params: {'page': page, 'limit': limit},
    ).then(
      (value) => PageResult.fromJson(
        json: value.data,
        handle: (e) => InvitedUser.fromJson(e),
      ),
    );
  }
}
