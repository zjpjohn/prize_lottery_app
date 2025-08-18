import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:prize_lottery_app/base/controller/fee_request_controller.dart';
import 'package:prize_lottery_app/views/census/model/synthetic_vip_census.dart';
import 'package:prize_lottery_app/views/census/repository/lotto_census_repository.dart';

class Fc3dFullCensusController extends AbsFeeRequestController {
  ///分类统计数据集合
  Map<String, SyntheticItem3CensusDo> itemCensusMap = {};

  /// 默认渠道值
  String _channel = 'k1';

  ///统计数据等级
  int _level = 5;

  ///当前期号
  late String period;

  late SyntheticItem3CensusDo itemCensus;

  late ChartData chart;

  ///
  String get channel => _channel;

  int get level => _level;

  set level(int level) {
    if (_level == level) {
      return;
    }
    _level = level;
    chart = itemCensus.getChart(level);
    update();
  }

  set channel(String channel) {
    if (_channel == channel) {
      return;
    }
    _channel = channel;
    update();
    getFullChannelCensus(showLoading: true);
  }

  void getFullChannelCensus({bool showLoading = false}) {
    if (itemCensusMap[channel] != null) {
      itemCensus = itemCensusMap[channel]!;
      _level = 5;
      chart = itemCensus.getChart(_level);
      update();
      return;
    }

    ///
    if (showLoading) {
      EasyLoading.show(status: '加载中');
    }
    LottoCensusRepository.itemCensusV1(lottery: 'fsd', type: channel)
        .then((value) {
      Future.delayed(const Duration(milliseconds: 200), () {
        feeBrowse = value.feeRequired;
        period = value.period;
        if (value.expend != null) {
          expend = value.expend!;
        }
        showSuccess(value, success: () {
          if (!feeBrowse && value.data != null) {
            itemCensusMap[channel] = SyntheticItem3CensusDo(value.data!);
            itemCensus = itemCensusMap[channel]!;
            _level = 5;
            chart = itemCensus.getChart(_level);
          }
        });
      });
    }).catchError((error) {
      showError(error);
    }).whenComplete(() {
      if (showLoading && EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
    });
  }

  ///
  ///
  @override
  Future<void> request() async {
    showLoading();
    getFullChannelCensus();
  }
}
