import 'dart:async';

import 'package:prize_lottery_app/base/controller/page_controller.dart';
import 'package:prize_lottery_app/base/model/request_state.dart';
import 'package:prize_lottery_app/views/glad/model/fc3d_master_glad.dart';
import 'package:prize_lottery_app/views/glad/repository/master_glad_repository.dart';
import 'package:prize_lottery_app/views/home/controller/layer_state_controller.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_info.dart';
import 'package:prize_lottery_app/views/lottery/repository/lottery_info_repository.dart';
import 'package:prize_lottery_app/views/rank/model/fc3d_master_rank.dart';
import 'package:prize_lottery_app/views/rank/repository/master_rank_repository.dart';

class Fc3dHomeController extends AbsPageQueryController {
  ///开奖信息
  late LotteryInfo lottery;

  ///综合排名信息
  List<Fc3dMasterMulRank> ranks = [];

  ///预测中奖信息
  List<Fc3dMasterGlad> glads = [];

  ///分层预警状态
  LayerState layerState = LayerState.empty();

  List<Future<void>> asyncTasks() {
    return [
      LotteryInfoRepository.latestLottery('fc3d')
          .then((value) => lottery = value),
      MasterRankRepository.mulFc3dMasterRanks(limit: 6).then((value) => ranks
        ..clear()
        ..addAll(value.records)),
      LayerStateController()
          .layerState(type: 'fc3d')
          .then((value) => layerState = value),
      MasterGladRepository.fc3dGladList(limit: 6).then((value) => glads
        ..clear()
        ..addAll(value.records))
    ];
  }

  @override
  Future<void> onInitial() async {
    showLoading();
    await Future.wait(asyncTasks()).then((values) {
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

  @override
  Future<void> onRefresh() async {
    await Future.wait(asyncTasks()).then((values) {
      Future.delayed(const Duration(milliseconds: 250), () {
        state = RequestState.success;
        update();
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
