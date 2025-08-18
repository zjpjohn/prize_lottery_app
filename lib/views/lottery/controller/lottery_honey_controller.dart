import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_honey.dart';
import 'package:prize_lottery_app/views/lottery/repository/lottery_info_repository.dart';

class LotteryHoneyController extends AbsRequestController {
  ///
  /// 彩票类型
  late String type;

  ///截图组件key
  late GlobalKey posterKey;

  ///配胆信息
  late LotteryHoney honey;

  ///缓存配胆信息
  Map<String, LotteryHoney> honeys = {};

  ///推荐期号集合
  List<String> periods = [];

  ///当前期号
  String? _period;

  ///期号下标
  int current = 0;

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
    LotteryHoney? current = honeys[_period];
    if (current != null) {
      honey = current;
    }
    update();
    if (current == null) {
      EasyLoading.show(status: '加载中');
      LotteryInfoRepository.lotteryHoney(type: type, period: period)
          .then((value) {
        honey = value;
        honeys[honey.period] = value;
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

  List<Future<void>> asyncFutures() {
    return [
      LotteryInfoRepository.honeyPeriods(type).then((value) {
        periods = value;
        if (periods.isNotEmpty) {
          _period = periods[0];
        }
      }),
      LotteryInfoRepository.lotteryHoney(type: type).then((value) {
        honey = value;
        honeys[honey.period] = honey;
        _period = honey.period;
      }),
    ];
  }

  @override
  Future<void> request() async {
    showLoading();
    Future.wait(asyncFutures()).then((_) {
      Future.delayed(const Duration(milliseconds: 300), () {
        showSuccess(true);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
