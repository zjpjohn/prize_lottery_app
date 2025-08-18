import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/env/log_profile.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_omit.dart';
import 'package:prize_lottery_app/views/lottery/repository/lottery_info_repository.dart';

class LotteryPianController extends AbsRequestController {
  ///
  late String type;
  int _size = 20;

  ///
  List<PianOmit> omits = [];
  late PianCensus census;

  List<PianValue> get cb1 {
    return omits
        .map((e) =>
            PianValue(period: e.period, lottery: e.lottery, omits: e.cb1))
        .toList();
  }

  List<PianValue> get cb2 {
    return omits
        .map((e) =>
            PianValue(period: e.period, lottery: e.lottery, omits: e.cb2))
        .toList();
  }

  List<PianValue> get cb3 {
    return omits
        .map((e) =>
            PianValue(period: e.period, lottery: e.lottery, omits: e.cb3))
        .toList();
  }

  int get size => _size;

  set size(int value) {
    if (_size == value) {
      return;
    }
    _size = value;
    request();
    update();
  }

  @override
  Future<void> request() async {
    showLoading();
    LotteryInfoRepository.pianOmits(type: type, limit: _size).then((value) {
      omits
        ..clear()
        ..addAll(value)
        ..sort((e1, e2) => e1.period.compareTo(e2.period));
      if (omits.isNotEmpty) {
        census = PianCensus(omits);
      }
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(omits);
      });
    }).catchError((error) {
      logger.e(error);
      showError(error);
    });
  }

  @override
  void initialBefore() {
    super.initialBefore();
    type = Get.parameters['type']!;
  }
}

class PianValue {
  late String period;
  late String lottery;
  late Map<int, Omit> omits;

  PianValue({required this.period, required this.lottery, required this.omits});

  List<String> balls() {
    String trimmed = lottery.trim();
    return trimmed.isEmpty ? [] : trimmed.trim().split(RegExp('\\s+'));
  }
}
