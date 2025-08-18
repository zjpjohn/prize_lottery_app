import 'package:prize_lottery_app/base/controller/fee_request_controller.dart';
import 'package:prize_lottery_app/views/census/model/dlt_chart_census_do.dart';
import 'package:prize_lottery_app/views/census/repository/lotto_census_repository.dart';

class DltRateCensusController extends AbsFeeRequestController {
  ///
  ///
  late DltChartCensusDo census;
  late String period;

  void dltRateCensus() {
    LottoCensusRepository.dltRateCensusV1().then((value) {
      Future.delayed(const Duration(milliseconds: 200), () {
        feeBrowse = value.feeRequired;
        period = value.period;
        showSuccess(value, success: () {
          if (!feeBrowse && value.data != null) {
            census = DltChartCensusDo(value.data!);
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
    dltRateCensus();
  }
}
