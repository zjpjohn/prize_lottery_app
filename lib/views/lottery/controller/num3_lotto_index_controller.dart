import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/fee_request_controller.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/base/model/request_state.dart';
import 'package:prize_lottery_app/utils/request.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_index.dart';
import 'package:prize_lottery_app/views/lottery/repository/lottery_index_repository.dart';

class Num3LottoIndexController extends AbsRequestController {
  final GlobalKey posterKey = GlobalKey();
  late String type;
  List<String> periods = [];
  String? _period;
  int current = 0;
  Num3LottoIndex? index;
  bool feeRequired = false;
  Map<String, Num3LottoIndex> indices = {};

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

  void prePeriod() {
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
    if (indices[period] != null) {
      index = indices[period]!;
    }
    update();
    if (indices[period] == null) {
      EasyLoading.show(status: '加载中');
      LotteryIndexRepository.num3Index(type: type, period: period)
          .then((value) {
        feeRequired = false;
        index = value;
        if (index != null) {
          indices[index!.period] = value;
        }
        update();
      }).catchError((error) {
        showError(error, handle: (result) {
          index = null;
          return showFee(result);
        });
      }).whenComplete(() => EasyLoading.dismiss());
    }
  }

  bool showFee(ResponseError error) {
    feeRequired = error.code == feeCode;
    if (feeRequired) {
      state = RequestState.success;
    }
    update();
    return feeRequired;
  }

  void rewardSuccess() {
    LotteryIndexRepository.num3Index(type: type, period: _period).then((value) {
      index = value;
      if (index != null) {
        _period = value.period;
        indices[value.period] = value;
      }
      update();
    }).catchError((error) {
      showError(error, handle: (result) {
        index = null;
        return showFee(result);
      });
    });
  }

  @override
  Future<void> request() async {
    showLoading();
    Future.wait([
      LotteryIndexRepository.num3IndexPeriods(type)
          .then((value) => periods = value),
      LotteryIndexRepository.num3Index(type: type, period: _period)
          .then((value) {
        index = value;
        if (index != null) {
          _period = value.period;
          indices[value.period] = value;
        }
      })
    ]).then((_) {
      feeRequired = false;
      Future.delayed(const Duration(milliseconds: 250), () {
        showSuccess(periods);
      });
    }).catchError((error) {
      showError(error, handle: showFee);
    });
  }

  @override
  void initialBefore() {
    type = Get.parameters['type']!;
  }
}
