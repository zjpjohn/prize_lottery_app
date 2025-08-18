import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/env/log_profile.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_around.dart';
import 'package:prize_lottery_app/views/lottery/repository/lottery_info_repository.dart';

class LotteryAroundController extends AbsRequestController {
  ///
  /// 彩票类型
  late String type;

  /// 截图组件key
  late GlobalKey posterKey;

  /// 绕胆信息
  late LotteryAround around;

  ///绕胆图缓存信息
  Map<String, LotteryAround> arounds = {};

  /// 绕胆期号集合
  List<String> periods = [];

  ///期号下标
  int current = 0;

  String? _period;

  String? get period => _period;

  bool isFirst() {
    if (periods.isNotEmpty) {
      return current >= periods.length - 1;
    }
    return true;
  }

  bool isEnd() {
    return current <= 0;
  }

  void prevPeriod() {
    if (isFirst()) {
      return;
    }
    current = current + 1;
    period = periods[current];
  }

  void nextPeriod() {
    if (isEnd()) {
      return;
    }
    current = current - 1;
    period = periods[current];
  }

  set period(String? value) {
    if (value == null || value == _period) {
      return;
    }
    _period = value;
    LotteryAround? current = arounds[_period];
    if (current != null) {
      around = current;
    }
    update();
    if (current == null) {
      EasyLoading.show(status: '加载中');
      LotteryInfoRepository.lotteryAround(type: type, period: period)
          .then((value) {
        around = value;
        arounds[around.period] = value;
        update();
      }).catchError((error) {
        showError(error);
      }).whenComplete(() => EasyLoading.dismiss());
    }
  }

  @override
  void initialBefore() {
    type = Get.parameters['type']!;
    posterKey = GlobalKey();
  }

  List<Future<void>> asyncTask() {
    return [
      LotteryInfoRepository.aroundPeriods(type).then((value) {
        periods = value;
        if (periods.isNotEmpty) {
          _period = periods[0];
        }
      }),
      LotteryInfoRepository.lotteryAround(type: type).then((value) {
        around = value;
        arounds[around.period] = around;
        _period = around.period;
      })
    ];
  }

  @override
  Future<void> request() async {
    showLoading();
    Future.wait(asyncTask()).then((_) {
      Future.delayed(const Duration(milliseconds: 300), () {
        showSuccess(true);
      });
    }).catchError((error) {
      logger.e(error);
      showError(error);
    });
  }
}
