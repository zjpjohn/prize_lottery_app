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
import 'package:prize_lottery_app/views/forecast/model/dlt_forecast_info.dart';
import 'package:prize_lottery_app/views/rank/model/dlt_master_rank.dart';

class DltBattleController extends AbsBattleController<DltForecastInfo> {
  static DltBattleController? _instance;

  factory DltBattleController() {
    DltBattleController._instance ??=
        Get.put<DltBattleController>(DltBattleController._initialize());
    return DltBattleController._instance!;
  }

  DltBattleController._initialize();

  ///
  /// 对战统计
  DltBattleCensus census = DltBattleCensus();

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

  List<Widget> views(BattleCensus Function(DltBattleCensus) getter) {
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
      List<DltForecastInfo> forecasts = [
        ...battles.map((e) => e.forecast),
        if (ding != null) ding!.forecast,
      ];
      if (forecasts.length < 6) {
        return;
      }
      census.red1 = calcBattle(
        forecasts: forecasts,
        getter: (e) => e.red1,
        dataSet: dltRedStr,
        throttle: 2,
      );
      census.red2 = calcBattle(
        forecasts: forecasts,
        getter: (e) => e.red2,
        dataSet: dltRedStr,
        throttle: 2,
      );
      census.red3 = calcBattle(
        forecasts: forecasts,
        getter: (e) => e.red3,
        dataSet: dltRedStr,
        throttle: 3,
      );
      census.red10 = calcBattle(
        forecasts: forecasts,
        getter: (e) => e.red10,
        dataSet: dltRedStr,
      );
      census.red20 = calcBattle(
        forecasts: forecasts,
        getter: (e) => e.red20,
        dataSet: dltRedStr,
      );
      census.rk3 = calcBattle(
        forecasts: forecasts,
        getter: (e) => e.redKill3,
        dataSet: dltRedStr,
        throttle: 3,
      );
      census.rk6 = calcBattle(
        forecasts: forecasts,
        getter: (e) => e.redKill6,
        dataSet: dltRedStr,
      );
      census.blue1 = calcBattle(
        forecasts: forecasts,
        getter: (e) => e.blue1,
        dataSet: dltBlueStr,
        throttle: 2,
      );
      census.blue2 = calcBattle(
        forecasts: forecasts,
        getter: (e) => e.blue2,
        dataSet: dltBlueStr,
        throttle: 2,
      );
      census.blue6 = calcBattle(
        forecasts: forecasts,
        getter: (e) => e.blue6,
        dataSet: dltBlueStr,
      );
      census.bk = calcBattle(
        forecasts: forecasts,
        getter: (e) => e.blueKill3,
        dataSet: dltBlueStr,
        throttle: 3,
      );
      update();
    });
  }

  void addAndRoute(String masterId) {
    battleToRoute(
      masterId: masterId,
      route: AppRoutes.dltBattle,
      battleFuture: (masterId) => MasterBattleRepository.addDltBattle(masterId),
    );
  }

  void addBattle(String masterId, {required Function(String) success}) {
    battle(
      masterId: masterId,
      success: success,
      battleFuture: (masterId) => MasterBattleRepository.addDltBattle(masterId),
    );
  }

  @override
  Future<List<MasterBattle<DltForecastInfo>>> battleLoader() {
    return MasterBattleRepository.dltBattles();
  }
}

class DltBattleMasterController extends AbsPageQueryController {
  ///
  ///
  int total = 0, page = 1, limit = 10;

  ///
  List<MasterBattleRank<DltMasterMulRank>> ranks = [];

  void addBattled(String masterId) {
    MasterBattleRank<DltMasterMulRank>? rank =
        ranks.firstWhereOrNull((e) => e.masterRank.master.masterId == masterId);
    if (rank != null) {
      rank.battled = 1;
      update();
    }
  }

  @override
  Future<void> onInitial() async {
    showLoading();
    MasterBattleRepository.dltBattleRanks(
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
    MasterBattleRepository.dltBattleRanks(
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
    MasterBattleRepository.dltBattleRanks(
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

  List<MasterBattleRank<DltMasterMulRank>> calcBattled(
      List<MasterBattleRank<DltMasterMulRank>> ranks) {
    if (ranks.isEmpty) {
      return [];
    }
    return ranks
      ..forEach((rank) {
        String masterId = rank.masterRank.master.masterId;
        if (DltBattleController().hasBattled(masterId)) {
          rank.battled = 1;
        }
      });
  }
}
