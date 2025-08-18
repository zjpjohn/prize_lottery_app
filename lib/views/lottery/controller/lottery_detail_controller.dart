import 'dart:async';

import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_detail.dart';
import 'package:prize_lottery_app/views/lottery/repository/lottery_info_repository.dart';
import 'package:prize_lottery_app/views/master/model/random_master.dart';
import 'package:prize_lottery_app/views/master/repository/lotto_master_repository.dart';

typedef RecommendCall = Future<List<RandomMaster>> Function();

class LotteryDetailController extends AbsRequestController {
  ///
  late Map<String, RecommendCall> recommendCalls = {};

  /// 显示中奖级别
  int limit = 3;

  ///彩种类型
  late String type;

  ///开奖期号
  late String period;

  ///开奖详情
  LotteryDetail? lottery;

  ///推荐专家列表
  List<RandomMaster> masters = [];

  /// 显示全部中奖级别
  void showAllLevel() {
    limit = lottery!.levels.length;
    update();
  }

  @override
  Future<void> request() async {
    showLoading();
    if (type == 'kl8') {
      LotteryInfoRepository.lotteryDetail(type: type, period: period)
          .then((value) {
        lottery = value;
        Future.delayed(const Duration(milliseconds: 250), () {
          showSuccess(lottery);
        });
      }).catchError((error) {
        showError(error);
      });
      return;
    }

    //开奖详情
    Future<LotteryDetail> lotteryFuture =
        LotteryInfoRepository.lotteryDetail(type: type, period: period);
    //随机推荐专家
    Future<List<RandomMaster>> masterFuture = recommendCalls[type]!();

    ///
    Future.wait([lotteryFuture, masterFuture]).then((values) {
      lottery = values[0] as LotteryDetail?;
      masters
        ..clear()
        ..addAll(values[1] as List<RandomMaster>);
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(lottery);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  void initialBefore() {
    type = Get.parameters['type']!;
    period = Get.parameters['period']!;
    recommendCalls = {
      'fc3d': () => LottoMasterRepository.fc3dRandomRecommends(),
      'pl3': () => LottoMasterRepository.pl3RandomRecommends(),
      'pl5': () => LottoMasterRepository.pl3RandomRecommends(),
      'ssq': () => LottoMasterRepository.ssqRandomRecommends(),
      'dlt': () => LottoMasterRepository.dltRandomRecommends(),
      'qlc': () => LottoMasterRepository.qlcRandomRecommends(),
    };
  }
}
