import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_census.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_omit.dart';
import 'package:prize_lottery_app/views/lottery/model/ssq_omit_census.dart';
import 'package:prize_lottery_app/views/lottery/repository/lottery_info_repository.dart';

class SsqNumberTrendController extends AbsRequestController {
  ///
  List<LotteryOmit> omits = [];

  /// 走势分布
  List<LotteryCensus> lottos = [];

  ///
  late SsqOmitCensus census;

  @override
  Future<void> request() async {
    showLoading();

    ///彩票走势统计分析
    Future<void> lotteryFuture = LotteryInfoRepository.historyLotteries({
      'type': 'ssq',
      'limit': 50,
    }).then((value) {
      List<LotteryCensus> censuses =
          value.records.map((e) => LotteryCensus(e, 33)).toList();
      lottos
        ..clear()
        ..addAll(censuses)
        ..sort((e1, e2) => e1.period.compareTo(e2.period));
    });

    ///遗漏分析
    Future<void> omitFuture =
        LotteryInfoRepository.lotteryOmits('ssq', 50).then((value) {
      omits
        ..clear()
        ..addAll(value)
        ..sort((e1, e2) => e1.period.compareTo(e2.period));
      if (omits.isNotEmpty) {
        census = SsqOmitCensus(omits);
      }
    });

    ///
    Future.wait([omitFuture, lotteryFuture]).then((value) {
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(omits);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
