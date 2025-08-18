import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:prize_lottery_app/base/controller/fee_request_controller.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/base/model/request_state.dart';
import 'package:prize_lottery_app/utils/request.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_index.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_pick.dart';
import 'package:prize_lottery_app/views/lottery/repository/lottery_index_repository.dart';

class Fc3dIntellectController extends AbsRequestController {
  ///
  ///
  final String type = 'fc3d';

  ///
  final GlobalKey posterKey = GlobalKey();

  ///
  List<String> periods = [];

  ///当前期号
  String? _period;

  ///当前期号位置下标
  int current = 0;

  ///选彩指数
  LotteryIndex? lotteryIndex;

  ///选号记录
  LotteryPick? pick;

  ///选中号码
  LotteryN3Pick pickDto = LotteryN3Pick();

  ///是否需要付费
  bool feeRequired = false;

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
    if (period != null && _period != period) {
      _period = period;
      pickDto = LotteryN3Pick();
      update();
      EasyLoading.show(status: '加载中');
      Future.wait([
        LotteryIndexRepository.lotteryIndex(
          type: type,
          period: _period,
        ).then((value) => lotteryIndex = value),
        LotteryIndexRepository.lotteryPick(
          lottery: type,
          period: _period!,
        ).then((value) {
          pick = value;
          if (pick != null) {
            pickDto = pick!.n3Pick!;
          }
        }),
      ]).then((value) {
        feeRequired = false;
        update();
      }).catchError((error) {
        showError(error, handle: (result) {
          lotteryIndex = null;
          pickDto = LotteryN3Pick();
          return showFee(result);
        });
      }).whenComplete(() => EasyLoading.dismiss());
    }
  }

  bool _canLottoPick() {
    return lotteryIndex != null && lotteryIndex!.lottery == null;
  }

  void pickBall(int position, String ball) {
    //选彩指数或者已开奖不允许选号
    if (!_canLottoPick()) {
      return;
    }
    switch (position) {
      case 0:
        if (!pickDto.bai.contains(ball)) {
          pickDto.bai.add(ball);
        } else {
          pickDto.bai.remove(ball);
        }
        update();
        break;
      case 1:
        if (!pickDto.shi.contains(ball)) {
          pickDto.shi.add(ball);
        } else {
          pickDto.shi.remove(ball);
        }
        update();
        break;
      case 2:
        if (!pickDto.ge.contains(ball)) {
          pickDto.ge.add(ball);
        } else {
          pickDto.ge.remove(ball);
        }
        update();
    }
  }

  void saveLottoPick() {
    if (!_canLottoPick()) {
      EasyLoading.showToast('已开奖不允许选号');
      return;
    }
    if (pickDto.bai.isEmpty || pickDto.shi.isEmpty || pickDto.ge.isEmpty) {
      EasyLoading.showToast('请正确选择号码');
      return;
    }
    EasyLoading.show(status: '正在保存');
    LotteryIndexRepository.lottoN3Pick(
      lottery: type,
      period: _period!,
      balls: [pickDto.bai, pickDto.shi, pickDto.ge],
    ).then((value) {
      EasyLoading.showToast('保存成功');
    }).catchError((error) {
      EasyLoading.showToast('保存失败');
    });
  }

  List<Future<void>> asyncTasks() {
    return [
      LotteryIndexRepository.lotteryPick(lottery: type).then((value) {
        pick = value;
        if (pick != null) {
          pickDto = pick!.n3Pick!;
        }
      }),
      LotteryIndexRepository.indexPeriods(type).then((value) {
        periods = value;
        if (periods.isNotEmpty) {
          _period = periods[0];
        }
      }),
      LotteryIndexRepository.lotteryIndex(type: type, period: _period)
          .then((value) {
        lotteryIndex = value;
        if (lotteryIndex != null) {
          _period ??= lotteryIndex!.period;
        }
      }),
    ];
  }

  @override
  Future<void> request() async {
    showLoading();
    Future.wait(asyncTasks()).then((_) {
      feeRequired = false;
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(periods);
      });
    }).catchError((error) {
      showError(error, handle: showFee);
    });
  }

  bool showFee(ResponseError error) {
    feeRequired = error.code == feeCode;
    if (feeRequired) {
      state = RequestState.success;
    }
    update();
    return feeRequired;
  }
}
