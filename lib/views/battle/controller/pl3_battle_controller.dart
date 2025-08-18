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
import 'package:prize_lottery_app/views/forecast/model/pl3_forecast_info.dart';
import 'package:prize_lottery_app/views/rank/model/pl3_master_rank.dart';

class Pl3BattleController extends AbsBattleController<Pl3ForecastInfo> {
  ///
  ///
  static Pl3BattleController? _instance;

  factory Pl3BattleController() {
    Pl3BattleController._instance ??=
        Get.put<Pl3BattleController>(Pl3BattleController._initialize());
    return Pl3BattleController._instance!;
  }

  Pl3BattleController._initialize();

  ///
  /// 对战统计
  Pl3BattleCensus census = Pl3BattleCensus();

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

  List<Widget> views(BattleCensus Function(Pl3BattleCensus) getter) {
    if (show == null) {
      return [];
    }
    BattleCensus itemCensus = getter(census);
    if (show == 1) {
      return itemCensus.view(itemCensus.max);
    }
    return itemCensus.view(itemCensus.min);
  }

  List<Widget> segViews(BattleSegCensus Function(Pl3BattleCensus) getter) {
    if (show == null) {
      return [];
    }
    BattleSegCensus itemCensus = getter(census);
    if (show == 1) {
      return itemCensus.view(itemCensus.max);
    }
    return itemCensus.view(itemCensus.min);
  }

  ///
  ///计算对战统计
  @override
  void calcBattleCensus() async {
    if (battles.isEmpty) {
      return;
    }
    return Future(() {
      ///对战数据
      List<Pl3ForecastInfo> forecasts = [
        ...battles.map((e) => e.forecast),
        if (ding != null) ding!.forecast,
      ];
      //小于6条对战记录不计算
      if (forecasts.length < 6) {
        return;
      }
      census.d1 = calcBattle(
        forecasts: forecasts,
        getter: (e) => e.dan1,
        dataSet: ballStr09,
      );
      census.d2 = calcBattle(
        forecasts: forecasts,
        getter: (e) => e.dan2,
        dataSet: ballStr09,
      );
      census.d3 = calcBattle(
        forecasts: forecasts,
        getter: (e) => e.dan3,
        dataSet: ballStr09,
      );
      census.com5 = calcBattle(
        forecasts: forecasts,
        getter: (e) => e.com5,
        dataSet: ballStr09,
      );
      census.com6 = calcBattle(
        forecasts: forecasts,
        getter: (e) => e.com6,
        dataSet: ballStr09,
      );
      census.com7 = calcBattle(
        forecasts: forecasts,
        getter: (e) => e.com7,
        dataSet: ballStr09,
      );
      census.k1 = calcBattle(
        forecasts: forecasts,
        getter: (e) => e.kill1,
        dataSet: ballStr09,
      );
      census.k2 = calcBattle(
        forecasts: forecasts,
        getter: (e) => e.kill2,
        dataSet: ballStr09,
      );
      census.cb5 = calcSegBattle(
        forecasts: forecasts,
        getter: (e) => e.comb5,
        dataSet: ballStr09,
      );
      census.cb4 = calcSegBattle(
        forecasts: forecasts,
        getter: (e) => e.comb4,
        dataSet: ballStr09,
      );
      update();
    });
  }

  void addAndRoute(String masterId) {
    battleToRoute(
      masterId: masterId,
      route: AppRoutes.pl3Battle,
      battleFuture: (masterId) => MasterBattleRepository.addPl3Battle(masterId),
    );
  }

  void addBattle(String masterId, {required Function(String) success}) {
    battle(
      masterId: masterId,
      success: success,
      battleFuture: (masterId) => MasterBattleRepository.addPl3Battle(masterId),
    );
  }

  @override
  Future<List<MasterBattle<Pl3ForecastInfo>>> battleLoader() {
   return MasterBattleRepository.pl3Battles();
  }
}

class Pl3BattleMasterController extends AbsPageQueryController {
  ///
  ///
  int total = 0, page = 1, limit = 10;

  ///
  List<MasterBattleRank<Pl3MasterMulRank>> ranks = [];

  void addBattled(String masterId) {
    MasterBattleRank<Pl3MasterMulRank>? rank =
        ranks.firstWhereOrNull((e) => e.masterRank.master.masterId == masterId);
    if (rank != null) {
      rank.battled = 1;
      update();
    }
  }

  @override
  Future<void> onInitial() async {
    showLoading();
    await MasterBattleRepository.pl3BattleRanks(
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
    await MasterBattleRepository.pl3BattleRanks(
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
    await MasterBattleRepository.pl3BattleRanks(
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

  List<MasterBattleRank<Pl3MasterMulRank>> calcBattled(
      List<MasterBattleRank<Pl3MasterMulRank>> ranks) {
    if (ranks.isEmpty) {
      return [];
    }
    return ranks
      ..forEach((rank) {
        String masterId = rank.masterRank.master.masterId;
        if (Pl3BattleController().hasBattled(masterId)) {
          rank.battled = 1;
        }
      });
  }
}
