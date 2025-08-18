import 'package:prize_lottery_app/base/controller/fee_request_controller.dart';
import 'package:prize_lottery_app/views/census/model/number_three_census_do.dart';
import 'package:prize_lottery_app/views/census/repository/lotto_census_repository.dart';

class Pl3RateCensusController extends AbsFeeRequestController {
  ///
  ///
  late NumberThreeCensusDo census;

  ///当前期号
  late String period;

  void pl3RateCensus() {
    LottoCensusRepository.pl3RateCensusV1().then((value) {
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
    pl3RateCensus();
  }

}
