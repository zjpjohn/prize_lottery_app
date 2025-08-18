import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/page_controller.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_info.dart';
import 'package:prize_lottery_app/views/lottery/repository/lottery_info_repository.dart';

class LotteryHistoryController extends AbsPageQueryController {
  ///
  /// 分页查询条件
  late LotteryHistoryQuery query;

  ///
  int total = 0;

  ///
  List<LotteryInfo> lotteries = [];

  @override
  Future<void> onInitial() async {
    showLoading();
    query.page = 1;
    LotteryInfoRepository.historyLotteries(query.toJson()).then((value) {
      total = value.total;
      lotteries
        ..clear()
        ..addAll(value.records);
      Future.delayed(const Duration(milliseconds: 250), () {
        showSuccess(lotteries);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onLoadMore() async {
    if (lotteries.length == total) {
      EasyLoading.showToast('没有更多数据');
      return;
    }
    query.page++;
    await LotteryInfoRepository.historyLotteries(query.toJson()).then((value) {
      lotteries.addAll(value.records);
      Future.delayed(const Duration(milliseconds: 200), () {
        update();
      });
    }).catchError((error) {
      query.page--;
      showError(error);
    });
  }

  @override
  Future<void> onRefresh() async {
    query.page = 1;
    await LotteryInfoRepository.historyLotteries(query.toJson()).then((value) {
      total = value.total;
      lotteries
        ..clear()
        ..addAll(value.records);
      showSuccess(lotteries);
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  void initialBefore() {
    query = LotteryHistoryQuery(type: Get.parameters['type']!);
  }
}

class LotteryHistoryQuery {
  ///
  /// 彩种类型
  String type;

  ///分页页码
  int page;

  ///每页数据量
  int limit;

  LotteryHistoryQuery({
    required this.type,
    this.page = 1,
    this.limit = 10,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['type'] = type;
    json['page'] = page;
    json['limit'] = limit;
    return json;
  }
}
