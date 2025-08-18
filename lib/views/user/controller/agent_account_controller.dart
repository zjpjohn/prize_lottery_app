import 'dart:math';

import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/views/user/model/agent_account.dart';
import 'package:prize_lottery_app/views/user/repository/agent_repository.dart';

const List<int> metricsDays = [7, 14, 30];

const Map<int, String> agentAvatars = {
  1: R.agentLevel1,
  2: R.agentLevel2,
  3: R.agentLevel3,
};

class AgentAccountController extends AbsRequestController {
  ///
  /// 流量主账户
  late AgentAccount account;

  ///流量主指标
  List<AgentMetrics> metrics = [];

  ///统计图表数据
  Map<int, List<Map<dynamic, dynamic>>> dataMap = {
    7: [],
    14: [],
    30: [],
  };

  ///当前统计数据
  List<Map<dynamic, dynamic>> datas = [];
  int _metricsDay = 7;

  String get avatar => agentAvatars[account.agent.value]!;

  int get metricsDay => _metricsDay;

  set metricsDay(int value) {
    if (value == _metricsDay) {
      return;
    }
    _metricsDay = value;
    datas = dataMap[_metricsDay]!;
    update();
  }

  num get maxValue {
    num maxVal = 0;
    datas.map((e) => (e['value']! as num)).forEach((e) {
      maxVal = max(e, maxVal);
    });
    return max(maxVal, 100);
  }

  @override
  Future<void> request() async {
    showLoading();
    Future<void> accountAsync =
        AgentRepository.agentAccount().then((value) => account = value);
    Future<void> metricsAsync = AgentRepository.metricsList(30).then((value) {
      metrics = value;
      DateTime current = DateTime.now();
      _convertMetrics(
        metricsList: metrics,
        current: current,
        handler: (metrics) => metrics.toAmount(),
      );
      _convertMetrics(
        metricsList: metrics,
        current: current,
        handler: (metrics) => metrics.toInvites(),
      );
      _convertMetrics(
        metricsList: metrics,
        current: current,
        handler: (metrics) => metrics.toUsers(),
      );
      datas = dataMap[_metricsDay]!;
    });
    Future.wait([accountAsync, metricsAsync]).then((value) {
      Future.delayed(const Duration(milliseconds: 250), () {
        showSuccess(true);
      }).catchError((error) {
        showError(error);
      });
    });
  }

  void _convertMetrics({
    required List<AgentMetrics> metricsList,
    required DateTime current,
    required ConvertHandler handler,
  }) {
    for (var metrics in metricsList) {
      Map<dynamic, dynamic> item = handler(metrics);
      dataMap[30]!.add(item);
      int days = current.difference(metrics.date).inDays;
      if (days <= 7) {
        dataMap[7]!.add(item);
      }
      if (days <= 14) {
        dataMap[14]!.add(item);
      }
    }
  }
}

typedef ConvertHandler = Map<dynamic, dynamic> Function(AgentMetrics metrics);
