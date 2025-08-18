import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/views/lottery/model/kl8_omit_census.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_info.dart';
import 'package:prize_lottery_app/views/lottery/repository/lottery_info_repository.dart';

class Kl8NumberTrendController extends AbsRequestController {
  ///
  ///遗漏数据
  List<Kl8Omit> omits = [];

  ///开奖数据
  List<LotteryInfo> lotteries = [];

  ///遗漏统计
  late Kl8OmitCensus census;

  @override
  Future<void> request() async {
    showLoading();

    ///开奖数据
    Future<void> lotteryFuture = LotteryInfoRepository.historyLotteries({
      'type': 'kl8',
      'limit': 30,
    }).then((value) {
      lotteries
        ..clear()
        ..addAll(value.records)
        ..sort((e1, e2) => e1.period.compareTo(e2.period));
    });

    ///遗漏数据
    Future<void> omitFuture = LotteryInfoRepository.kl8Omits().then((value) {
      omits
        ..clear()
        ..addAll(value)
        ..sort((e1, e2) => e1.period.compareTo(e2.period));
      if (omits.isNotEmpty) {
        census = Kl8OmitCensus(omits);
      }
    });
    Future.wait([omitFuture, lotteryFuture]).then((value) {
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(omits);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
