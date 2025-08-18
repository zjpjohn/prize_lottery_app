import 'package:prize_lottery_app/base/controller/page_controller.dart';
import 'package:prize_lottery_app/base/model/request_state.dart';
import 'package:prize_lottery_app/views/glad/model/ssq_master_glad.dart';
import 'package:prize_lottery_app/views/glad/repository/master_glad_repository.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_info.dart';
import 'package:prize_lottery_app/views/lottery/repository/lottery_info_repository.dart';
import 'package:prize_lottery_app/views/rank/model/ssq_master_rank.dart';
import 'package:prize_lottery_app/views/rank/repository/master_rank_repository.dart';

class SsqHomeController extends AbsPageQueryController {
  ///
  late LotteryInfo lottery;

  ///
  List<SsqMasterMulRank> ranks = [];

  ///
  List<SsqMasterMulRank> bRanks = [];

  ///
  List<SsqMasterGlad> glads = [];

  @override
  Future<void> onInitial() async {
    showLoading();
    Future<void> lotteryAsync = LotteryInfoRepository.latestLottery('ssq')
        .then((value) => lottery = value);
    Future<void> rankAsync =
        MasterRankRepository.mulSsqMasterRanks(type: 0, limit: 6)
            .then((value) => ranks
              ..clear()
              ..addAll(value.records));
    Future<void> bRankAsync =
        MasterRankRepository.mulSsqMasterRanks(type: 1, limit: 6)
            .then((value) => bRanks
              ..clear()
              ..addAll(value.records));
    Future<void> gladAsync =
        MasterGladRepository.ssqGladList(limit: 6).then((value) => glads
          ..clear()
          ..addAll(value.records));
    await Future.wait([
      lotteryAsync,
      rankAsync,
      bRankAsync,
      gladAsync,
    ]).then((values) {
      Future.delayed(const Duration(milliseconds: 250), () {
        state = RequestState.success;
        update();
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onRefresh() async {
    Future<void> lotteryAsync = LotteryInfoRepository.latestLottery('ssq')
        .then((value) => lottery = value);
    Future<void> rankAsync =
        MasterRankRepository.mulSsqMasterRanks(limit: 6).then((value) => ranks
          ..clear()
          ..addAll(value.records));
    Future<void> bRankAsync =
        MasterRankRepository.mulSsqMasterRanks(type: 1, limit: 6)
            .then((value) => bRanks
              ..clear()
              ..addAll(value.records));
    Future<void> gladAsync =
        MasterGladRepository.ssqGladList(limit: 6).then((value) => glads
          ..clear()
          ..addAll(value.records));
    await Future.wait([
      lotteryAsync,
      rankAsync,
      bRankAsync,
      gladAsync,
    ]).then((values) {
      Future.delayed(const Duration(milliseconds: 250), () {
        state = RequestState.success;
        update();
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onLoadMore() async {}
}
