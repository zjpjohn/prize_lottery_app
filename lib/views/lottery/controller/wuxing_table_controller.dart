import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/utils/screen_protect.dart';
import 'package:prize_lottery_app/utils/wuxing_table.dart';
import 'package:prize_lottery_app/views/lottery/repository/lottery_info_repository.dart';

class WuXingTableController extends AbsRequestController {
  ///开奖类型
  late String type;

  ///速查表信息
  late WuXing wuXing;
  Map<String, WuXing> cache = {};

  ///当前期号
  String? _period;
  int current = 0;
  List<String> periods = [];

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

  set period(String? period) {
    if (period == null || _period == period) {
      return;
    }
    _period = period;
    if (cache[_period] != null) {
      wuXing = cache[_period]!;
    }
    update();
    if (cache[_period] == null) {
      EasyLoading.show(status: '加载中');
      LotteryInfoRepository.wuXingTable(type: type, period: _period)
          .then((value) {
        wuXing = value;
        cache[_period!] = wuXing;
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

  @override
  Future<void> request() async {
    showLoading();
    Future.wait(asyncTasks()).then((_) {
      Future.delayed(const Duration(milliseconds: 250), () {
        showSuccess(wuXing);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  void initialBefore() {
    type = Get.parameters['type']!;

    ///开启数据保护
    ScreenProtect.protectOn();
  }

  @override
  void onClose() {
    super.onClose();

    ///关闭数据保护
    ScreenProtect.protectOff();
  }

  List<Future<void>> asyncTasks() {
    return [
      LotteryInfoRepository.num3LotteryPeriods(type).then((value) {
        periods = value;
        if (periods.isNotEmpty) {
          _period = periods[0];
        }
      }),
      LotteryInfoRepository.wuXingTable(type: type).then((value) {
        wuXing = value;
        cache[wuXing.current.period] = wuXing;
      })
    ];
  }
}
