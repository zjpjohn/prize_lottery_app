import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:prize_lottery_app/base/controller/fee_request_controller.dart';
import 'package:prize_lottery_app/views/census/model/synthetic_vip_census.dart';
import 'package:prize_lottery_app/views/census/repository/lotto_census_repository.dart';

class Pl3VipCensusController extends AbsFeeRequestController {
  ///
  Map<String, SyntheticVip3CensusDo> vipCensusMap = {};

  /// 默认渠道值
  String _channel = 'k1';

  ///数据统计级别
  int _level = 5;

  ///当前期号
  late String period;
  late SyntheticVip3CensusDo vipCensus;
  late ChartData chart;

  int get level => _level;

  set level(int level) {
    if (_level == level) {
      return;
    }
    _level = level;
    chart = vipCensus.getChart(level);
    update();
  }

  ///
  String get channel => _channel;

  set channel(String channel) {
    if (_channel == channel) {
      return;
    }
    _channel = channel;
    update();
    getVipChannelCensus(showLoading: true);
  }

  void getVipChannelCensus({bool showLoading = false}) {
    if (vipCensusMap[channel] != null) {
      vipCensus = vipCensusMap[channel]!;
      _level = 5;
      chart = vipCensus.getChart(_level);
      update();
      return;
    }

    ///
    if (showLoading) {
      EasyLoading.show(status: '加载中');
    }
    LottoCensusRepository.vipCensusV1(lottery: 'pls', type: channel)
        .then((value) {
      Future.delayed(const Duration(milliseconds: 200), () {
        feeBrowse = value.feeRequired;
        period = value.period;
        if (value.expend != null) {
          expend = value.expend!;
        }
        showSuccess(value, success: () {
          if (!feeBrowse && value.data != null) {
            vipCensusMap[channel] = SyntheticVip3CensusDo(value.data!);
            vipCensus = vipCensusMap[channel]!;
            _level = 5;
            chart = vipCensus.getChart(_level);
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

  @override
  Future<void> request() async {
    showLoading();
    getVipChannelCensus();
  }

}
