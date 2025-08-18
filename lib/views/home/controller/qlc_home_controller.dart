import 'package:prize_lottery_app/base/controller/page_controller.dart';
import 'package:prize_lottery_app/base/model/request_state.dart';
import 'package:prize_lottery_app/views/glad/model/qlc_master_glad.dart';
import 'package:prize_lottery_app/views/glad/repository/master_glad_repository.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_info.dart';
import 'package:prize_lottery_app/views/lottery/repository/lottery_info_repository.dart';
import 'package:prize_lottery_app/views/rank/model/qlc_master_rank.dart';
import 'package:prize_lottery_app/views/rank/repository/master_rank_repository.dart';

class QlcHomeController extends AbsPageQueryController {
  ///
  late LotteryInfo lottery;

  ///
  List<QlcMasterMulRank> ranks = [];

  ///
  List<QlcMasterGlad> glads = [];

  @override
  Future<void> onInitial() async {
    showLoading();
    Future<void> lotteryAsync = LotteryInfoRepository.latestLottery('qlc')
        .then((value) => lottery = value);
    Future<void> rankAsync =
        MasterRankRepository.mulQlcMasterRanks(limit: 6).then((value) => ranks
          ..clear()
          ..addAll(value.records));
    Future<void> gladAsync =
        MasterGladRepository.qlcGladList(limit: 6).then((value) => glads
          ..clear()
          ..addAll(value.records));
    await Future.wait([lotteryAsync, rankAsync, gladAsync]).then((values) {
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
    Future<void> lotteryAsync = LotteryInfoRepository.latestLottery('qlc')
        .then((value) => lottery = value);
    Future<void> rankAsync =
        MasterRankRepository.mulQlcMasterRanks(limit: 6).then((value) => ranks
          ..clear()
          ..addAll(value.records));
    Future<void> gladAsync =
        MasterGladRepository.qlcGladList(limit: 6).then((value) => glads
          ..clear()
          ..addAll(value.records));
    await Future.wait([lotteryAsync, rankAsync, gladAsync]).then((values) {
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
