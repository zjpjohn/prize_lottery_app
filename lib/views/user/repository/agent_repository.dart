import 'package:prize_lottery_app/base/model/page_result.dart';
import 'package:prize_lottery_app/utils/request.dart';
import 'package:prize_lottery_app/views/user/model/agent_account.dart';
import 'package:prize_lottery_app/views/user/model/user_withdraw.dart';

///
/// 流量主接口
///
class AgentRepository {
  ///
  /// 流量主账户信息
  static Future<AgentAccount> agentAccount() {
    return HttpRequest()
        .get('/ucenter/app/agent/acct')
        .then((value) => AgentAccount.fromJson(value.data));
  }

  ///
  /// 查询流量主收益统计数据
  static Future<List<AgentMetrics>> metricsList(int days) {
    return HttpRequest().get('/ucenter/app/agent/metrics',
        params: {'days': days}).then((value) {
      return (value.data as List).map((e) => AgentMetrics.fromJson(e)).toList();
    });
  }

  ///
  /// 查询收益明细
  static Future<PageResult<AgentIncome>> incomeList(
      Map<String, dynamic> params) {
    return HttpRequest()
        .get('/ucenter/app/agent/income/list', params: params)
        .then((value) => PageResult.fromJson(
              json: value.data,
              handle: (value) => AgentIncome.fromJson(value),
            ));
  }

  ///
  /// 流量主提现
  static Future<void> withdraw(Map<String, dynamic> params) {
    return HttpRequest()
        .post('/ucenter/app/agent/withdraw', params: params)
        .then((value) => null);
  }

  ///
  /// 流量主提现记录
  static Future<PageResult<WithdrawRecord>> withdrawList(
      Map<String, dynamic> params) {
    return HttpRequest()
        .get('/ucenter/app/agent/withdraw/list', params: params)
        .then((value) => PageResult.fromJson(
              json: value.data,
              handle: (e) => WithdrawRecord.fromJson(e),
            ));
  }
}
