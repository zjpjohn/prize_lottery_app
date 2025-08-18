import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:prize_lottery_app/base/controller/fee_request_controller.dart';
import 'package:prize_lottery_app/views/census/model/qlc_chart_census_do.dart';
import 'package:prize_lottery_app/views/census/repository/lotto_census_repository.dart';

class QlcVipCensusController extends AbsFeeRequestController {
  ///
  ///
  int _level = 10;

  ///
  Map<int, QlcChartCensusDo> censusMap = {};

  ///
  late String period;
  late QlcChartCensusDo census;

  ///
  int get level => _level;

  set level(int level) {
    if (_level == level) {
      return;
    }
    _level = level;
    update();
    getLevelVipCensus(showLoading: true);
  }

  void getLevelVipCensus({bool showLoading = false}) {
    if (censusMap[level] != null) {
      census = censusMap[level]!;
      update();
      return;
    }
    if (showLoading) {
      EasyLoading.show(status: '加载中');
    }
    LottoCensusRepository.qlcLevelVipV1(level).then((value) {
      Future.delayed(const Duration(milliseconds: 200), () {
        feeBrowse = value.feeRequired;
        period = value.period;
        showSuccess(value, success: () {
          if (!feeBrowse && value.data != null) {
            censusMap[level] = QlcChartCensusDo(value.data!);
            census = censusMap[level]!;
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
    getLevelVipCensus();
  }
}
