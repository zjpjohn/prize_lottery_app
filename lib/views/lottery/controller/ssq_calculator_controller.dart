import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/utils/combine_utils.dart';
import 'package:prize_lottery_app/views/lottery/model/award_level.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_info.dart';
import 'package:prize_lottery_app/views/lottery/repository/lottery_info_repository.dart';

class SsqCalculatorController extends AbsRequestController {
  ///
  late LotteryInfo lottery;

  ///蓝球选号个数集合
  final List<int> reds = [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18];

  ///选中号码个数
  late int _pRed = 7;
  late int _pBlue = 1;

  ///命中号码个数
  late int _hitRed = 4;
  late int _hitBlue = 1;

  /// 总投注数
  int total = 0;

  ///
  List<AwardCounter> counters = [
    AwardCounter(
      level: AwardLevel(
        idx: 1,
        level: '一等奖',
        red: 6,
        blue: 1,
        award: 1,
        tRed: 6,
        tBlue: 1,
      ),
    ),
    AwardCounter(
      level: AwardLevel(
        idx: 2,
        level: '二等奖',
        red: 6,
        blue: 0,
        award: 1,
        tRed: 6,
        tBlue: 1,
      ),
    ),
    AwardCounter(
      level: AwardLevel(
        idx: 3,
        level: '三等奖',
        red: 5,
        blue: 1,
        award: 3000,
        tRed: 6,
        tBlue: 1,
      ),
    ),
    AwardCounter(
      level: AwardLevel(
        idx: 4,
        level: '四等奖',
        red: 5,
        blue: 0,
        award: 200,
        tRed: 6,
        tBlue: 1,
      ),
    ),
    AwardCounter(
      level: AwardLevel(
        idx: 4,
        level: '四等奖',
        red: 4,
        blue: 1,
        award: 200,
        tRed: 6,
        tBlue: 1,
      ),
    ),
    AwardCounter(
      level: AwardLevel(
        idx: 5,
        level: '五等奖',
        red: 4,
        blue: 0,
        award: 10,
        tRed: 6,
        tBlue: 1,
      ),
    ),
    AwardCounter(
      level: AwardLevel(
        idx: 5,
        level: '五等奖',
        red: 3,
        blue: 1,
        award: 10,
        tRed: 6,
        tBlue: 1,
      ),
    ),
    AwardCounter(
      level: AwardLevel(
        idx: 6,
        level: '六等奖',
        red: 2,
        blue: 1,
        award: 5,
        tRed: 6,
        tBlue: 1,
      ),
    ),
    AwardCounter(
      level: AwardLevel(
        idx: 6,
        level: '六等奖',
        red: 1,
        blue: 1,
        award: 5,
        tRed: 6,
        tBlue: 1,
      ),
    ),
    AwardCounter(
      level: AwardLevel(
        idx: 6,
        level: '六等奖',
        red: 0,
        blue: 1,
        award: 5,
        tRed: 6,
        tBlue: 1,
      ),
    ),
  ];

  set pRed(int pRed) {
    _pRed = pRed;
    update();
  }

  int get pRed => _pRed;

  set pBlue(int pBlue) {
    _pBlue = pBlue;
    update();
  }

  int get pBlue => _pBlue;

  set hitRed(int hitRed) {
    _hitRed = hitRed;
    update();
  }

  int get hitRed => _hitRed;

  set hitBlue(int hitBlue) {
    _hitBlue = hitBlue;
    update();
  }

  int get hitBlue => _hitBlue;

  ///
  /// 计算选号中奖金额
  void calcCounters() {
    EasyLoading.show(status: '计算中');
    Future.delayed(const Duration(milliseconds: 250), () {
      ///总投注数
      total = Combination.combine(pRed, 6) * Combination.combine(pBlue, 1);

      ///预计中奖计算
      for (var e in counters) {
        e.count = 0;
        e.award = 0;
        AwardLevel level = e.level;
        if (level.red <= _hitRed &&
            _hitRed - level.red <= _pRed - 6 &&
            level.blue <= _hitBlue &&
            _hitBlue - level.blue <= _pBlue - 1) {
          e.calcAward(
            pRed: _pRed,
            pBlue: _pBlue,
            hitRed: _hitRed,
            hitBlue: _hitBlue,
          );
        }
      }
      update();
    }).then((value) => EasyLoading.dismiss());
  }

  @override
  Future<void> request() async {
    showLoading();
    LotteryInfoRepository.latestLottery('ssq').then((value) {
      lottery = value;
      Future.delayed(const Duration(milliseconds: 250), () {
        showSuccess(lottery);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
