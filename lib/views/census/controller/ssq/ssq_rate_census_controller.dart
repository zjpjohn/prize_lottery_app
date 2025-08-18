import 'package:prize_lottery_app/base/controller/fee_request_controller.dart';
import 'package:prize_lottery_app/views/census/model/ssq_chart_census_do.dart';
import 'package:prize_lottery_app/views/census/repository/lotto_census_repository.dart';

class SsqRateCensusController extends AbsFeeRequestController {
  ///
  ///
  late SsqChartCensusDo census;
  late String period;

  void ssqRateCensus() {
    LottoCensusRepository.ssqRateCensusV1().then((value) {
      Future.delayed(const Duration(milliseconds: 200), () {
        feeBrowse = value.feeRequired;
        period = value.period;
        showSuccess(value, success: () {
          if (!feeBrowse && value.data != null) {
            census = SsqChartCensusDo(value.data!);
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
    ssqRateCensus();
  }
}
