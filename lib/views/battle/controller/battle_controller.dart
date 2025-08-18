import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/fee_request_controller.dart';
import 'package:prize_lottery_app/base/model/forecast_value.dart';
import 'package:prize_lottery_app/base/model/request_state.dart';
import 'package:prize_lottery_app/utils/request.dart';
import 'package:prize_lottery_app/utils/tools.dart';
import 'package:prize_lottery_app/views/battle/model/master_battle.dart';
import 'package:prize_lottery_app/views/battle/repository/master_battle_repository.dart';
import 'package:prize_lottery_app/views/battle/widgets/battle_member_widget.dart';

typedef BattleFuture<T> = Future<MasterBattle<T>> Function(String);
typedef BattleLoader<T> = Future<List<MasterBattle<T>>> Function();
typedef ForecastValueGetter<T> = ForecastValue Function(T);

///
///
///
abstract class AbsBattleController<T> extends GetxController {
  ///
  /// 对战加载状态
  RequestState state = RequestState.loading;

  ///
  /// 加载错误信息
  String? errorMsg;

  ///
  ///显示组件透明度
  double opacity = 0;

  ///
  /// 对战列表
  List<MasterBattle<T>> battles = [];

  ///
  /// 钉在上侧的信息
  MasterBattle<T>? ding;

  ///
  /// 计算对战统计数据
  void calcBattleCensus() {}

  ///
  /// 加载对战数据
  Future<List<MasterBattle<T>>> battleLoader();

  int contentSize(int size) {
    int throttle = ding != null ? size - 1 : size;
    return battles.length < throttle ? battles.length : throttle;
  }

  ///
  /// 钉在最上侧
  void dingTop(String masterId, Function() callback) {
    int index = battles.lastIndexWhere((e) => e.master.masterId == masterId);
    if (index < 0) {
      return;
    }
    MasterBattle<T> battle = battles.removeAt(index);
    if (ding != null) {
      battles = [ding!, ...battles];
    }
    ding = battle;
    update();
    callback();
  }

  ///
  /// 对战列表长度
  int battleSize() {
    if (ding == null) {
      return battles.length;
    }
    return battles.length + 1;
  }

  ///
  /// 判断是否在对战列表中
  bool hasBattled(String masterId) {
    return battles.any((battle) => battle.master.masterId == masterId);
  }

  ///
  /// 添加对战列表并跳转到对战列表
  void battleToRoute({
    required String masterId,
    required String route,
    required BattleFuture<T> battleFuture,
  }) {
    if (hasBattled(masterId)) {
      Get.toNamed(route);
      return;
    }
    EasyLoading.show(status: '正在加载');
    battleFuture(masterId).then((value) {
      battles.add(value);
      update();
      Future.delayed(
        const Duration(milliseconds: 250),
        () => Get.toNamed(route),
      );
    }).catchError((error) {
      Future.delayed(
        const Duration(milliseconds: 200),
        () => EasyLoading.showToast('添加失败'),
      );
    }).whenComplete(() {
      Future.delayed(
        const Duration(milliseconds: 200),
        () => EasyLoading.dismiss(),
      );
    });
  }

  ///
  /// 添加到对战列表，成功并回调
  void battle({
    required String masterId,
    required BattleFuture<T> battleFuture,
    required Function(String) success,
  }) {
    if (hasBattled(masterId)) {
      EasyLoading.showToast('已在PK列表中');
      return;
    }
    EasyLoading.show(status: '正在添加');
    battleFuture(masterId).then((value) {
      battles.add(value);
      if (state == RequestState.empty) {
        state = RequestState.success;
      }
      update();

      ///成功回调
      success(masterId);

      ///计算对战统计
      calcBattleCensus();
      Future.delayed(
        const Duration(milliseconds: 200),
        () => EasyLoading.showToast('添加成功'),
      );
    }).catchError((error) {
      ///添加对战错误处理
      _errorHandle(
        error,
        callback: () {
          battle(
            masterId: masterId,
            battleFuture: battleFuture,
            success: success,
          );
        },
      );
    });
  }

  ///
  /// 添加对战错误处理
  void _errorHandle(dynamic error,
      {required GestureTapCallback callback}) async {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
    if (error == null) {
      return;
    }
    String? message;
    if (error is DioException) {
      ///后端响应错误信息
      ResponseError resError = error.error as ResponseError;

      ///非会员使用提示
      if (resError.code == feeCode) {
        ///消耗账户金币信息
        showMemberDialog(callback);
        return;
      }
      message = resError.message;
    }
    Future.delayed(
      const Duration(milliseconds: 250),
      () => EasyLoading.showToast(message ?? '添加失败'),
    );
  }

  ///
  /// 激励视频广告提示dialog
  void showMemberDialog(GestureTapCallback callback) {
    showDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (context) {
        return Center(
          child: BattleMemberWidget(
            success: callback,
          ),
        );
      },
    );
  }

  ///
  /// 删除指定对战记录
  void removeBattle(int id) {
    EasyLoading.show();
    MasterBattleRepository.removeBattle(id).then((_) {
      battles.removeWhere((e) => e.id == id);
      if (battles.isEmpty) {
        state = RequestState.empty;
      }
      update();

      ///计算对战统计
      calcBattleCensus();
      Future.delayed(
        const Duration(milliseconds: 250),
        () => EasyLoading.showToast('删除成功'),
      );
    }).catchError((error) {
      Future.delayed(
        const Duration(milliseconds: 250),
        () => EasyLoading.showToast('删除失败'),
      );
    });
  }

  ///组件显示
  void opacityShow() {
    Future.delayed(const Duration(milliseconds: 10), () {
      opacity = 1;
      update();
    });
  }

  ///
  /// 显示加载动画
  void showLoading() {
    state = RequestState.loading;
    opacity = 0;
    update();
  }

  ///
  /// 加载成功判断
  void showSuccess() {
    state = battles.isNotEmpty ? RequestState.success : RequestState.empty;
    update();
    opacityShow();
  }

  ///
  /// 加载对战列表
  void loadBattles() {
    showLoading();
    battleLoader().then((value) {
      battles
        ..clear()
        ..addAll(value);
      ding = null;

      ///计算对战统计
      calcBattleCensus();
      Future.delayed(
        const Duration(milliseconds: 250),
        () => showSuccess(),
      );
    }).catchError((error) {
      if (error is DioException) {
        ResponseError respError = error.error as ResponseError;
        errorMsg = respError.message;
      }
      state = RequestState.error;
      update();
    });
  }

  List<String> first(List<Model> models, int num) {
    return models.sublist(0, num).map((e) => e.k).toList();
  }

  List<String> last(List<Model> models, int num) {
    List<Model> last = models.sublist(models.length - num);
    last.sort((e1, e2) => e1.v.compareTo(e2.v));
    return last.map((e) => e.k).toList();
  }

  List<Model> calcAndSort({
    required List<List<Model>> datas,
    required List<String> dataSet,
  }) {
    Map<String, Model> values = {};
    datas.expand((element) => element).forEach((e) {
      Model? model = values[e.k];
      if (model == null) {
        model = Model(k: e.k, v: 1);
        values[e.k] = model;
      } else {
        model.v = model.v + 1;
      }
    });
    List<Model> models = values.values.toList();
    if (models.length < dataSet.length) {
      for (var e in dataSet) {
        bool exist = models.any((model) => model.k == e);
        if (!exist) {
          models.add(Model(k: e, v: 0));
        }
      }
    }
    models.sort((e1, e2) => e2.v.compareTo(e1.v));
    return models;
  }

  ///
  /// 非分段计算
  BattleCensus calcBattle({
    required List<T> forecasts,
    required ForecastValueGetter<T> getter,
    required List<String> dataSet,
    int throttle = 5,
  }) {
    List<Model> models = calcAndSort(
      datas: forecasts.map((e) => getter(e).battle()).toList(),
      dataSet: dataSet,
    );

    return BattleCensus(
      max: first(models, throttle),
      min: last(models, throttle),
    );
  }

  ///
  /// 定位分段计算
  BattleSegCensus calcSegBattle({
    required List<T> forecasts,
    required ForecastValueGetter<T> getter,
    required List<String> dataSet,
    int throttle = 5,
  }) {
    List<List<List<Model>>> models =
        forecasts.map((e) => getter(e).segBattle()).toList();
    List<Model> bai =
        calcAndSort(datas: models.map((e) => e[0]).toList(), dataSet: dataSet);
    List<Model> shi =
        calcAndSort(datas: models.map((e) => e[1]).toList(), dataSet: dataSet);
    List<Model> ge =
        calcAndSort(datas: models.map((e) => e[2]).toList(), dataSet: dataSet);
    return BattleSegCensus(
      max: [first(bai, throttle), first(shi, throttle), first(ge, throttle)],
      min: [last(bai, throttle), last(shi, throttle), last(ge, throttle)],
    );
  }
}
