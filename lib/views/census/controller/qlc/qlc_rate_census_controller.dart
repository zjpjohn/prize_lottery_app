import 'package:prize_lottery_app/base/controller/fee_request_controller.dart';
import 'package:prize_lottery_app/views/census/model/qlc_chart_census_do.dart';
import 'package:prize_lottery_app/views/census/repository/lotto_census_repository.dart';

class QlcRateCensusController extends AbsFeeRequestController {
  ///
  ///
  late QlcChartCensusDo census;
  late String period;

  void qlcRateCensus() {
    LottoCensusRepository.qlcRateCensusV1().then((value) {
      Future.delayed(const Duration(milliseconds: 200), () {
        feeBrowse = value.feeRequired;
        period = value.period;
        showSuccess(value, success: () {
          if (!feeBrowse && value.data != null) {
            census = QlcChartCensusDo(value.data!);
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
    qlcRateCensus();
  }

}
