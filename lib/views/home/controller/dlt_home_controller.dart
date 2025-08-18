import 'package:prize_lottery_app/base/controller/page_controller.dart';
import 'package:prize_lottery_app/base/model/request_state.dart';
import 'package:prize_lottery_app/views/glad/model/dlt_master_glad.dart';
import 'package:prize_lottery_app/views/glad/repository/master_glad_repository.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_info.dart';
import 'package:prize_lottery_app/views/lottery/repository/lottery_info_repository.dart';
import 'package:prize_lottery_app/views/rank/model/dlt_master_rank.dart';
import 'package:prize_lottery_app/views/rank/repository/master_rank_repository.dart';

class DltHomeController extends AbsPageQueryController {
  ///
  late LotteryInfo lottery;

  ///
  List<DltMasterMulRank> ranks = [];

  ///
  List<DltMasterMulRank> bRanks = [];

  ///
  List<DltMasterGlad> glads = [];

  @override
  Future<void> onInitial() async {
    showLoading();
    Future<void> lotteryAsync = LotteryInfoRepository.latestLottery('dlt')
        .then((value) => lottery = value);
    Future<void> rankAsync =
        MasterRankRepository.mulDltMasterRanks(type: 0, limit: 6)
            .then((value) => ranks
              ..clear()
              ..addAll(value.records));
    Future<void> bRankAsync =
        MasterRankRepository.mulDltMasterRanks(type: 1, limit: 6)
            .then((value) => bRanks
              ..clear()
              ..addAll(value.records));
    Future<void> gladAsync =
        MasterGladRepository.dltGladList(limit: 6).then((value) => glads
          ..clear()
          ..addAll(value.records));
    await Future.wait([
      lotteryAsync,
      rankAsync,
      bRankAsync,
      gladAsync,
    ]).then((value) {
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
    Future<void> lotteryAsync = LotteryInfoRepository.latestLottery('dlt')
        .then((value) => lottery = value);
    Future<void> rankAsync =
        MasterRankRepository.mulDltMasterRanks(limit: 6).then((value) => ranks
          ..clear()
          ..addAll(value.records));
    Future<void> bRankAsync =
        MasterRankRepository.mulDltMasterRanks(type: 1, limit: 6)
            .then((value) => bRanks
              ..clear()
              ..addAll(value.records));
    Future<void> gladAsync =
        MasterGladRepository.dltGladList(limit: 6).then((value) => glads
          ..clear()
          ..addAll(value.records));
    await Future.wait([
      lotteryAsync,
      rankAsync,
      bRankAsync,
      gladAsync,
    ]).then((value) {
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
