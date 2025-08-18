import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_info.dart';
import 'package:prize_lottery_app/views/lottery/repository/lottery_info_repository.dart';

class Num3FollowController extends AbsRequestController {
  ///
  /// 彩种类型
  late String type;

  ///当前期号
  String? _period;
  int current = 0;
  List<String> periods = [];

  ///历史跟随数据
  List<Num3LottoFollow> data = [];
  Map<String, List<Num3LottoFollow>> cache = {};

  bool get isFirst {
    if (periods.isNotEmpty) {
      return current >= periods.length - 1;
    }
    return true;
  }

  bool get isEnd {
    return current <= 0;
  }

  void prevPeriod() {
    if (isFirst) {
      return;
    }
    current = current + 1;
    period = periods[current];
  }

  void nextPeriod() {
    if (isEnd) {
      return;
    }
    current = current - 1;
    period = periods[current];
  }

  String? get period => _period;

  set period(String? period) {
    if (period == null || _period == period) {
      return;
    }
    _period = period;
    if (cache[_period] != null) {
      data = cache[_period]!;
    }
    update();
    if (cache[_period] == null) {
      EasyLoading.show(status: '加载中');
      LotteryInfoRepository.num3Follows(type: type, period: _period)
          .then((value) {
        data = value;
        cache[_period!] = data;
        update();
      }).catchError((error) {
        showError(error);
      }).whenComplete(() {
        Future.delayed(const Duration(milliseconds: 200), () {
          EasyLoading.dismiss();
        });
      });
    }
  }

  bool get isParameter {
    return Get.parameters['period'] != null;
  }

  List<Future<void>> asyncTasks() {
    return [
      if (!isParameter)
        LotteryInfoRepository.lotteryPeriods(type).then((value) {
          periods = value;
          if (periods.isNotEmpty) {
            _period = periods[0];
          }
        }),
      LotteryInfoRepository.num3Follows(type: type, period: _period)
          .then((value) {
        data = value;
        if (data.isNotEmpty) {
          cache[data[0].period] = data;
        }
      }),
    ];
  }

  @override
  Future<void> request() async {
    showLoading();
    Future.wait(asyncTasks()).then((_) {
      Future.delayed(const Duration(milliseconds: 250), () {
        showSuccess(true);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  void initialBefore() {
    type = Get.parameters['type']!;
    _period = Get.parameters['period'];
  }
}
