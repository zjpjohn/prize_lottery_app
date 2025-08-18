import 'dart:async';

import 'package:prize_lottery_app/base/controller/fee_request_controller.dart';
import 'package:prize_lottery_app/views/census/model/number_three_census_do.dart';
import 'package:prize_lottery_app/views/census/repository/lotto_census_repository.dart';

class Fc3dHotCensusController extends AbsFeeRequestController {
  ///
  ///
  late NumberThreeCensusDo census;

  ///统计期号
  late String period;

  void fc3dHotCensus() {
    LottoCensusRepository.fc3dHotCensusV1().then((value) {
      Future.delayed(const Duration(milliseconds: 200), () {
        feeBrowse = value.feeRequired;
        period = value.period;
        showSuccess(value, success: () {
          if (!feeBrowse && value.data != null) {
            census = NumberThreeCensusDo(value.data!);
          }
        });
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> request() async {
    showLoading();
    fc3dHotCensus();
  }
}
