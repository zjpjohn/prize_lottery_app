import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:prize_lottery_app/base/controller/fee_request_controller.dart';
import 'package:prize_lottery_app/views/census/model/ssq_chart_census_do.dart';
import 'package:prize_lottery_app/views/census/repository/lotto_census_repository.dart';

class SsqFullCensusController extends AbsFeeRequestController {
  ///
  ///全量统计级别
  int _level = 100;

  ///
  Map<int, SsqChartCensusDo> censusMap = {};

  ///
  late String period;
  late SsqChartCensusDo census;

  ///
  int get level => _level;

  set level(int level) {
    if (_level == level) {
      return;
    }
    _level = level;
    update();
    getLevelFullCensus(showLoading: true);
  }

  void getLevelFullCensus({bool showLoading = false}) {
    if (censusMap[level] != null) {
      census = censusMap[level]!;
      update();
      return;
    }
    if (showLoading) {
      EasyLoading.show(status: '加载中');
    }
    LottoCensusRepository.ssqLevelFullV1(level).then((value) {
      Future.delayed(const Duration(milliseconds: 200), () {
        feeBrowse = value.feeRequired;
        period = value.period;
        showSuccess(value, success: () {
          if (!feeBrowse && value.data != null) {
            censusMap[level] = SsqChartCensusDo(value.data!);
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
    getLevelFullCensus();
  }

}
