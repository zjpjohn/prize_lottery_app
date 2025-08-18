import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/page_controller.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/utils/constants.dart';
import 'package:prize_lottery_app/views/battle/controller/battle_controller.dart';
import 'package:prize_lottery_app/views/battle/model/battle_census.dart';
import 'package:prize_lottery_app/views/battle/model/master_battle.dart';
import 'package:prize_lottery_app/views/battle/repository/master_battle_repository.dart';
import 'package:prize_lottery_app/views/forecast/model/ssq_forecast_info.dart';
import 'package:prize_lottery_app/views/rank/model/ssq_master_rank.dart';

class SsqBattleController extends AbsBattleController<SsqForecastInfo> {
  ///
  ///
  static SsqBattleController? _instance;

  factory SsqBattleController() {
    SsqBattleController._instance ??=
        Get.put<SsqBattleController>(SsqBattleController._initialize());
    return SsqBattleController._instance!;
  }

  SsqBattleController._initialize();

  ///
  /// 对战统计
  SsqBattleCensus census = SsqBattleCensus();

  ///
  /// 是否显示统计
  int? _show;

  set show(int? value) {
    if (value != null) {
      _show = value;
      update();
    }
  }

  int? get show => _show;

  List<Widget> views(BattleCensus Function(SsqBattleCensus) getter) {
    if (show == null) {
      return [];
    }
    BattleCensus itemCensus = getter(census);
    if (show == 1) {
      return itemCensus.view(itemCensus.max);
    }
    return itemCensus.view(itemCensus.min);
  }

  @override
  void calcBattleCensus() async {
    if (battles.isEmpty) {
      return;
    }
    return Future(() {
      List<SsqForecastInfo> forecasts = [
        ...battles.map((e) => e.forecast),
        if (ding != null) ding!.forecast,
      ];
      if (forecasts.length < 6) {
        return;
      }
      census.red1 = calcBattle(
        forecasts: forecasts,
        getter: (e) => e.red1,
        dataSet: ssqRedStr,
        throttle: 2,
      );
      census.red2 = calcBattle(
        forecasts: forecasts,
        getter: (e) => e.red2,
        dataSet: ssqRedStr,
        throttle: 2,
      );
      census.red3 = calcBattle(
        forecasts: forecasts,
        getter: (e) => e.red3,
        dataSet: ssqRedStr,
        throttle: 3,
      );
      census.red12 = calcBattle(
        forecasts: forecasts,
        getter: (e) => e.red12,
        dataSet: ssqRedStr,
        throttle: 6,
      );
      census.red20 = calcBattle(
        forecasts: forecasts,
        getter: (e) => e.red20,
        dataSet: ssqRedStr,
        throttle: 6,
      );
      census.red25 = calcBattle(
        forecasts: forecasts,
        getter: (e) => e.red25,
        dataSet: ssqRedStr,
        throttle: 6,
      );
      census.rk3 = calcBattle(
        forecasts: forecasts,
        getter: (e) => e.redKill3,
        dataSet: ssqRedStr,
        throttle: 3,
      );
      census.rk6 = calcBattle(
        forecasts: forecasts,
        getter: (e) => e.redKill6,
        dataSet: ssqRedStr,
        throttle: 6,
      );
      census.blue3 = calcBattle(
        forecasts: forecasts,
        getter: (e) => e.blue3,
        dataSet: ssqBlueStr,
        throttle: 3,
      );
      census.blue5 = calcBattle(
        forecasts: forecasts,
        getter: (e) => e.blue5,
        dataSet: ssqBlueStr,
      );
      census.bk = calcBattle(
        forecasts: forecasts,
        getter: (e) => e.blueKill,
        dataSet: ssqBlueStr,
      );
      update();
    });
  }

  void addAndRoute(String masterId) {
    battleToRoute(
      masterId: masterId,
      route: AppRoutes.ssqBattle,
      battleFuture: (masterId) => MasterBattleRepository.addSsqBattle(masterId),
    );
  }

  void addBattle(String masterId, {required Function(String) success}) {
    battle(
      masterId: masterId,
      success: success,
      battleFuture: (masterId) => MasterBattleRepository.addSsqBattle(masterId),
    );
  }

  @override
  Future<List<MasterBattle<SsqForecastInfo>>> battleLoader() {
    return MasterBattleRepository.ssqBattles();
  }
}

class SsqBattleMasterController extends AbsPageQueryController {
  ///
  ///
  int total = 0, page = 1, limit = 10;

  ///
  List<MasterBattleRank<SsqMasterMulRank>> ranks = [];

  void addBattled(String masterId) {
    MasterBattleRank<SsqMasterMulRank>? rank =
        ranks.firstWhereOrNull((e) => e.masterRank.master.masterId == masterId);
    if (rank != null) {
      rank.battled = 1;
      update();
    }
  }

  @override
  Future<void> onInitial() async {
    showLoading();
    await MasterBattleRepository.ssqBattleRanks(
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      ranks
        ..clear()
        ..addAll(calcBattled(value.records));
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(ranks);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onLoadMore() async {
    if (ranks.length == total) {
      EasyLoading.showToast('没有更多数据');
      return;
    }
    page++;
    await MasterBattleRepository.ssqBattleRanks(
      page: page,
      limit: limit,
    ).then((value) {
      ranks.addAll(calcBattled(value.records));
      update();
    }).catchError((error) {
      page--;
    });
  }

  @override
  Future<void> onRefresh() async {
    page = 1;
    await MasterBattleRepository.ssqBattleRanks(
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      ranks
        ..clear()
        ..addAll(calcBattled(value.records));
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(ranks);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  List<MasterBattleRank<SsqMasterMulRank>> calcBattled(
      List<MasterBattleRank<SsqMasterMulRank>> ranks) {
    if (ranks.isEmpty) {
      return [];
    }
    return ranks
      ..forEach((rank) {
        String masterId = rank.masterRank.master.masterId;
        if (SsqBattleController().hasBattled(masterId)) {
          rank.battled = 1;
        }
      });
  }
}
