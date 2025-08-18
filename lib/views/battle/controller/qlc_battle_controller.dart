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
import 'package:prize_lottery_app/views/forecast/model/qlc_forecast_info.dart';
import 'package:prize_lottery_app/views/rank/model/qlc_master_rank.dart';

class QlcBattleController extends AbsBattleController<QlcForecastInfo> {
  static QlcBattleController? _instance;

  factory QlcBattleController() {
    QlcBattleController._instance ??=
        Get.put<QlcBattleController>(QlcBattleController._initialize());
    return QlcBattleController._instance!;
  }

  QlcBattleController._initialize();

  ///
  /// 对战统计
  QlcBattleCensus census = QlcBattleCensus();

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

  List<Widget> views(BattleCensus Function(QlcBattleCensus) getter) {
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
      List<QlcForecastInfo> forecasts = [
        ...battles.map((e) => e.forecast),
        if (ding != null) ding!.forecast,
      ];
      if (forecasts.length < 6) {
        return;
      }
      census.red1 = calcBattle(
        forecasts: forecasts,
        getter: (e) => e.red1,
        dataSet: qlcStr,
        throttle: 2,
      );
      census.red2 = calcBattle(
        forecasts: forecasts,
        getter: (e) => e.red2,
        dataSet: qlcStr,
        throttle: 2,
      );
      census.red3 = calcBattle(
        forecasts: forecasts,
        getter: (e) => e.red3,
        dataSet: qlcStr,
        throttle: 3,
      );
      census.red12 = calcBattle(
        forecasts: forecasts,
        getter: (e) => e.red12,
        dataSet: qlcStr,
        throttle: 6,
      );
      census.red18 = calcBattle(
        forecasts: forecasts,
        getter: (e) => e.red18,
        dataSet: qlcStr,
        throttle: 6,
      );
      census.red22 = calcBattle(
        forecasts: forecasts,
        getter: (e) => e.red22,
        dataSet: qlcStr,
        throttle: 6,
      );
      census.kill3 = calcBattle(
        forecasts: forecasts,
        getter: (e) => e.kill3,
        dataSet: qlcStr,
        throttle: 3,
      );
      census.kill6 = calcBattle(
        forecasts: forecasts,
        getter: (e) => e.kill6,
        dataSet: qlcStr,
        throttle: 6,
      );
      update();
    });
  }

  void addAndRoute(String masterId) {
    battleToRoute(
      masterId: masterId,
      route: AppRoutes.qlcBattle,
      battleFuture: (masterId) => MasterBattleRepository.addQlcBattle(masterId),
    );
  }

  void addBattle(String masterId, {required Function(String) success}) {
    battle(
      masterId: masterId,
      success: success,
      battleFuture: (masterId) => MasterBattleRepository.addQlcBattle(masterId),
    );
  }

  @override
  Future<List<MasterBattle<QlcForecastInfo>>> battleLoader() {
    return MasterBattleRepository.qlcBattles();
  }
}

class QlcBattleMasterController extends AbsPageQueryController {
  ///
  ///
  int total = 0,
      page = 1,
      limit = 10;

  ///
  List<MasterBattleRank<QlcMasterMulRank>> ranks = [];

  void addBattled(String masterId) {
    MasterBattleRank<QlcMasterMulRank>? rank =
    ranks.firstWhereOrNull((e) => e.masterRank.master.masterId == masterId);
    if (rank != null) {
      rank.battled = 1;
      update();
    }
  }

  @override
  Future<void> onInitial() async {
    showLoading();
    await MasterBattleRepository.qlcBattleRanks(
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
    await MasterBattleRepository.qlcBattleRanks(
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
    await MasterBattleRepository.qlcBattleRanks(
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

  List<MasterBattleRank<QlcMasterMulRank>> calcBattled(
      List<MasterBattleRank<QlcMasterMulRank>> ranks) {
    if (ranks.isEmpty) {
      return [];
    }
    return ranks
      ..forEach((rank) {
        String masterId = rank.masterRank.master.masterId;
        if (QlcBattleController().hasBattled(masterId)) {
          rank.battled = 1;
        }
      });
  }
}
