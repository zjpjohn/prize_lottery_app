import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/utils/combine_utils.dart';
import 'package:prize_lottery_app/views/lottery/model/award_level.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_info.dart';
import 'package:prize_lottery_app/views/lottery/repository/lottery_info_repository.dart';

class QlcCalculatorController extends AbsRequestController {
  ///
  late LotteryInfo lottery;

  ///红球选号个数集合
  final List<int> reds = [8, 9, 10, 11, 12, 13, 14, 15, 16];

  ///选中号码个数
  late int _pRed = 8;

  ///命中号码个数
  late int _hitRed = 4;

  ///特别号码
  late int _hitBlue = 0;

  ///总投注数
  int total = 0;

  ///
  ///
  List<AwardCounter> counters = [
    AwardCounter(
      level: AwardLevel(
        idx: 1,
        level: '一等奖',
        red: 7,
        blue: 0,
        award: 1,
        tRed: 7,
        tBlue: 0,
      ),
    ),
    AwardCounter(
      level: AwardLevel(
        idx: 2,
        level: '二等奖',
        red: 6,
        blue: 1,
        award: 1,
        tRed: 7,
        tBlue: 0,
      ),
    ),
    AwardCounter(
      level: AwardLevel(
        idx: 3,
        level: '三等奖',
        red: 6,
        blue: 0,
        award: 1,
        tRed: 7,
        tBlue: 0,
      ),
    ),
    AwardCounter(
      level: AwardLevel(
        idx: 4,
        level: '四等奖',
        red: 5,
        blue: 1,
        award: 200,
        tRed: 7,
        tBlue: 0,
      ),
    ),
    AwardCounter(
      level: AwardLevel(
        idx: 5,
        level: '五等奖',
        red: 5,
        blue: 0,
        award: 50,
        tRed: 7,
        tBlue: 0,
      ),
    ),
    AwardCounter(
      level: AwardLevel(
        idx: 6,
        level: '六等奖',
        red: 4,
        blue: 1,
        award: 10,
        tRed: 7,
        tBlue: 0,
      ),
    ),
    AwardCounter(
      level: AwardLevel(
        idx: 7,
        level: '七等奖',
        red: 4,
        blue: 0,
        award: 5,
        tRed: 7,
        tBlue: 0,
      ),
    ),
  ];

  set pRed(int pRed) {
    _pRed = pRed;
    update();
  }

  int get pRed => _pRed;

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

  void calcAwardCounter() {
    EasyLoading.show(status: '计算中');
    Future.delayed(const Duration(milliseconds: 250), () {
      ///计算总投注
      total = Combination.combine(pRed, 7);

      ///预计中奖计算
      for (var e in counters) {
        e.count = 0;
        e.award = 0;
        AwardLevel level = e.level;

        ///选8码，命中7+1特殊
        if (_hitRed + _hitBlue == _pRed &&
            level.red + level.blue == level.tRed) {
          e.qlcCalcAward(nRed: _pRed, hitRed: _hitRed, hitBlue: _hitBlue);
        } else if (level.red <= _hitRed && level.blue <= _hitBlue) {
          e.qlcCalcAward(nRed: _pRed, hitRed: _hitRed, hitBlue: _hitBlue);
        }
      }
      update();
    }).then((value) => EasyLoading.dismiss());
  }

  @override
  Future<void> request() async {
    showLoading();
    LotteryInfoRepository.latestLottery('qlc').then((value) {
      lottery = value;
      Future.delayed(const Duration(milliseconds: 250), () {
        showSuccess(lottery);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
